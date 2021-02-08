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

from typing import Union
from decimal import Decimal


def normalize_utc(value: Union[str, None]) -> str:
    if not value:
        return value
    if value[-1] == 'Z':
        return value
    return value + 'Z'


def whitespace_filter(value: Union[str, None]) -> str:
    if not value:
        return value
    return value.replace(' ', '')


def upper_filter(value: Union[str, None]) -> str:
    if not value:
        return value
    return value.upper()


def decimal_filter(data: Union[str, float, Decimal, None]) -> Union[Decimal, None]:
    if not data:
        return
    return Decimal(data)


def float_filter(data: Union[str, float, None]) -> Union[float, None]:
    if not data:
        return
    if type(data) is float:
        return data
    return float(data.replace(',', '.'))
