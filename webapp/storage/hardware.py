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
from typing import List
from ..extensions import db
from .base import BaseModel


class AuthMethod(Enum):
    code = 'code'
    connect = 'connect'


auth_method_ids = {
    AuthMethod.code: 1 << 0,
    AuthMethod.connect: 1 << 1
}


class Hardware(db.Model, BaseModel):
    __tablename__ = 'hardware'
    _description = 'Hardware'

    resource = db.relationship('Resource', backref='hardware', lazy='dynamic')

    name = db.Column(db.String(255), info={'description': 'name'})
    lot_name = db.Column(db.String(192), index=True)
    future_booking = db.Column(db.Boolean)
    _supported_auth_methods = db.Column('supported_auth_methods', db.Integer)

    def _get_supported_auth_methods(self) -> List[AuthMethod]:
        if not self._supported_auth_methods:
            return []
        return sorted(
            [item for item in list(AuthMethod) if auth_method_ids[item] & self._supported_auth_methods],
            key=lambda item: auth_method_ids[item]
        )

    def _set_supported_auth_methods(self, supported_auth_methods: List[AuthMethod]) -> None:
        self._supported_auth_methods = 0
        for supported_auth_method in supported_auth_methods:
            self._supported_auth_methods = self._supported_auth_methods | auth_method_ids[supported_auth_method]

    supported_auth_methods = db.synonym('_supported_auth_methods', descriptor=property(_get_supported_auth_methods, _set_supported_auth_methods))
