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

import pytz
from uuid import uuid4
from random import randint
from datetime import datetime, timedelta

from tests.integration.helper.BaseIntegrationTestCase import BaseIntegrationTestCase

from webapp.action_api.ActionApiHandler import action_reserve_handler, action_book_handler
from webapp.models import Resource


class BookingFutureTest(BaseIntegrationTestCase):

    def test_booking_success_predefined_range_with_begin(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        request_uid = str(uuid4())
        reservation = action_reserve_handler({
            'begin': (datetime.utcnow() + timedelta(days=5)).strftime('%Y-%m-%dT%H:%M:%SZ'),
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

    def test_booking_success_begin_end(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        request_uid = str(uuid4())

        begin = (datetime.now() + timedelta(days=5)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=7, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
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

    def create_future_action(self, resource_id):
        request_uid = str(uuid4())

        begin = (datetime.now() + timedelta(days=5)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=7, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource_id
        }, 'integration-test')
        uid = reservation['data']['uid']
        session = reservation['data']['session']
        action_book_handler({
            'paid_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'uid': uid,
            'session': session,
            'token': [{
                'type': 'code',
                'identifier': '%04d' % randint(0, 9999)
            }]
        }, 'integration-test')

    def test_booking_blocked_after(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        self.create_future_action(resource.id)
        request_uid = str(uuid4())
        begin = (datetime.now() + timedelta(days=7)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=7, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert reservation['error'] == 'resource not free'

    def test_booking_blocked_before(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        self.create_future_action(resource.id)
        request_uid = str(uuid4())
        begin = (datetime.now() + timedelta(days=2)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=7, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert reservation['error'] == 'resource not free'

    def test_booking_free_before(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        self.create_future_action(resource.id)
        request_uid = str(uuid4())
        begin = (datetime.now() + timedelta(days=3)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=2, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert 'error' not in reservation

    def test_booking_free_after(self):
        resource = Resource.query.filter_by(hardware_id=3).first()
        self.create_future_action(resource.id)
        request_uid = str(uuid4())
        begin = (datetime.now() + timedelta(days=12)).replace(hour=0, minute=0, second=0, microsecond=0)
        end = (begin + timedelta(days=3, hours=1)).replace(hour=0)
        reservation = action_reserve_handler({
            'begin': pytz.timezone('Europe/Berlin').localize(begin).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'end': pytz.timezone('Europe/Berlin').localize(end).astimezone(pytz.UTC).strftime('%Y-%m-%dT%H:%M:%SZ'),
            'request_uid': request_uid,
            'requested_at': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'resource_id': resource.id
        }, 'integration-test')
        assert 'error' not in reservation
