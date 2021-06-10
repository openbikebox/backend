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

import re
import pytz
import json
import codecs
import string
import requests
import translitcodec
from passlib.hash import bcrypt
from random import SystemRandom
from typing import Union, Optional
from json.decoder import JSONDecodeError
from datetime import datetime, timedelta, date
from requests.exceptions import ConnectionError
from urllib3.exceptions import NewConnectionError
from dateutil.parser import parse as dateutil_parse
from flask import current_app
from ..extensions import logger
from .misc import DefaultJSONEncoder

authcode_chars = string.ascii_uppercase + string.ascii_lowercase + string.digits


def get_passcode(length):
    return ''.join(SystemRandom().choice(authcode_chars) for counter in range(length))


def localtime(value: Union[None, str, datetime]) -> str:
    if not value:
        return value
    if type(value) == str:
        value = dateutil_parse(value)
    if not value.tzinfo:
        value = pytz.UTC.localize(value).astimezone(pytz.timezone('Europe/Berlin'))
    return value.strftime('%Y-%m-%dT%H:%M:%S')


def send_json(url: str, data: dict, log: str, message: str, auth: Optional[tuple] = None) -> Union[dict, None]:
    data = json.dumps(data, cls=DefaultJSONEncoder)
    headers = {'content-type': 'application/json'}
    try:
        kwargs = {}
        if auth:
            kwargs['auth'] = auth
        r = requests.post(url, data=data, headers=headers, **kwargs)
        return r.json()
    except (ConnectionError, NewConnectionError, JSONDecodeError):
        logger.error(log, message)
        return None


def hash_password(password: str, salt: Optional[str] = False) -> str:
    if salt:
        return bcrypt.hash(password, salt=salt)
    return bcrypt.hash(password)


def get_current_date() -> date:
    return date.today()


def get_current_time() -> datetime:
    return datetime.utcnow()


def get_current_time_local() -> datetime:
    return datetime.now()


def get_current_time_plus(days: int = 0, hours: int = 0, minutes: int = 0, seconds: int = 0) -> datetime:
    return get_current_time() + timedelta(days=days, hours=hours, minutes=minutes, seconds=seconds)


def slugify(text: str, delim: str = '-') -> str:
    _punct_re = re.compile(r'[\t !"#$%&\'()*\-/<=>?@\[\\\]^_`{|},.]+')

    result = []
    for word in _punct_re.split(text.lower()):
        word = codecs.encode(word, 'translit/long')
        if word:
            result.append(word)
    return delim.join(result)


def localize_datetime(value: datetime) -> Union[datetime, None]:
    if not value:
        return
    return pytz.UTC.localize(value).astimezone(pytz.timezone('Europe/Berlin'))


def unlocalize_datetime(value: datetime) -> Union[datetime, None]:
    if not value:
        return
    return pytz.timezone('Europe/Berlin').localize(value).astimezone(pytz.UTC)


def get_now() -> datetime:
    """
    helper which normally gives back current utc datetime, but can be modified for tests
    :return: utc datetime
    """
    return datetime.utcnow()


def get_local_now() -> datetime:
    """
    helper which normally gives back current utc datetime, but can be modified for tests
    :return: utc datetime
    """
    return datetime.now()



def get_today() -> date:
    """
    helper which normally gives back today, but can be modified for tests
    :return: today
    """
    return date.today()


def is_offline() -> bool:
    """
    helper which normally gives status online, but can be modified for tests
    :return: today
    """
    return False
