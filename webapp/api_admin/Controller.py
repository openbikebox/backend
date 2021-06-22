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


from flask import Blueprint, jsonify, request
from flask_login import login_required, current_user
from ..common.response import jsonify_success
from .Handler import handle_location_messages

api_admin = Blueprint('api_admin', __name__, url_prefix='/api/admin/v1')


@api_admin.route('/user/self')
@login_required
def api_user_info():
    return jsonify_success({
        'id': current_user.id,
        'role': current_user.role,
        'email': current_user.email,
        'capabilities': current_user.capabilities,
        'first_name': current_user.first_name,
        'last_name': current_user.last_name
    })


@api_admin.route('/resource/<int:location_id>/logs')
def location_messages(location_id):
    return jsonify(handle_location_messages(
        location_id,
        request.args.get('page', 1, type=int),
        request.args.get('items_per_page', 25, type=int)
    ))

