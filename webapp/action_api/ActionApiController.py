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

import os
from datetime import datetime, timedelta
from flask import Blueprint, current_app, jsonify, request
from ..models import Action, Resource
from .ActionForms import ReserveForm, BookingForm, CancelForm, RenewForm
from ..extensions import csrf, db, api_documentation, auth
from ..common.exceptions import BikeBoxAccessDeniedException, BikeBoxNotExistingException
from ..common.enum import ActionStatus, ResourceStatus
from .ActionApiHelper import check_reservation_timeout
from ..api_documentation.ApiDocumentation import EndpointTag

action_api = Blueprint('action_api', __name__, template_folder='templates')


@action_api.route('/api/action/reserve', methods=['POST'])
@api_documentation.register(
    summary='reserve an resource',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'reserve-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'reserve-response.json'),
    basic_auth=True
)
@auth.login_required()
@csrf.exempt
def action_reserve():
    form = ReserveForm(data=request.json)
    if not form.validate():
        return jsonify({
            'status': -1,
            'errors': form.errors
        })
    resource = Resource.query.get(form.resource_id.data)
    if not resource:
        return jsonify({
            'status': -1,
            'errors': 'invalid resource'
        })
    if resource.status != ResourceStatus.free:
        return jsonify({
            'status': -1,
            'errors': 'resource not free'
        })
    action = Action()
    form.populate_obj(action)
    action.set_cache(resource)
    action.calculate()
    action.valid_till = datetime.utcnow() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])

    resource.status = ResourceStatus.reserved
    resource.unavailable_until = datetime.utcnow() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    db.session.add(resource)
    db.session.add(action)
    db.session.commit()

    check_reservation_timeout.apply_async((resource.id, action.id), countdown=60 * current_app.config['RESERVE_MINUTES'])

    return jsonify({
        'status': 0,
        'data': action.to_dict(extended=True, remove_none=True)
    })


@action_api.route('/api/action/cancel', methods=['POST'])
@api_documentation.register(
    summary='cancel a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'cancel-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'cancel-response.json'),
    basic_auth=True
)
@auth.login_required()
@csrf.exempt
def action_cancel():
    form = CancelForm(data=request.json)
    if not form.validate():
        return jsonify({
            'status': -1,
            'errors': form.errors
        })
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return jsonify({
            'status': -1,
            'error': 'action does not exist'
        })
    if action.status == ActionStatus.cancelled:
        return jsonify({
            'status': -1,
            'error': 'action already free'
        })

    if action.status == ActionStatus.booked:
        return jsonify({
            'status': -1,
            'error': 'action already booked'
        })
    action.status = ActionStatus.cancelled
    db.session.add(action)

    resource = action.resource
    if resource.status == ResourceStatus.reserved:
        resource.status = ResourceStatus.free
        resource.unavailable_until = None
        db.session.add(resource)

    db.session.commit()
    return jsonify({
        'status': 0,
        'data': action.to_dict(extended=True, remove_none=True)
    })


@action_api.route('/api/action/renew', methods=['POST'])
@api_documentation.register(
    summary='renews a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'renew-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'renew-response.json'),
    basic_auth=True
)
@auth.login_required()
@csrf.exempt
def action_renew():
    form = RenewForm(data=request.json)
    if not form.validate():
        return jsonify({
            'status': -1,
            'errors': form.errors
        })
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return jsonify({
            'status': -1,
            'error': 'action does not exist'
        })
    if action.status == ActionStatus.booked:
        return jsonify({
            'status': -1,
            'error': 'action already booked'
        })
    resource = action.resource
    if resource.status not in [ResourceStatus.free, ResourceStatus.reserved]:
        return jsonify({
            'status': -1,
            'error': 'resource not free'
        })

    action.valid_till = datetime.utcnow() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    action.status = ActionStatus.reserved
    db.session.add(action)

    resource.status = ResourceStatus.reserved
    resource.unavailable_until = datetime.utcnow() + timedelta(minutes=current_app.config['RESERVE_MINUTES'])
    db.session.add(resource)

    db.session.commit()
    return jsonify({
        'status': 0,
        'data': action.to_dict(extended=True, remove_none=True)
    })


@action_api.route('/api/action/book', methods=['POST'])
@api_documentation.register(
    summary='book a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'book-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'book-response.json'),
    basic_auth=True
)
@auth.login_required()
@csrf.exempt
def action_book():
    form = BookingForm(data=request.json)
    if not form.validate():
        return jsonify({
            'status': -1,
            'errors': form.errors
        })
    # TODO: use new validation system to prevent manual check
    token_check_data = request.json
    print(token_check_data)
    if 'token' not in token_check_data \
            or not len(token_check_data['token']) \
            or 'identifier' not in token_check_data['token'][0] \
            or 'type' not in token_check_data['token'][0] \
            or token_check_data['token'][0]['type'] != 'code' \
            or len(token_check_data['token'][0]['identifier']) != 4:
        return jsonify({
            'status': -1,
            'error': 'invalid token'
        })
    try:
        action = Action.apiget(form.uid.data, form.request_uid.data, form.session.data)
    except BikeBoxNotExistingException:
        return jsonify({
            'status': -1,
            'error': 'action does not exist'
        })
    except BikeBoxAccessDeniedException:
        return jsonify({
            'status': -1,
            'error': 'invalid credentials'
        })
    if action.status not in [ActionStatus.reserved, ActionStatus.cancelled]:
        return jsonify({
            'status': -1,
            'error': 'action already booked'
        })
    resource = action.resource
    if resource.status not in [ResourceStatus.free, ResourceStatus.reserved]:
        return jsonify({
            'status': -1,
            'error': 'resource not free'
        })
    form.populate_obj(action)
    action.pin = token_check_data['token'][0]['identifier']
    action.status = ActionStatus.booked

    resource.status = ResourceStatus.taken
    resource.unavailable_until = action.end
    db.session.add(resource)

    db.session.add(action)
    db.session.commit()

    return jsonify({
        'status': 0,
        'data': action.to_dict(extended=True, remove_none=True)
    })

