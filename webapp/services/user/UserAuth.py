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
from passlib.hash import bcrypt
from flask_login import login_user
from ...models import User
from ...extensions import db
from ...common.helpers import get_now


def user_authenticate(email: str, password: str, login_ip: str) -> Union[User, None]:
    user = User.query.filter_by(email=email).first()
    if not user:
        return
    if user.password is None:
        return
    if not bcrypt.verify(password, user.password):
        if not user.failed_login_count:
            user.failed_login_count = 0
        user.failed_login_count += 1
        db.session.add(user)
        db.session.commit()
        return
    login_user(user)
    user.last_failed_login_count = user.failed_login_count
    user.failed_login_count = 0
    user.last_login_datetime = user.login_datetime
    user.login_datetime = get_now()
    user.last_login_ip = user.login_ip
    user.login_ip = login_ip
    db.session.add(user)
    db.session.commit()
    return user
