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

from flask import request, jsonify
from .ActionApiController import action_api
from .ActionForms import ReserveForm, BookingForm


@action_api.route('/api/action/reserve/schema/request')
def action_reserve_schema():
    form = ReserveForm(data=request.json)
    return jsonify(form.schema)


@action_api.route('/api/action/book/schema/request')
def action_book_schema():
    form = BookingForm(data=request.json)
    return jsonify(form.schema)
