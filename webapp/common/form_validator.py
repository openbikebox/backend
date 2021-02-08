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

from datetime import datetime, timedelta
from wtforms import ValidationError


class ValidateDateTime:
    def __init__(self, message='field has to be datetime'):
        self.message = message

    def __call__(self, form, field):
        try:
            datetime.strptime(field.data, '%Y-%m-%dT%H:%M:%SZ')
        except ValueError:
            raise ValidationError(self.message)


class ValidateDateTimeRange:
    def __init__(self, message='offset too large', minus=0, plus=0):
        self.message = message
        self.minus = minus
        self.plus = plus

    def __call__(self, form, field):
        value = datetime.strptime(field.data, '%Y-%m-%dT%H:%M:%SZ')
        if value < datetime.utcnow() - timedelta(seconds=self.minus):
            raise ValidationError(self.message)
        if value > datetime.utcnow() + timedelta(seconds=self.plus):
            raise ValidationError(self.message)
