# encoding: utf-8

"""
Copyright (c) 2017, Ernesto Ruge
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"""

import json
import requests
import unittest
from uuid import uuid4
from random import randint
from datetime import datetime, timedelta
from webapp.config import Config
from webapp.common.misc import DefaultJSONEncoder


class JsonCharge(unittest.TestCase):
    def setUp(self):
        self.config = Config

    def test_full_booking(self):
        request_uid = str(uuid4())
        reserve_result = self.json_request('%s/api/action/reserve' % self.config.PROJECT_URL, {
            'request_uid': request_uid,
            'location_id': randint(1, 1024),
            'box_id': randint(1, 1024),
            'requested_at': datetime.utcnow(),
            'begin': datetime.utcnow().replace(second=0) + timedelta(hours=1),
            'end': (datetime.utcnow().replace(second=0) + timedelta(hours=randint(2, 48)))
        })
        print(reserve_result)
        assert reserve_result['status'] == 0
        session = reserve_result['data']['session']
        uid = reserve_result['data']['uid']
        book_result = self.json_request('%s/api/action/book' % self.config.PROJECT_URL, {
            'uid': uid,
            'request_uid': request_uid,
            'session': session,
            'paid_at': datetime.utcnow()
        })
        print(book_result)
        assert book_result['status'] == 0

    @staticmethod
    def json_request(url, data, headers=None):
        if not headers:
            headers = {}
        headers.update({
            'Content-Type': 'application/json'
        })
        r = requests.post(url, data=json.dumps(data, cls=DefaultJSONEncoder), headers=headers)
        return r.json()
