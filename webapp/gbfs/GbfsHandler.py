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

from sqlalchemy import or_
from typing import Optional
from itertools import groupby
from dataclasses import dataclass, field
from flask import current_app
from ..models import Operator, Location, Resource, Alert
from ..enum import ResourceStatus, AlertType


@dataclass
class GbfsResponse:
    data: dict
    last_updated: int = field(default_factory=lambda: current_app.config['GBFS_LAST_UPDATED'])
    ttl: Optional[int] = field(default_factory=lambda: current_app.config['GBFS_TTL'])
    version: Optional[str] = '2.2'


def handle_gbfs_index(operator_id: int) -> GbfsResponse:
    Operator.query.get_or_404(operator_id)
    return GbfsResponse({
        "de": {
            "feeds": [
                {
                    "name": "system_information",
                    "url": "%s/api/gbfs/2.2/%s/system_information.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "gbfs_versions",
                    "url": "%s/api/gbfs/2.2/%s/gbfs_versions.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "station_information",
                    "url": "%s/api/gbfs/2.2/%s/station_information.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "station_status",
                    "url": "%s/api/gbfs/2.2/%s/station_status.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "system_alerts",
                    "url": "%s/api/gbfs/2.2/%s/system_alerts.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "system_hours",
                    "url": "%s/api/gbfs/2.2/%s/system_hours.json" % (current_app.config['PROJECT_URL'], operator_id)
                },
                {
                    "name": "vehicle_types",
                    "url": "%s/api/gbfs/2.2/%s/vehicle_types.json" % (current_app.config['PROJECT_URL'], operator_id)
                }
            ]
        }
    })


def handle_gbfs_gbfs_versions(operator_id: int) ->GbfsResponse:
    return GbfsResponse({
        "versions": [
            {
                "version": "2.2",
                "url": "%s/api/gbfs/2.2/%s/gbfs.json" % (current_app.config['PROJECT_URL'], operator_id)
            }
        ]
    })


def handle_gbfs_system_information(operator_id: int) -> GbfsResponse:
    operator = Operator.query.get_or_404(operator_id)
    return GbfsResponse({
        "language": "DE",
        "name": operator.name,
        "operator": operator.name,
        "system_id": "de.openbikebox.%s" % operator.slug,
        "timezone": 'Europe/Berlin',
        "url": operator.url,
        "feed_contact_mail": current_app.config['ADMIN_EMAIL'],
        "mail": operator.email
    }, operator.modified.timestamp())


def handle_gbfs_station_information(operator_id: int) -> GbfsResponse:
    operator = Operator.query.get_or_404(operator_id)
    location_dicts = []
    locations = Location.query.filter_by(operator_id=operator_id).all()
    for location in locations:
        location_dicts.append({
            "lat": float(location.lat),
            "lon": float(location.lon),
            "name": location.name,
            "station_id": location.slug,
            "address": location.address,
            "post_code": location.postalcode,
            "is_virtual_station": False,
            "vehicle_type_capacity": {
                "cargobike_electric_assist": location.resource.count()
            },
            "rental_uris": {
                "web": "%s/location/%s" % (operator.url, location.slug)
            }
        })
    return GbfsResponse(
        {'stations': location_dicts},
        max([location.modified for location in locations]).timestamp()
    )


def handle_gbfs_station_status(operator_id: int) -> GbfsResponse:
    Operator.query.get_or_404(operator_id)
    locations = []
    resources = Resource.query\
        .with_entities(
            Resource.id.label('resource_id'),
            Resource.modified.label('resource_modified'),
            Resource.status,
            Location.modified.label('location_modified'),
            Location.slug.label('location_slug')
        ).join(Location, Resource.location_id == Location.id)\
        .filter(Location.operator_id == operator_id)\
        .all()
    for location_slug, location_resources in groupby(resources, key=lambda item:item.location_slug):
        location_resources = list(location_resources)
        locations.append({
            "station_id": location_slug,
            'num_bikes_available': sum([1 for resource in location_resources if resource.status == ResourceStatus.free]),
            'vehicle_types_available': [{
                'vehicle_type_id': 'cargobike_electric_assist',
                'count': sum([1 for resource in location_resources if resource.status == ResourceStatus.free]),
            }],
            'is_installed': True,
            'is_renting': True,
            'is_returning': True,
            'last_reported': max([resource.resource_modified for resource in location_resources]).timestamp()
        })
    return GbfsResponse(
        {'stations': locations},
        max([max([resource.resource_modified, resource.location_modified]) for resource in resources]).timestamp(),
        60
    )


def handle_gbfs_system_alerts(operator_id: int) -> GbfsResponse:
    operator = Operator.query.get_or_404(operator_id)
    alerts = Alert.query\
        .filter(or_(Alert.operator_id == operator.id, Alert.locations.any(Location.operator_id == operator_id)))\
        .all()
    alert_dicts = []
    for alert in alerts:
        if not alert.active:
            continue
        alert_dict = {
            'alert_id': alert.id,
            'summary': alert.summary,
            'description': alert.description
        }
        if alert.type == AlertType.closure:
            alert_dict['type'] = '%s_closure' % ('system' if alert.operator_id else 'station')
        elif alert.type is not None:
            alert_dict['type'] = alert.type.name
        if alert.locations.count():
            alert_dict['station_ids'] = [location.slug for location in alert.locations]
        alert_dicts.append(alert_dict)
        if alert.start:
            alert_dict['start'] = alert.start.timestamp()
        if alert.end:
            alert_dict['end'] = alert.end.timestamp()
    return GbfsResponse(
        {'alerts': alert_dicts},
        max([alert.modified.timestamp() for alert in alerts]) if len(alerts) else current_app.config['GBFS_LAST_UPDATED'],
        60
    )


def handle_gbfs_system_hours(operator_id: int) -> GbfsResponse:
    operator = Operator.query.get_or_404(operator_id)
    return GbfsResponse(
        {'rental_hours': []},
        operator.modified.timestamp()
    )


def handle_gbfs_vehicle_types(operator_id: int) -> GbfsResponse:
    return GbfsResponse({
        "vehicle_types": [
            {
                "name": "Lastenrad",
                "vehicle_type_id": "cargobike_electric_assist",
                "form_factor": "cargo",
                "max_range_meter": 30000,
                "propulsion_type": "electric_assist"
            }
        ]
    })

