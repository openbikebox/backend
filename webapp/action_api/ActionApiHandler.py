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
from ..enum import ActionStatus
from ..common.helpers import get_now
from ..common.exceptions import BikeBoxAccessDeniedException, BikeBoxNotExistingException
from .ActionForms import ReserveForm, BookingForm, CancelForm, RenewForm, ExtendForm
from ..services.action.ActionHelper import calculate_price, calculate_begin_end, check_reservation_timeout_delay
from ..services.resource.ResourceHelper import resource_free_between
from ..services.resource.ResourceStatusService import update_resource_status_delay, update_resource_status


def action_reserve_handler(data: dict, source: str) -> dict:
    form = ReserveForm(data)
    if not form.validate():
        return error_response(form.errors)
    resource = Resource.query.get(form.resource_id.data)
    if not resource:
        return error_response('invalid resource')
    if resource.location.operator.id not in current_app.config['BASICAUTH'][source]['capabilities']:
        return error_response('client is not allowed to book the resource')
    if not (form.predefined_daterange.data or (form.begin.data and form.end.data)):
        return error_response('either begin + end or predefined_daterange is required')
    if form.begin.data and form.begin.data > (get_now() + timedelta(minutes=2)) and not resource.future_booking:
        return error_response('resource does not allow future booking')
    begin, end = calculate_begin_end(form.predefined_daterange.data, form.begin.data, form.end.data)
    if not resource_free_between(resource.id, begin, end):
        return error_response('resource not free')

    action = Action()
    form.populate_obj(action, exclude=['begin', 'end'])
    action.begin = begin
    action.end = end
    action.set_cache(resource)
    if not calculate_price(action):
        return error_response('price not set for this daterange')
    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    db.session.add(action)
    db.session.commit()
    update_resource_status(resource=resource)
    check_reservation_timeout_delay.apply_async((resource.id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_cancel_handler(data: dict, source: str) -> dict:
    form = CancelForm(data)
    if not form.validate():
        return error_response(form.errors)
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status == ActionStatus.cancelled:
        return error_response('action already cancelled')
    if action.status == ActionStatus.booked:
        return error_response('action already booked')
    if action.source != source:
        return error_response('invalid source')
    action.status = ActionStatus.cancelled
    db.session.add(action)
    db.session.commit()
    update_resource_status_delay.delay(action.resource_id)
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_renew_handler(data: dict, source: str) -> dict:
    form = RenewForm(data)
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
    if not resource_free_between(resource.id, action.begin, action.end, exclude_ids=[action.id]):
        return error_response('resource not free')

    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.status = ActionStatus.reserved
    db.session.add(action)
    check_reservation_timeout_delay.apply_async((action.resource_id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])

    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_book_handler(data: dict, source: str) -> dict:
    form = BookingForm(data)
    if not form.validate():
        error_response(form.errors)
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
    if not resource_free_between(resource.id, action.begin, action.end, exclude_ids=[action.id]):
        return error_response('resource not free')
    form.populate_obj(action)
    if form.token.entries[0].fields.identifier.data:
        action.pin = form.token.entries[0].fields.identifier.data
    else:
        action.pin = '%04d' % randint(0, 9999)
    action.status = ActionStatus.booked

    update_resource_status_delay.delay(resource.id)
    db.session.add(resource)

    db.session.add(action)
    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_extend_handler(data: dict, source: str):
    form = ExtendForm(data)
    if not form.validate():
        return error_response(form.errors)
    try:
        old_action = Action.apiget(form.old_uid.data, form.old_request_uid.data, form.old_session.data)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    resource = Resource.query.get(old_action.resource_id)

    if old_action.status != ActionStatus.booked:
        return error_response('old action was not booked')
    if old_action.end < get_now():
        return error_response('old action already ended')
    if form.begin.data and form.begin.data > (get_now() + timedelta(minutes=2)):
        return error_response('extending booking infuture booking')
    autocalculated_end = (old_action.end + (old_action.end - old_action.begin) + timedelta(hours=1)).replace(hour=0)
    begin, end = calculate_begin_end(form.predefined_daterange.data, old_action.end, form.end.data or autocalculated_end)
    if not resource_free_between(resource.id, begin, end):
        return error_response('resource not free')

    action = Action()
    form.populate_obj(action, exclude=['begin', 'end'])
    action.begin = begin
    action.end = end
    action.set_cache(resource)
    if not calculate_price(action):
        return error_response('price not set for this daterange')
    action.valid_till = get_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    db.session.add(action)
    db.session.commit()

    check_reservation_timeout_delay.apply_async((action.resource_id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])
    return success_response(action.to_dict(extended=True, remove_none=True))
