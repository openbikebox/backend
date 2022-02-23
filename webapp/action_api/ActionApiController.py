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
from flask import Blueprint,  jsonify, request
from ..extensions import api_documentation, auth
from ..api_documentation.ApiDocumentation import EndpointTag
from .ActionApiHandler import action_reserve_handler, action_cancel_handler, action_renew_handler, \
    action_book_handler, action_extend_handler, action_open_close_handler
from ..common.response import log_request

action_api = Blueprint('action_api', __name__, template_folder='templates')


@action_api.route('/api/v1/action/reserve', methods=['POST'])
@api_documentation.register(
    summary='reserve an resource',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'reserve-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'reserve-response.json'),
    basic_auth=True
)
@auth.login_required()
@log_request()
def action_reserve():
    return jsonify(action_reserve_handler(request.json, auth.username()))


@action_api.route('/api/v1/action/cancel', methods=['POST'])
@api_documentation.register(
    summary='cancel a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'cancel-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'cancel-response.json'),
    basic_auth=True
)
#@auth.login_required()
@log_request()
def action_cancel():
    return jsonify(action_cancel_handler(request.json, auth.username()))


@action_api.route('/api/v1/action/renew', methods=['POST'])
@api_documentation.register(
    summary='renews a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'renew-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'renew-response.json'),
    basic_auth=True
)
@auth.login_required()
@log_request()
def action_renew():
    return jsonify(action_renew_handler(request.json, auth.username()))


@action_api.route('/api/v1/action/book', methods=['POST'])
@api_documentation.register(
    summary='book a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'book-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'book-response.json'),
    basic_auth=True
)
@auth.login_required()
@log_request()
def action_book():
    return action_book_handler(request.json, auth.username())


@action_api.route('/api/v1/action/extend', methods=['POST'])
@api_documentation.register(
    summary='extend a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'extend-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'extend-response.json'),
    basic_auth=True
)
@auth.login_required()
@log_request()
def action_extend():
    return action_extend_handler(request.json, auth.username())


@action_api.route('/api/v1/action/open', methods=['POST'])
@api_documentation.register(
    summary='remote-open a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'open-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'open-response.json'),
    basic_auth=True
)
@log_request()
def action_open():
    return action_open_close_handler(request.json, 'open')


@action_api.route('/api/v1/action/close', methods=['POST'])
@api_documentation.register(
    summary='remote-closes a resource reservation',
    tags=[EndpointTag.booking],
    request_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'close-request.json'),
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'close-response.json'),
    basic_auth=True
)
@log_request()
def action_close():
    return action_open_close_handler(request.json, 'closed')

