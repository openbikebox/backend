# encoding: utf-8

"""
Giro-e Backend
Copyright (c) 2017 - 2021, binary butterfly GmbH
All rights reserved.
"""

from tests.helper import monkey_patch

from datetime import date
from webapp.common import helpers
from webapp.common.helpers import get_today
from tests.helper import BaseTestCase, mock_data


class HelpersTest(BaseTestCase):

    def test_get_current_date(self):
        expected_date = date.today()
        assert helpers.get_current_date() == expected_date

    def test_mocking(self):
        mock_data['today'] = date(2020, 1, 1)
        assert helpers.get_today() == date(2020, 1, 1)
        assert get_today() == date(2020, 1, 1)
