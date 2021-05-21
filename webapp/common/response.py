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


import json
from lxml import etree
from typing import Union, Optional
from functools import update_wrapper
from flask import make_response, jsonify, Response, request
from ..extensions import logger
from .helpers import DefaultJSONEncoder


def json_response(data_dict, cors=False):
    response = make_response(json.dumps(data_dict, cls=DefaultJSONEncoder))
    response.mimetype = 'application/json'
    if cors:
        response.headers['Access-Control-Allow-Origin'] = '*'
    return response


def success_response(data: Union[dict, list, str], count: Optional[int] = None) -> dict:
    result = {'status': 0, 'data': data}
    if count is not None:
        result['count'] = count
    return result


def jsonify_success(data: Union[dict, list, str], count: Optional[int] = None) -> Response:
    response = success_response(data, count)
    return jsonify(response)


def error_response(error: Union[dict, list, str] = 'common') -> dict:
    return {'status': -1, 'error': error}


def jsonify_error(error: Union[dict, list, str] = 'common') -> Response:
    response = error_response(error)
    return jsonify(response)


def svg_response(xml_tree):
    response = make_response(etree.tostring(xml_tree, pretty_print=False, encoding='UTF-8', xml_declaration=True))
    response.mimetype = 'image/svg+xml'
    return response


def log_request(log_file: str = 'requests'):
    def decorator(fn):
        def wrapped_function(*args, **kwargs):
            if request.data:
                logger.info(log_file, '>> %s' % json.dumps(request.json, cls=DefaultJSONEncoder, sort_keys=True, indent=2))
            result = fn(*args, **kwargs)
            if isinstance(result, Response):
                logger.info(log_file, '<< %s' % result.get_data(True))
            elif type(result) is dict or type(result) is list:
                logger.info(log_file, '<< %s' % json.dumps(result, cls=DefaultJSONEncoder))
            else:
                logger.info(log_file, '<< invalid response type %s' % type(result))
            return result

        return update_wrapper(wrapped_function, fn)

    return decorator


