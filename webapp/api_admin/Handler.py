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

from datetime import date
from typing import Optional
from flask import current_app
from ..common.helpers import get_json


def handle_location_messages(
        location_id: int,
        page: int,
        items_per_page: int,
        begin: Optional[date] = None,
        end: Optional[date] = None) -> dict:
    url = '%s/api/v1/backend/client/%s/messages' % (current_app.config['OPENBIKEBOX_CONNECT_URL'], location_id)
    args = []
    if begin:
        args.append('begin=%s' % begin.isoformat())
    if end:
        args.append('end=%s' % end.isoformat())
    if len(args):
        url += '?' + '&'.join(args)
    return get_json(
        url,
        {'page': page, 'items_per_page': items_per_page},
        'openbikebox-connect',
        'cannot get messages',
        auth=(current_app.config['OPENBIKEBOX_CONNECT_USER'], current_app.config['OPENBIKEBOX_CONNECT_PASSWORD'])
    )


def handle_resource_open_close(resource_id: int, job: str):
    result = get_json(
        '%s/api/v1/backend/resource/%s/change-status/%s' % (
            current_app.config['OPENBIKEBOX_CONNECT_URL'],
            resource_id,
            job
        ),
        {},
        'openbikebox-connect',
        'cannot %s lock' % job,
        auth=(current_app.config['OPENBIKEBOX_CONNECT_USER'], current_app.config['OPENBIKEBOX_CONNECT_PASSWORD'])
    )
    if result is None or result.get('status'):
        return {'status': 'error', 'message': 'server error'}
    return {'status': 'success'}
