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
from flask import Blueprint, jsonify, abort, request
from flask_cors import cross_origin
from ..common.response import jsonify_success
from ..models import Location
from ..extensions import api_documentation
from .ResourceApiHelper import locations_geojson, get_location_reply, locations_list
from ..api_documentation.ApiDocumentation import EndpointTag

resource_api = Blueprint('resource_api', __name__, template_folder='templates')


@resource_api.route('/api/locations')
@api_documentation.register(
    summary='getting aggregated information about locations',
    tags=[EndpointTag.information],
    args=[{
        'name': 'format',
        'description': 'whether output should geojson or json list',
        'schema': {
            'type': 'string',
            'enum': ['list', 'geojson'],
            'default': 'list'
        },
        'required': False
    }],
    response_schema_multi={
        'application/json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'locations-response-list.json'),
        'application/geo+json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'locations-response-geojson.json')
    }
)
@cross_origin()
def api_locations_geojson():
    locations = Location.query.all()
    if request.args.get('format') == 'geojson':
        return jsonify(locations_geojson(locations))
    return jsonify_success(locations_list(locations))


@resource_api.route('/api/location/<int:location_id>')
@api_documentation.register(
    summary='getting detail information about a single by id',
    tags=[EndpointTag.information],
    path_params=[{
        'name': 'location_id',
        'description': 'unique id of location',
        'schema': {
            'type': 'integer'
        }
    }],
    args=[{
        'name': 'format',
        'description': 'whether output should location object or all ressources of this location as geojson or svg',
        'schema': {
            'type': 'string',
            'enum': ['object', 'geojson', 'svg'],
            'default': 'object'
        },
        'required': False
    }],
    response_schema_multi={
        'application/json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'location-response.json'),
        'application/geo+json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'location-response-geojson.json')
    }
)
@cross_origin()
def api_location(location_id):
    location = Location.query.get_or_404(location_id)
    return get_location_reply(location)


@resource_api.route('/api/location')
@api_documentation.register(
    summary='getting detail information about a single by other parameters',
    tags=[EndpointTag.information],
    args=[
        {
            'name': 'slug',
            'description': 'the slug which should be queried',
            'schema': {
                'type': 'string'
            },
            'required': True
        },
        {
            'name': 'format',
            'description': 'whether output should location object or all ressources of this location as geojson or svg',
            'schema': {
                'type': 'string',
                'enum': ['object', 'geojson', 'svg'],
                'default': 'object'
            },
            'required': False

        },
    ],
    response_schema_multi={
        'application/json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'location-response.json'),
        'application/geo+json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'location-response-geojson.json')
    }
)
@cross_origin()
def api_location_param():
    location = Location.query.filter_by(slug=request.args.get('slug')).first()
    if not location:
        abort(404)
    return get_location_reply(location)


