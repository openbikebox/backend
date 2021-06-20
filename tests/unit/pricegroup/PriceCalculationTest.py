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

from decimal import Decimal
from datetime import datetime
from tests.helper import BaseTestCase
from webapp.services.pricegroup.PriceCalculation import calculate_price
from webapp.models import Pricegroup


class PriceCalculationTest(BaseTestCase):

    def get_pricegroup(self):
        pricegroup = Pricegroup()
        pricegroup.fee_hour = Decimal('1')
        pricegroup.fee_day = Decimal('5')
        pricegroup.fee_week = Decimal('20')
        pricegroup.fee_month = Decimal('50')
        pricegroup.fee_year = Decimal('200')
        return pricegroup

    def test_hours(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 1, 14))
        assert result == Decimal('2')

    def test_days(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 2, 12))
        assert result == Decimal('5')

    def test_weeks(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 8, 12))
        assert result == Decimal('20')

    def test_hours_days(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 2, 14))
        assert result == Decimal('7')

    def test_hours_days_overflow(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 2, 22))
        assert result == Decimal('10')

    def test_days_weeks_overflow(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 6, 0))
        assert result == Decimal('20')

    def test_hours_days_weeks(self):
        result = calculate_price(self.get_pricegroup(), datetime(2021, 7, 1, 12), datetime(2021, 7, 9, 14))
        assert result == Decimal('27')
