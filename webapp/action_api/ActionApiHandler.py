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
from validataclass.helpers import UnsetValue
from validataclass.validators import DataclassValidator
from validataclass.exceptions import ValidationError
from flask import current_app
from webapp.extensions import db
from webapp.models import Action, Resource
from webapp.common.response import error_response, success_response
from webapp.enum import ActionStatus
from webapp.common.helpers import get_now, get_json, get_utc_now
from webapp.common.exceptions import BikeBoxAccessDeniedException, BikeBoxNotExistingException
from .ActionValidators import ReserveInput, BookingInput, CancelInput, RenewInput, ExtendInput, OpenCloseInput
from webapp.services.action.ActionHelper import calculate_price, calculate_begin_end, check_reservation_timeout_delay
from webapp.services.resource.ResourceHelper import resource_free_between
from webapp.services.resource.ResourceStatusService import update_resource_status_delay, update_resource_status

reserve_validator: DataclassValidator[ReserveInput] = DataclassValidator(ReserveInput)
cancel_validator: DataclassValidator[CancelInput] = DataclassValidator(CancelInput)
renew_validator: DataclassValidator[RenewInput] = DataclassValidator(RenewInput)
extend_validator: DataclassValidator[ExtendInput] = DataclassValidator(ExtendInput)
booking_validator: DataclassValidator[BookingInput] = DataclassValidator(BookingInput)
open_close_validator: DataclassValidator[OpenCloseInput] = DataclassValidator(OpenCloseInput)


def action_reserve_handler(data: dict, source: str) -> dict:
    try:
        reserve_input = reserve_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    resource = Resource.query.get(reserve_input.resource_id)
    if not resource:
        return error_response('invalid resource')
    if resource.location.operator.id not in current_app.config['BASICAUTH'][source]['capabilities']:
        return error_response('client is not allowed to book the resource')
    if not (reserve_input.predefined_daterange or (reserve_input.begin and reserve_input.end)):
        return error_response('either begin + end or predefined_daterange is required')
    if reserve_input.begin and reserve_input.begin > (get_utc_now() + timedelta(minutes=2)) and not resource.future_booking:
        return error_response('resource does not allow future booking')
    begin, end = calculate_begin_end(reserve_input.predefined_daterange, reserve_input.begin, reserve_input.end)
    if not resource_free_between(resource.id, begin, end):
        return error_response('resource not free')

    action = Action()
    for key, value in reserve_input.to_dict().items():
        if value is UnsetValue or key in ['begin', 'end']:
            continue
        setattr(action, key, value)
    action.begin = begin
    action.end = end
    action.auth_methods = resource.hardware.supported_auth_methods
    action.set_cache(resource)
    if not calculate_price(action):
        return error_response('price not set for this daterange')
    action.valid_till = get_utc_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    db.session.add(action)
    db.session.commit()
    update_resource_status(resource=resource)
    check_reservation_timeout_delay.apply_async((resource.id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_cancel_handler(data: dict, source: str) -> dict:
    try:
        cancel_input = cancel_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    try:
        action = Action.apiget(cancel_input.uid, cancel_input.request_uid, cancel_input.session)
    except BikeBoxAccessDeniedException:
        try:
            action = Action.apiget(cancel_input.uid, cancel_input.request_uid, cancel_input.session, hashed=True)
        except BikeBoxNotExistingException:
            return error_response('action does not exist')
        except BikeBoxAccessDeniedException:
            return error_response('invalid credentials')
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status == ActionStatus.cancelled:
        return error_response('action already cancelled')
    if action.status == ActionStatus.booked and cancel_input.booked is not True:
        return error_response('action already booked')
    #if action.source != source:
    #    return error_response('invalid source')
    action.status = ActionStatus.cancelled
    db.session.add(action)
    db.session.commit()
    update_resource_status_delay.delay(action.resource_id)
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_renew_handler(data: dict, source: str) -> dict:
    try:
        renew_input = renew_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    try:
        action = Action.apiget(renew_input.uid, renew_input.request_uid, renew_input.session)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status == ActionStatus.booked:
        return error_response('action already booked')
    if action.source != source:
        return error_response('invalid source')
    resource = action.resource
    if not resource_free_between(resource.id, action.begin, action.end, exclude_ids=[action.id]):
        return error_response('resource not free')

    action.valid_till = get_utc_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.status = ActionStatus.reserved
    db.session.add(action)
    check_reservation_timeout_delay.apply_async((action.resource_id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])

    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_book_handler(data: dict, source: str) -> dict:
    try:
        booking_input = booking_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    try:
        action = Action.apiget(booking_input.uid, booking_input.request_uid, booking_input.session)
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
    for key, value in booking_input.to_dict().items():
        if value is UnsetValue:
            continue
        setattr(action, key, value)
    if booking_input.token[0].identifier:
        action.pin = booking_input.token[0].identifier
    else:
        action.pin = '%04d' % randint(0, 9999)
    action.status = ActionStatus.booked

    update_resource_status_delay.delay(resource.id)
    db.session.add(resource)

    db.session.add(action)
    db.session.commit()
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_extend_handler(data: dict, source: str):
    try:
        extend_input = extend_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    try:
        old_action = Action.apiget(extend_input.old_uid, extend_input.old_request_uid, extend_input.old_session)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    resource = Resource.query.get(old_action.resource_id)

    if old_action.status != ActionStatus.booked:
        return error_response('old action was not booked')
    if old_action.end < get_utc_now():
        return error_response('old action already ended')
    autocalculated_end = (old_action.end + (old_action.end - old_action.begin) + timedelta(hours=1)).replace(hour=0)
    begin, end = calculate_begin_end(extend_input.predefined_daterange, old_action.end, extend_input.end or autocalculated_end)
    if not resource_free_between(resource.id, begin, end):
        return error_response('resource not free')

    action = Action()
    for key, value in extend_input.to_dict().items():
        if value is UnsetValue or key in ['begin', 'end']:
            continue
        setattr(action, key, value)
    action.begin = begin
    action.end = end
    action.auth_methods = resource.hardware.supported_auth_methods
    action.set_cache(resource)
    if not calculate_price(action):
        return error_response('price not set for this daterange')
    action.valid_till = get_utc_now() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.source = source
    db.session.add(action)
    db.session.commit()

    check_reservation_timeout_delay.apply_async((action.resource_id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])
    return success_response(action.to_dict(extended=True, remove_none=True))


def action_open_close_handler(data: dict, job: str):
    try:
        open_close_input = open_close_validator.validate(data)
    except ValidationError as exception:
        return error_response(exception.to_dict())
    try:
        action = Action.apiget(open_close_input.uid, open_close_input.request_uid, open_close_input.session, hashed=True)
    except BikeBoxNotExistingException:
        return error_response('action does not exist')
    if action.status != ActionStatus.booked:
        return error_response('resource not booked')
    if action.begin > get_utc_now() or action.end < get_utc_now():
        return error_response('not in begin-end range')
    result = get_json(
        '%s/api/v1/backend/resource/%s/change-status/%s' % (
            current_app.config['OPENBIKEBOX_CONNECT_URL'],
            action.resource_id,
            job
        ),
        {},
        'openbikebox-connect',
        'cannot %s lock' % job,
        auth=(current_app.config['OPENBIKEBOX_CONNECT_USER'], current_app.config['OPENBIKEBOX_CONNECT_PASSWORD'])
    )
    if result and result.get('status') == 0:
        return success_response({})
    return error_response()
