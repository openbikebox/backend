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

from enum import Enum


class EventSource(Enum):
    WORDPRESS = 'WORDPRESS'
    CLIENT = 'CLIENT'
    FLOURIO = 'FLOURIO'
    EVENT = 'EVENT'


class EventType(Enum):
    ORDER_CREATED = 'ORDER_CREATED'
    ORDER_UPDATED = 'ORDER_UPDATED'
    ORDER_COMPLETED = 'ORDER_COMPLETED'
    ORDER_CANCELLED = 'ORDER_CANCELLED'
    ORDER_TIMEOUT_CHECK = 'ORDER_TIMEOUT_CHECK'
    STORE_OPEN = 'STORE_OPEN'
    STORE_CLOSE = 'STORE_CLOSE'
    PRODUCT_STOCK_EMPTY = 'PRODUCT_STOCK_EMPTY'

