# encoding: utf-8

"""
openbikebox Backend
Copyright (C) 2021 binary butterfly GmbH

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

from random import randint
from datetime import timedelta
from flask import current_app
from ..extensions import db
from ..models import Action, Resource
from ..common.response import error_response, success_response
from ..common.enum import ActionStatus, ResourceStatus
from ..common.helpers import get_now, get_current_time_local, unlocalize_datetime
from ..common.exceptions import BikeBoxAccessDeniedException, BikeBoxNotExistingException
from .ActionApiHelper import check_reservation_timeout
from .ActionForms import ReserveForm, BookingForm, CancelForm, RenewForm, ExtendForm


def action_reserve_handler(data: dict, source: str) -> dict:
    form = ReserveForm(data=data)
    if not form.validate():
        return error_response(form.errors)
    resource = Resource.query.get(form.resource_id.data)
    if not resource:
        return error_response('invalid resource')
    if resource.location.operator.id not in current_app.config['BASICAUTH'][source]['capabilities']:
        return error_response('client is not allowed to book the resource')
    if resource.status != ResourceStatus.free:
        return error_response('resource not free')
    if not (form.predefined_daterange.data or (form.begin.data and form.end.data)):
        return error_response('either begin + end or predefined_daterange is required')
    if form.predefined_daterange.data:
        begin = get_current_time_local().replace(microsecond=0)
        form.begin.data = unlocalize_datetime(begin).strftime('%Y-%m-%dT%H:%M:%SZ')
        if form.predefined_daterange.data == 'day':
            form.end.data = unlocalize_datetime((begin + timedelta(days=2)).replace(hour=0, minute=0, second=0)).strftime('%Y-%m-%dT%H:%M:%SZ')
        elif form.predefined_daterange.data == 'week':
            form.end.data = unlocalize_datetime((begin + timedelta(days=8)).replace(hour=0, minute=0, second=0)).strftime('%Y-%m-%dT%H:%M:%SZ')
        elif form.predefined_daterange.data == 'month':
            form.end.data = unlocalize_datetime((begin + timedelta(days=32)).replace(hour=0, minute=0, second=0)).strftime('%Y-%m-%dT%H:%M:%SZ')
        else:
            form.end.data = unlocalize_datetime((begin + timedelta(days=366)).replace(hour=0, minute=0, second=0)).strftime('%Y-%m-%dT%H:%M:%SZ')
    action = Action()
    form.populate_obj(action)
    action.set_cache(resource)
    if not action.calculate():
        return error_response('price not set for this daterange')
    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    resource.status = ResourceStatus.reserved
    resource.unavailable_until = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    db.session.add(resource)
    db.session.add(action)
    db.session.commit()

    check_reservation_timeout.apply_async((resource.id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])

    return success_response(action.to_dict(extended=True, remove_none=True))


def action_cancel_handler(data: dict, source: str) -> dict:
    form = CancelForm(data=data)
    if not form.validate():
        return error_response(form.errors)
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status == ActionStatus.cancelled:
        return error_response('action already free')
    if action.status == ActionStatus.booked:
        return error_response('action already booked')
    if action.source != source:
        return error_response('invalid source')
    action.status = ActionStatus.cancelled
    db.session.add(action)

    resource = action.resource
    if resource.status == ResourceStatus.reserved:
        resource.status = ResourceStatus.free
        resource.unavailable_until = None
        db.session.add(resource)

    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_renew_handler(data: dict, source: str) -> dict:
    form = RenewForm(data=data)
    if not form.validate():
        return error_response(form.errors)
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status == ActionStatus.booked:
        return error_response('action already booked')
    if action.source != source:
        return error_response('invalid source')
    resource = action.resource
    if resource.status not in [ResourceStatus.free, ResourceStatus.reserved] and resource.unavailable_until > action.begin:
        return error_response('resource not free')

    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.status = ActionStatus.reserved
    db.session.add(action)

    resource.status = ResourceStatus.reserved
    resource.unavailable_until = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    db.session.add(resource)

    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_book_handler(data: dict, source: str) -> dict:
    form = BookingForm(data=data)
    if not form.validate():
        return {
            'status': -1,
            'errors': form.errors
        }
    # TODO: use new validation system to prevent manual check
    if 'token' not in data \
            or not len(data['token']) \
            or 'type' not in data['token'][0] \
            or data['token'][0]['type'] != 'code':
        return error_response('invalid token')
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    except BikeBoxAccessDeniedException:
        return error_response('invalid credentials')
    if action.status not in [ActionStatus.reserved, ActionStatus.cancelled]:
        return error_response('action already booked')
    if action.source != source:
        return error_response('invalid source')
    resource = action.resource
    if resource.status not in [ResourceStatus.free, ResourceStatus.reserved] and resource.unavailable_until > action.begin:
        return error_response('resource not free')
    form.populate_obj(action)
    if 'identifier' in data['token'][0] and data['token'][0]['identifier'] is not None:
        action.pin = data['token'][0]['identifier']
    else:
        action.pin = '%04d' % randint(0, 9999)
    action.status = ActionStatus.booked

    resource.status = ResourceStatus.taken
    resource.unavailable_until = action.end
    db.session.add(resource)

    db.session.add(action)
    db.session.commit()

    return success_response(action.to_dict(extended=True, remove_none=True))


def action_extend_handler(data: dict, source: str):
    form = ExtendForm(data=data)
    if not form.validate():
        return error_response(form.errors)
    try:
        old_action = Action.apiget(form.old_uid.data, form.old_request_uid.data, form.old_session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')

    if old_action.status != ActionStatus.booked:
        return error_response('old action was not booked')
    if old_action.end < get_now():
        return error_response('old action already ended')

    action = Action()
    form.populate_obj(action)
    if form.predefined_daterange.data:
        begin = get_now().replace(microsecond=0)
        form.begin.data = begin.strftime('%Y-%m-%dT%H:%M:%SZ')
        if form.predefined_daterange.data == 'day':
            form.end.data = (begin + timedelta(days=2)).replace(hour=0, minute=0, second=0).strftime('%Y-%m-%dT%H:%M:%SZ')
        elif form.predefined_daterange.data == 'week':
            form.end.data = (begin + timedelta(days=8)).replace(hour=0, minute=0, second=0).strftime('%Y-%m-%dT%H:%M:%SZ')
        elif form.predefined_daterange.data == 'month':
            form.end.data = (begin + timedelta(days=32)).replace(hour=0, minute=0, second=0).strftime('%Y-%m-%dT%H:%M:%SZ')
        else:
            form.end.data = (begin + timedelta(days=366)).replace(hour=0, minute=0, second=0).strftime('%Y-%m-%dT%H:%M:%SZ')
    elif not form.begin.data or not form.end.data:
        action.begin = old_action.end
        action.end = action.begin + (old_action.end - old_action.begin)
    action.set_cache(old_action.resource)
    if not action.calculate():
        return error_response('price not set for this daterange')
    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    db.session.add(action)
    db.session.commit()

    check_reservation_timeout.apply_async((action.resource_id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])

    return success_response(action.to_dict(extended=True, remove_none=True))
