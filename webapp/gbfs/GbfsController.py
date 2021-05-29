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
from .GbfsHandler import handle_gbfs_index, handle_gbfs_system_information, handle_gbfs_station_information, \
    handle_gbfs_station_status, handle_gbfs_system_alerts, handle_gbfs_system_hours, handle_gbfs_vehicle_types, \
    handle_gbfs_gbfs_versions
from ..common.response import json_response

gbfs_controller = Blueprint('gbfs_controller', __name__, url_prefix='/api/gbfs/2.2')


@gbfs_controller.route('/<int:operator_id>/gbfs.json')
def gbfs_index(operator_id: int):
    return json_response(handle_gbfs_index(operator_id))


@gbfs_controller.route('/<int:operator_id>/gbfs_versions.json')
def gbfs_gbfs_versions(operator_id: int):
    return json_response(handle_gbfs_gbfs_versions(operator_id))


@gbfs_controller.route('/<int:operator_id>/system_information.json')
def gbfs_system_information(operator_id: int):
    return json_response(handle_gbfs_system_information(operator_id))


@gbfs_controller.route('/<int:operator_id>/station_information.json')
def gbfs_station_information(operator_id: int):
    return json_response(handle_gbfs_station_information(operator_id))


@gbfs_controller.route('/<int:operator_id>/station_status.json')
def gbfs_station_status(operator_id: int):
    return json_response(handle_gbfs_station_status(operator_id))


@gbfs_controller.route('/<int:operator_id>/system_alerts.json')
def gbfs_system_alerts(operator_id: int):
    return json_response(handle_gbfs_system_alerts(operator_id))


@gbfs_controller.route('/<int:operator_id>/system_hours.json')
def gbfs_system_hours(operator_id: int):
    return json_response(handle_gbfs_system_hours(operator_id))


@gbfs_controller.route('/<int:operator_id>/vehicle_types.json')
def gbfs_vehicle_types(operator_id: int):
    return json_response(handle_gbfs_vehicle_types(operator_id))
