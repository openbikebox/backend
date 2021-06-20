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
from ..common.response import svg_response
from ..models import Location, Resource
from ..extensions import api_documentation
from ..enum import LocationType
from .ResourceApiHandler import locations_geojson, get_location_reply, locations_list, get_resource_action_reply, \
    get_location_action_reply, get_resource_reply
from ..api_documentation.ApiDocumentation import EndpointTag

resource_api = Blueprint('resource', __name__)

from . import ResourceApiCli


@resource_api.route('/api/v1/locations')
@api_documentation.register(
    summary='getting aggregated information about locations',
    tags=[EndpointTag.information],
    args=[
        {
            'name': 'format',
            'description': 'whether output should geojson or json list',
            'schema': {
                'type': 'string',
                'enum': ['list', 'geojson'],
                'default': 'list'
            },
            'required': False
        },
        {
            'name': 'operator.id',
            'description': 'operator id',
            'schema': {
                'type': 'integer'
            },
            'required': False
        },
        {
            'name': 'type',
            'description': 'location type',
            'schema': {
                'type': 'string',
                'enum': ['bikebox', 'cargobike']
            },
            'required': False
        },
    ],
    response_schema_multi={
        'application/json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'locations-response-list.json'),
        'application/geo+json': os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'locations-response-geojson.json')
    }
)
@cross_origin()
def api_locations_geojson():
    locations = Location.query
    if request.args.get('operator.id', type=int, default=0):
        locations = locations.filter_by(operator_id=request.args.get('operator.id', type=int))
    if request.args.get('type') in ['bikebox', 'cargobike']:
        locations = locations.filter_by(type=getattr(LocationType, request.args.get('type')))
    locations = locations.all()
    if request.args.get('format') == 'geojson':
        return jsonify(locations_geojson(locations))
    return jsonify(locations_list(locations))


@resource_api.route('/api/v1/location/<int:location_id>')
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
    if request.args.get('format') == 'svg':
        return svg_response(location.polygon_svg)
    if request.args.get('format') == 'geojson':
        return jsonify(location.polygon_geojson)
    return jsonify(get_location_reply(location))


@resource_api.route('/api/v1/location')
@api_documentation.register(
    summary='getting detail information about a single location by other parameters',
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
    if request.args.get('format') == 'svg':
        return svg_response(location.polygon_svg)
    if request.args.get('format') == 'geojson':
        return jsonify(location.polygon_geojson)
    return jsonify(get_location_reply(location))


@resource_api.route('/api/v1/resource')
@api_documentation.register(
    summary='getting detail information about a single resource by other parameters',
    tags=[EndpointTag.information],
    args=[
        {
            'name': 'slug',
            'description': 'the slug which should be queried',
            'schema': {
                'type': 'string'
            },
            'required': True
        }
    ],
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'resource-response.json')
)
@cross_origin()
def api_resource_param():
    return jsonify(get_resource_reply(Resource.query.filter_by(slug=request.args.get('slug')).first_or_404()))


@resource_api.route('/api/v1/location/<int:location_id>/actions')
@api_documentation.register(
    summary='getting actions of location',
    tags=[EndpointTag.information],
    args=[
        {
            'name': 'begin',
            'description': 'begin of daterange',
            'schema': {
                'type': 'string',
                'format': 'date'
            },
            'required': True
        },
        {
            'name': 'end',
            'description': 'end of daterange',
            'schema': {
                'type': 'string',
                'format': 'date'
            },
            'required': True

        },
    ],
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'location-action-response.json')
)
@cross_origin()
def api_location_actions(location_id: int):
    return jsonify(get_location_action_reply(location_id, request.args.get('begin'), request.args.get('end')))


@resource_api.route('/api/v1/resource/<int:resource_id>/actions')
@api_documentation.register(
    summary='getting actions of resource',
    tags=[EndpointTag.information],
    args=[
        {
            'name': 'begin',
            'description': 'begin of daterange',
            'schema': {
                'type': 'string',
                'format': 'date'
            },
            'required': True
        },
        {
            'name': 'end',
            'description': 'end of daterange',
            'schema': {
                'type': 'string',
                'format': 'date'
            },
            'required': True

        },
    ],
    response_schema=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'schema', 'resource-action-response.json')
)
@cross_origin()
def api_resource_actions(resource_id: int):
    return jsonify(get_resource_action_reply(resource_id, request.args.get('begin'), request.args.get('end')))

