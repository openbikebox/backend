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

from uuid import uuid4
from random import randint
from datetime import datetime, timedelta

from tests.integration.helper.BaseIntegrationTestCase import BaseIntegrationTestCase

from webapp.action_api.ActionApiHandler import action_reserve_handler, action_book_handler, action_extend_handler
from webapp.models import Resource


class BookingTest(BaseIntegrationTestCase):

    def test_extend_success(self):
        resource = Resource.query.first()
        request_uid = str(uuid4())
        reservation = action_reserve_handler({
            'begin': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': (datetime.utcnow() + timedelta(days=30)).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')

        uid = reservation['data']['uid']
        session = reservation['data']['session']

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

        extend_request_uid = str(uuid4())
        extend_reservation = action_extend_handler({
            'request_uid': extend_request_uid,
            'old_request_uid': request_uid,
            'old_uid': uid,
            'old_session': session,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
        }, 'integration-test')
        assert type(extend_reservation) is dict
        assert 'error' not in extend_reservation
        assert extend_reservation['status'] == 0
        assert extend_reservation['data']['request_uid'] == extend_request_uid
        extend_uid = extend_reservation['data']['uid']
        extend_session = extend_reservation['data']['session']
        assert len(extend_uid) == 36
        assert len(extend_session) == 64

        extend_booked = action_book_handler({
            'paid_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': extend_request_uid,
            'uid': extend_uid,
            'session': extend_session,
            'token': [{
                'type': 'code',
                'identifier': '%04d' % randint(0, 9999)
            }]
        }, 'integration-test')

        assert extend_booked['status'] == 0
        assert extend_booked['data']['request_uid'] == extend_request_uid
        assert extend_booked['data']['uid'] == extend_uid
        assert extend_booked['data']['session'] == extend_session
        assert len(extend_booked['data']['token']) == 1
        assert len(extend_booked['data']['token'][0]['secret']) == 5
