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
from flask import request, jsonify
from ..models import Location
from ..common.response import svg_response, jsonify_success


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


def locations_list(locations: List[Location]):
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
    return result


def get_location_reply(location: Location):
    if request.args.get('format') == 'svg':
        return svg_response(location.polygon_svg)
    if request.args.get('format') == 'geojson':
        return jsonify(location.polygon_geojson)

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
        item = resource.to_dict(fields=[
            'id', 'id_url', 'created', 'modified', 'slug', 'user_identifier', 'maintenance_from', 'maintenance_till',
            'status', 'installed_at', 'unavailable_until', 'description'
        ], remove_none=True)
        item['pricegroup'] = resource.pricegroup.to_dict(ignore=['operator_id'], remove_none=True)
        if resource.photo_id:
            item['photo'] = resource.photo.to_dict(
                fields=['id', 'id_url', 'created', 'modified', 'url', 'mimetype'],
                remove_none=True
            )
        item['predefined_dateranges'] = [item for item in ['day', 'week', 'month', 'year'] if getattr(resource.pricegroup, 'fee_%s' % item) is not None]
        result['resource'].append(item)
    return jsonify_success(result)
