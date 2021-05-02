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
from .ActionApiHandler import action_reserve_handler, action_cancel_handler, action_renew_handler, action_book_handler

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
@auth.login_required()
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
def action_book():
    return action_book_handler(request.json, auth.username())
