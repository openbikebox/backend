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

from typing import List
from datetime import datetime, date
from sqlalchemy import or_, and_
from ..models import Location, Action, Resource
from ..common.response import error_response, success_response
from ..common.helpers import get_now
from ..enum import ActionStatus
from ..services.pricegroup.PriceCalculation import calculate_detailed_price


def locations_geojson(locations: List[Location]) -> dict:
    features = []
    for location in locations:
        features.append({
            'type': 'Feature',
            'geometry': {
                'type': 'Point',
                'coordinates': [float(location.lon), float(location.lat)]
            },
            'properties': {
                'id': location.id,
                'name': location.name,
                'slug': location.slug
            }
        })
    return {
        'type': 'FeatureCollection',
        'features': features
    }


def locations_list(locations: List[Location]) -> dict:
    result = []
    for location in locations:
        location_dict = location.to_dict(
            fields=['id', 'id_url', 'lat', 'lon', 'name', 'slug', 'osm_id'],
            remove_none=True
        )
        location_dict['photo'] = location.photo.to_dict(fields=['id', 'modified', 'url', 'mimetype'], remove_none=True)
        location_dict['ressource_count'] = location.resource.count()
        location_dict['booking_url'] = location.booking_url
        result.append(location_dict)
    return success_response(result)


def get_location_reply(location: Location) -> dict:
    result = location.to_dict(remove_none=True, ignore=['geometry'])
    result['booking_url'] = location.booking_url
    result['photo'] = location.photo.to_dict(
        fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'],
        remove_none=True
    )
    result['operator'] = location.operator.to_dict(fields=[
        'id', 'id_url', 'created', 'modified', 'name', 'description', 'address', 'postalcode', 'locality', 'country'
    ], remove_none=True)
    result['operator']['logo'] = location.operator.logo.to_dict(fields=[
        'id', 'id_url', 'created', 'modified', 'url', 'mimetype'
    ], remove_none=True)
    result['resource'] = []
    for resource in location.resource:
        result['resource'].append(get_resource_reply_raw(resource))
    result['photos'] = [location.photo.to_dict(
        fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'],
        remove_none=True
    )]
    for resource_group in location.resource_group:
        for photo in resource_group.images:
            result['photos'].append(photo.to_dict(
                fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'],
                remove_none=True
            ))
    return success_response(result)


def get_resource_reply(resource: Resource):
    return success_response(get_resource_reply_raw(resource))


def get_resource_reply_raw(resource: Resource):
    item = resource.to_dict(fields=[
        'id', 'id_url', 'created', 'modified', 'name', 'slug', 'user_identifier', 'maintenance_from',
        'maintenance_till', 'status', 'installed_at', 'description', 'hardware_id'
    ], remove_none=True)
    item['pricegroup'] = resource.pricegroup.to_dict(ignore=['operator_id'], remove_none=True)
    if resource.photo_id:
        item['photo'] = resource.photo.to_dict(
            fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'],
            remove_none=True
        )
    item['photos'] = [
        photo.to_dict(fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'], remove_none=True)
        for photo in resource.photos
    ]
    item['predefined_dateranges'] = [item for item in ['day', 'week', 'month', 'year'] if
                                     getattr(resource.pricegroup, 'fee_%s' % item) is not None]
    return item


def get_location_action_reply(location_id: int, begin_str: str, end_str: str):
    try:
        begin = date.fromisoformat(begin_str)
        end = date.fromisoformat(end_str)
    except (ValueError, TypeError):
        return error_response('invalid date')
    actions = Action.query\
        .with_entities(Action.begin, Action.end, Action.resource_id)\
        .filter_by(location_id=location_id)\
        .filter(Action.end > begin)\
        .filter(Action.begin < end)\
        .filter(or_(
            Action.status == ActionStatus.booked,
            and_(Action.status == ActionStatus.reserved, Action.valid_till > get_now())
        ))\
        .all()
    result = []
    for action in actions:
        result.append({
            'begin': action.begin,
            'end': action.end,
            'resource_id': action.resource_id
        })
    return success_response(result)


def get_resource_action_reply(resource_id: int, begin_str: str, end_str: str) -> dict:
    #try:
    #    begin = date.fromisoformat(begin_str)
    #    end = date.fromisoformat(end_str)
    #except (ValueError, TypeError):
    #    return error_response('invalid date')
#        .filter(Action.end > begin)\
#        .filter(Action.begin < end)\
    resource = Resource.query.get_or_404(resource_id)
    actions = Action.query\
        .with_entities(Action.begin, Action.end)\
        .filter_by(resource_id=resource_id)\
        .filter(or_(
            Action.status == ActionStatus.booked,
            and_(Action.status == ActionStatus.reserved, Action.valid_till > get_now())
        ))\
        .all()
    result = []
    for action in actions:
        result.append({
            'begin': action.begin,
            'end': action.end
        })
    return success_response(result)


def get_resource_price_reply(resource_id: int, begin_str: str, end_str: str):
    try:
        begin = datetime.fromisoformat(begin_str)
        end = datetime.fromisoformat(end_str)
    except (ValueError, TypeError):
        return error_response('invalid datetime')

    resource = Resource.query.get_or_404(resource_id)
    return success_response({
        'value_gross': calculate_detailed_price(resource.pricegroup, begin, end)
    })
