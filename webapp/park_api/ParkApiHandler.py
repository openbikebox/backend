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

from sqlalchemy import func, case
from flask import abort
from ..models import Location, Resource, Operator
from ..enum import ResourceStatus


def handle_park_api_index() -> dict:
    return {
        "api_version": "1.0",
        "server_version": "1.0.0",
        "reference": "https://openbikebox.de",
        "cities": {operator.name: str(operator.id) for operator in Operator.query.all()}
    }


def handle_park_api_operator(operator_id: int) -> dict:
    locations = Location.query\
        .with_entities(
            Location.id,
            Location.modified,
            Location.name,
            Location.lat,
            Location.lon,
            Location.slug,
            Location.address,
            func.max(Resource.modified).label('resource_last_modified'),
            func.count(Resource.id).label('resource_count'),
            func.count(case([(Resource.status == ResourceStatus.free, 1)])).label('resource_free_count')
        )\
        .filter(Location.operator_id == operator_id)\
        .join(Resource, Resource.location_id == Location.id)\
        .group_by(Location.id)\
        .all()
    if not len(list(locations)):
        abort(404)
    return {
        "last_updated": max([
            max([location.modified for location in locations]),
            max([location.resource_last_modified for location in locations])
        ]),
        "data_source": "https://openbikebox.de",
        "lots": [
            {
                "coords": {
                    "lat": float(location.lat),
                    "lng": float(location.lon)
                },
                "name": "Altmarkt",
                "total": location.resource_count,
                "free": location.resource_free_count,
                "state": "open",
                "id": location.slug,
                "forecast": False,
                "address": location.address,
                "lot_type": "Fahrradabstellanlage",
                "url": "https://openbikebox.de/"
            } for location in locations
        ]
    }
