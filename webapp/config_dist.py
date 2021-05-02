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

from .common.constants import BaseConfig


class Config(BaseConfig):
    PROJECT_URL = 'https://your-hostname.tld'
    SCHEMA_URL = 'https://schema.your-hostname.tld'

    ADMINS = ['admin@openbikebox.de']
    MAILS_FROM = 'no-reply@openbikebox.de'

    SECRET_KEY = 'please-insert-random-key'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://please-insert-user:please-insert-password@mysql/please-insert-database'

    MAIL_SERVER = 'please-insert-mail-hostname'
    MAIL_USERNAME = 'please-insert-mail-user'
    MAIL_PASSWORD = 'please-insert-mail-password'

    CELERY_BROKER_URL = 'amqp://please-insert-rabbitmq-hostname'
    SOCKETIO_QUEUE = 'amqp://please-insert-rabbitmq-hostname'
