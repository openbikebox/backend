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
from uuid import uuid4
from random import randint
from datetime import datetime, timedelta

from tests.integration.helper.BaseIntegrationTestCase import BaseIntegrationTestCase

from webapp.action_api.ActionApiHandler import action_reserve_handler, action_book_handler
from webapp.models import Resource
from webapp.common.misc import DefaultJSONEncoder


class BookingTest(BaseIntegrationTestCase):

    def test_booking_success_client_pin(self):
        resource = Resource.query.first()
        request_uid = str(uuid4())
        reservation = action_reserve_handler({
            'begin': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': (datetime.utcnow() + timedelta(days=30)).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert type(reservation) is dict
        assert 'error' not in reservation
        assert reservation['status'] == 0
        assert reservation['data']['request_uid'] == request_uid
        uid = reservation['data']['uid']
        session = reservation['data']['session']
        assert len(uid) == 36
        assert len(session) == 64

        booked = action_book_handler({
            'paid_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'uid': uid,
            'session': session,
            'token': [{
                'type': 'code',
                'identifier': '%04d' % randint(0, 9999)
            }]
        }, 'integration-test')
        assert booked['status'] == 0
        assert booked['data']['request_uid'] == request_uid
        assert booked['data']['uid'] == uid
        assert booked['data']['session'] == session
        assert len(booked['data']['token']) == 1
        assert len(booked['data']['token'][0]['secret']) == 5

    def test_booking_success_predefined_range(self):
        resource = Resource.query.first()
        request_uid = str(uuid4())
        reservation = action_reserve_handler({
            'predefined_daterange': 'day',
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert type(reservation) is dict
        assert 'error' not in reservation
        assert reservation['status'] == 0
        assert reservation['data']['request_uid'] == request_uid
        uid = reservation['data']['uid']
        session = reservation['data']['session']
        assert len(uid) == 36
        assert len(session) == 64

        booked = action_book_handler({
            'paid_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'uid': uid,
            'session': session,
            'token': [{
                'type': 'code',
                'identifier': '%04d' % randint(0, 9999)
            }]
        }, 'integration-test')
        assert booked['status'] == 0
        assert booked['data']['request_uid'] == request_uid
        assert booked['data']['uid'] == uid
        assert booked['data']['session'] == session
        assert len(booked['data']['token']) == 1
        assert len(booked['data']['token'][0]['secret']) == 5

    def test_booking_success_backend_pin(self):
        resource = Resource.query.first()
        request_uid = str(uuid4())
        reservation = action_reserve_handler({
            'begin': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': (datetime.utcnow() + timedelta(days=30)).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert type(reservation) is dict
        assert 'error' not in reservation
        assert reservation['status'] == 0
        assert reservation['data']['request_uid'] == request_uid
        uid = reservation['data']['uid']
        session = reservation['data']['session']
        assert len(uid) == 36
        assert len(session) == 64

        booked = action_book_handler({
            'paid_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'uid': uid,
            'session': session,
            'token': [{
                'type': 'code'
            }]
        }, 'integration-test')
        assert booked['status'] == 0
        assert booked['data']['request_uid'] == request_uid
        assert booked['data']['uid'] == uid
        assert booked['data']['session'] == session
        assert len(booked['data']['token']) == 1
        assert len(booked['data']['token'][0]['secret']) == 5
