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

from datetime import timedelta
from wtfjson import DictInput
from wtfjson.fields import IntegerField, StringField, DateTimeField, ListField, ObjectField
from wtfjson.validators import NumberRange, Length, AnyOf, DateTimeRange


class ReserveForm(DictInput):
    request_uid = StringField(validators=[Length(min=16)])
    resource_id = IntegerField(validators=[NumberRange(min=1)])
    requested_at = DateTimeField(
        validators=[DateTimeRange(minus=timedelta(minutes=-2), plus=timedelta(minutes=2))],
        accept_utc=True
    )
    predefined_daterange = StringField(
        validators=[AnyOf(['day', 'week', 'month', 'year'])],
        required=False
    )
    begin = DateTimeField(required=False, accept_utc=True)
    end = DateTimeField(required=False, accept_utc=True)
    user_identifier = StringField(required=False)


class BaseUpdateForm(DictInput):
    uid = StringField(validators=[Length(min=32)])
    request_uid = StringField(validators=[Length(min=16)])
    session = StringField(validators=[Length(min=32)])


class CancelForm(BaseUpdateForm):
    pass


class RenewForm(BaseUpdateForm):
    pass


class BookingTokenForm(DictInput):
    type = StringField(validators=[AnyOf(['code', 'connect'])])
    identifier = StringField(required=False)


class BookingForm(BaseUpdateForm):
    paid_at = DateTimeField(accept_utc=True)
    user_identifier = StringField(required=False)
    token = ListField(ObjectField(BookingTokenForm), min_entries=1)


class ExtendForm(DictInput):
    old_uid = StringField()
    old_request_uid = StringField()
    old_session = StringField()
    request_uid = StringField()
    requested_at = DateTimeField(
        validators=[DateTimeRange(minus=timedelta(minutes=-2), plus=timedelta(minutes=2))],
        accept_utc=True
    )
    begin = DateTimeField(required=False, accept_utc=True)
    end = DateTimeField(required=False, accept_utc=True)
    predefined_daterange = StringField(validators=[AnyOf(['day', 'week', 'month', 'year'])], required=False)
    user_identifier = StringField(required=False)

