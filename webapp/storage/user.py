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

import json
from passlib.hash import bcrypt
from typing import List
from ..extensions import db
from .base import BaseModel


class User(db.Model, BaseModel):
    __tablename__ = 'user'

    operator_id = db.Column(db.BigInteger, db.ForeignKey('operator.id', use_alter=True), info={'description': 'operator id'})

    _email = db.Column('email', db.String(255), unique=True, index=True, info={'description': ''})
    _password = db.Column('password', db.String(255), nullable=False, info={'description': ''})

    login_datetime = db.Column(db.DateTime, info={'description': ''})
    last_login_datetime = db.Column(db.DateTime, info={'description': ''})
    login_ip = db.Column(db.String(64), info={'description': ''})
    last_login_ip = db.Column(db.String(64), info={'description': ''})
    failed_login_count = db.Column(db.Integer, info={'description': ''})
    last_failed_login_count = db.Column(db.Integer, info={'description': ''})

    firstname = db.Column(db.String(255), info={'description': ''})
    lastname = db.Column(db.String(255), info={'description': ''})
    company = db.Column(db.String(255), info={'description': ''})
    address = db.Column(db.String(255), info={'description': ''})
    postalcode = db.Column(db.String(255), info={'description': ''})
    locality = db.Column(db.String(255), info={'description': ''})
    country = db.Column(db.String(2), info={'description': ''})

    language = db.Column(db.Enum('de', 'en'), default='de', info={'description': ''})

    phone = db.Column(db.String(255), info={'description': ''})
    mobile = db.Column(db.String(255), info={'description': ''})

    _capabilities = db.Column('capabilities', db.Text, default='[]', info={'description': ''})

    # force email to lower
    def _get_email(self) -> str:
        return self._email

    def _set_email(self, email: str) -> None:
        self._email = email.lower()

    email = db.synonym('_email', descriptor=property(_get_email, _set_email))

    # password should be encrypted
    def _get_password(self) -> str:
        return self._password

    def _set_password(self, password: str) -> None:
        self._password = bcrypt.hash(password)

    password = db.synonym('_password', descriptor=property(_get_password, _set_password))

    def check_password(self, password: str) -> bool:
        if self.password is None:
            return False
        return bcrypt.verify(password, self.password)

    def _get_capabilities(self) -> List[str]:
        if not self._capabilities:
            return []
        return json.loads(self._capabilities)

    def _set_capabilities(self, capabilities: List[str]) -> None:
        if capabilities:
            self._capabilities = json.dumps(capabilities)

    capabilities = db.synonym('_capabilities', descriptor=property(_get_capabilities, _set_capabilities))

    def has_capability(self, *capabilities: str) -> bool:
        if not self.capabilities:
            return False
        if 'admin' in self.capabilities:
            return True
        for capability in capabilities:
            if capability in self.capabilities:
                return True
        return False

    def __repr__(self):
        return '<User %s>' % self.email
