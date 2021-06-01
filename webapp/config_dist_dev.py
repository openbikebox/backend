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

from hashlib import sha256
from .common.constants import BaseConfig


class Config(BaseConfig):
    PROJECT_URL = 'http://your-hostname:5000'
    SCHEMA_URL = 'http://your-hostname:5000/schema'

    DEBUG = True
    TESTING = True

    ADMINS = ['admin@openbikebox.de']
    MAILS_FROM = 'no-reply@openbikebox.de'

    SECRET_KEY = 'please-insert-random-key'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:root@mysql/open-bike-box-backend'
    SQLALCHEMY_ENGINE_OPTIONS = {'pool_size': 100, 'pool_recycle': 600}

    MAIL_SERVER = 'please-insert-mail-hostname'
    MAIL_USERNAME = 'please-insert-mail-user'
    MAIL_PASSWORD = 'please-insert-mail-password'

    CELERY_BROKER_URL = 'amqp://rabbitmq'
    SOCKETIO_QUEUE = 'amqp://rabbitmq'
    REDIS_URL = 'redis://redis'

    BASICAUTH = {
        'integration-test': {
            'password': sha256(b'integration-test').hexdigest(),
            'capabilities': [1]
        }
    }
