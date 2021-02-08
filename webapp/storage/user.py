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
from hashlib import sha256
from passlib.hash import bcrypt
from typing import Tuple, Optional, List
from itsdangerous import URLSafeTimedSerializer
from flask import current_app, render_template
from flask_mail import Message
from flask_login import login_user, UserMixin
from flask_login import AnonymousUserMixin
from ..extensions import login_manager

from ..extensions import db, mail
from .base import BaseModel


class AnonymousUser(AnonymousUserMixin):
    id = None
    states = []

    def has_capability(self, capability: str) -> bool:
        return False


login_manager.anonymous_user = AnonymousUser


class User(db.Model, BaseModel, UserMixin):
    __tablename__ = 'user'
    _description = 'Ein Nutzer'

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

    @classmethod
    def authenticate(self, email: str, password: str, remember: bool) -> Tuple['User', bool]:
        user = User.query.filter(User.email == email).first()

        if user:
            authenticated = user.check_password(password)
            if authenticated:
                login_user(user, remember=bool(remember))
        else:
            authenticated = False
        return user, authenticated

    @classmethod
    def email_exists(self, email: str, exclude_id: Optional[int] = None) -> bool:
        user = User.query.filter_by(email=email)
        if exclude_id:
            user = user.filter(User.id != exclude_id)
        return user.count() > 0

    def send_validation_email(self) -> None:
        recover_serializer = URLSafeTimedSerializer(current_app.config['SECRET_KEY'])
        validation_url = "%s/validate-email?id=%s" % (
            current_app.config['PROJECT_URL'],
            recover_serializer.dumps(
                [self.id, sha256(str.encode(self.password)).hexdigest()],
                salt=current_app.config['SECURITY_PASSWORD_SALT']
            )
        )
        if self.status == 'pre-registered-start':
            template = 'emails/validate-email-pre-register.txt'
        else:
            template = 'emails/validate-email.txt'
        msg = Message(
            "Bitte bestätigen Sie kurz Ihre Anmeldung",
            sender=current_app.config['MAILS_FROM'],
            recipients=[self.email],
            body=render_template(template, user=self, validation_url=validation_url)
        )
        mail.send(msg)

    def send_recover_email(self) -> None:
        recover_serializer = URLSafeTimedSerializer(current_app.config['SECRET_KEY'])
        validation_url = "%s/recover-check?id=%s" % (
            current_app.config['PROJECT_URL'],
            recover_serializer.dumps(
                [self.id, sha256(str.encode(self.password)).hexdigest()],
                salt=current_app.config['SECURITY_PASSWORD_SALT']
            )
        )
        msg = Message(
            "Ihr Passwort soll geändert werden",
            sender=current_app.config['MAILS_FROM'],
            recipients=[self.email],
            body=render_template('emails/recover-email.txt', user=self, validation_url=validation_url)
        )
        mail.send(msg)

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
