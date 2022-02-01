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

from typing import List
from datetime import timedelta, datetime
from validataclass.helpers import OptionalUnset, validataclass, ValidataclassMixin, DefaultUnset, DateTimeOffsetRange
from validataclass.validators import StringValidator, IntegerValidator, EnumValidator, DataclassValidator, \
    ListValidator, BooleanValidator
from webapp.enum import PredefinedDaterange, AuthMethod
from webapp.common.validation import UtcDateTimeValidator


@validataclass
class ReserveInput(ValidataclassMixin):
    request_uid: str = StringValidator(min_length=16)
    resource_id: int = IntegerValidator(min_value=1)
    requested_at: datetime = UtcDateTimeValidator(
        datetime_range=DateTimeOffsetRange(
            offset_minus=timedelta(minutes=2),
            offset_plus=timedelta(minutes=2),
        )
    )
    predefined_daterange: OptionalUnset[PredefinedDaterange] = EnumValidator(PredefinedDaterange), DefaultUnset()
    begin: OptionalUnset[datetime] = UtcDateTimeValidator(), DefaultUnset()
    end: OptionalUnset[datetime] = UtcDateTimeValidator(), DefaultUnset()
    user_identifier: OptionalUnset[str] = StringValidator(), DefaultUnset()


@validataclass
class BaseUpdateInput(ValidataclassMixin):
    uid: str = StringValidator(min_length=32)
    request_uid: str = StringValidator(min_length=16)
    session: str = StringValidator(min_length=32)


@validataclass
class CancelInput(BaseUpdateInput):
    booked: OptionalUnset[bool] = BooleanValidator(), DefaultUnset()


@validataclass
class OpenCloseInput(BaseUpdateInput):
    pass


@validataclass
class RenewInput(BaseUpdateInput):
    pass


@validataclass
class BookingTokenInput(ValidataclassMixin):
    type: AuthMethod = EnumValidator(AuthMethod)
    identifier: OptionalUnset[str] = StringValidator(), DefaultUnset()


@validataclass
class BookingInput(BaseUpdateInput):
    paid_at: datetime = UtcDateTimeValidator(), DefaultUnset()
    user_identifier: OptionalUnset[str] = StringValidator(), DefaultUnset()
    token: List[BookingTokenInput] = ListValidator(DataclassValidator(BookingTokenInput), min_length=1)


@validataclass
class ExtendInput(ValidataclassMixin):
    old_uid: str = StringValidator(min_length=32)
    old_request_uid: str = StringValidator(min_length=16)
    old_session: str = StringValidator(min_length=32)
    request_uid: str = StringValidator(min_length=16)
    requested_at: datetime = UtcDateTimeValidator(
        datetime_range=DateTimeOffsetRange(
            offset_minus=timedelta(minutes=2),
            offset_plus=timedelta(minutes=2),
        )
    )
    begin: OptionalUnset[datetime] = UtcDateTimeValidator(), DefaultUnset()
    end: OptionalUnset[datetime] = UtcDateTimeValidator(), DefaultUnset()
    predefined_daterange: OptionalUnset[PredefinedDaterange] = EnumValidator(PredefinedDaterange), DefaultUnset()
    user_identifier: OptionalUnset[str] = StringValidator(), DefaultUnset()

