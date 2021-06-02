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


from flask import Blueprint
from .ParkApiHandler import handle_park_api_index, handle_park_api_operator
from ..common.response import json_response

park_api_controller = Blueprint('park_api_controller', __name__, url_prefix='/api/park-api/1.0')


@park_api_controller.route('/')
def park_api_index():
    return json_response(handle_park_api_index())


@park_api_controller.route('/<int:operator_id>')
def park_api_operator(operator_id: int):
    return json_response(handle_park_api_operator(operator_id))
