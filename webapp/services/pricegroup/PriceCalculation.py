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

from math import ceil, floor
from decimal import Decimal
from datetime import datetime
from ...models import Pricegroup


def calculate_detailed_price(pricegroup: Pricegroup, begin: datetime, end: datetime) -> Decimal:
    delta = end - begin
    hours = 0
    days = 0
    weeks = 0

    final_fnc = ceil
    if pricegroup.fee_hour is not None:
        hours = final_fnc(delta.total_seconds() / 60 / 60) % 24
        final_fnc = floor
    if pricegroup.fee_day is not None:
        days = final_fnc(delta.total_seconds() / 60 / 60 / 24) % 7
        final_fnc = floor
    if pricegroup.fee_week is not None:
        weeks = final_fnc(delta.total_seconds() / 60 / 60 / 24 / 7)

    if pricegroup.fee_hour and hours * pricegroup.fee_hour > pricegroup.fee_day:
        hours = 0
        days += 1
    if pricegroup.fee_day and days * pricegroup.fee_day > pricegroup.fee_week:
        hours = 0
        days = 0
        weeks += 1

    result = Decimal(0)
    if pricegroup.fee_hour is not None:
        result += hours * pricegroup.fee_hour
    if pricegroup.fee_day is not None:
        result += days * pricegroup.fee_day
    if pricegroup.fee_week is not None:
        result += weeks * pricegroup.fee_week
    return result
