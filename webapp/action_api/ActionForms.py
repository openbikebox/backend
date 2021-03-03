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

from flask_wtf import FlaskForm
from wtforms import validators
from wtforms import IntegerField, StringField
from ..common.form import SchemaForm
from ..common.form_validator import ValidateDateTime, ValidateDateTimeRange
from ..common.form_field import DateTimeField
from ..common.form_filter import normalize_utc


class ReserveForm(FlaskForm, SchemaForm):
    class Meta:
        csrf = False
        schema_id = 'action-reservation'
        schema_title = 'reservation'
        schema_description = 'this is the initial request sent to the booking system. usually its done when a customer puts something in her cart.'

    request_uid = StringField(
        label='request uid',
        validators=[
            validators.DataRequired(),
            validators.Length(min=16)
        ],
        description='this uid is the client side identifier for the whole transaction'
    )
    resource_id = IntegerField(
        label='resource',
        validators=[
            validators.DataRequired(),
            validators.NumberRange(min=1)
        ],
        description='the identifier of the ressource'
    )
    requested_at = DateTimeField(
        label='requested_at',
        validators=[
            validators.DataRequired(),
            ValidateDateTime(),
            ValidateDateTimeRange(plus=120, minus=120)
        ],
        filters=[
            normalize_utc
        ],
        description='the utc moment when the reservation was created'
    )
    begin = DateTimeField(
        label='begin',
        validators=[
            validators.DataRequired(),
            ValidateDateTime()
        ],
        filters=[
            normalize_utc
        ],
        description='utc begin of the rent'
    )
    end = DateTimeField(
        label='end',
        validators=[
            validators.DataRequired(),
            ValidateDateTime()
        ],
        filters=[
            normalize_utc
        ],
        description='utc end of the rent'
    )


class BaseUpdateForm(FlaskForm, SchemaForm):
    uid = StringField(
        label='uid',
        validators=[
            validators.DataRequired()
        ],
        description='unique transaction identifier provided at reservation'
    )
    request_uid = StringField(
        label='request uid',
        validators=[
            validators.DataRequired()
        ],
        description='this uid is the client side identifier for the whole transaction'
    )
    session = StringField(
        label='session',
        validators=[
            validators.DataRequired()
        ],
        description='session string provided at reservation'
    )


class CancelForm(BaseUpdateForm):
    class Meta:
        csrf = False
        schema_id = 'action-cancel'
        schema_title = 'cancel'
        schema_description = 'this is the request which is sent when the customer cancels a reservation.'


class RenewForm(BaseUpdateForm):
    class Meta:
        csrf = False
        schema_id = 'action-renew'
        schema_title = 'renew'
        schema_description = 'this is the request which is sent when the customer renews a reservation.'


class BookingForm(BaseUpdateForm):
    class Meta:
        csrf = False
        schema_id = 'action-book'
        schema_title = 'book'
        schema_description = 'this is the request which is sent when the customer paid a reservation.'

    uid = StringField(
        label='uid',
        validators=[
            validators.DataRequired()
        ],
        description='unique transaction identifier provided at reservation'
    )
    request_uid = StringField(
        label='request uid',
        validators=[
            validators.DataRequired()
        ],
        description='this uid is the client side identifier for the whole transaction'
    )
    session = StringField(
        label='session',
        validators=[
            validators.DataRequired()
        ],
        description='session string provided at reservation'
    )
    paid_at = DateTimeField(
        label='paid at',
        validators=[
            ValidateDateTime()
        ],
        filters=[
            normalize_utc
        ],
        description='the utc moment when the payment was done'
    )
    pin = StringField(
        label='PIN',
        validators=[
            validators.Length(min=4, max=4)
        ]
    )
