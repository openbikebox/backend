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

import os


class BaseConfig:
    INSTANCE_FOLDER_PATH = os.path.join('/tmp', 'instance')

    PROJECT_NAME = "open-bike-box-backend"
    PROJECT_VERSION = '1.0.0'

    PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
    STATIC_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, os.pardir, 'static'))
    FILES_DIR = os.path.abspath(os.path.join(STATIC_DIR, 'files'))
    LOG_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, os.pardir, 'logs'))
    TEMP_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, os.pardir, 'temp'))
    PLUGIN_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, 'plugins'))
    TESTS_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, os.pardir, 'tests'))

    DEBUG = False
    TESTING = False
    MAINTENANCE_MODE = False

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = False

    CELERY_BROKER_URL = 'amqp://localhost'
    REDIS_URL = 'redis://localhost'

    BABEL_DEFAULT_LOCALE = 'de'
    BABEL_DEFAULT_TIMEZONE = 'Europe/Berlin'

    MAPBOX_CENTER_LAT = 51.470915
    MAPBOX_CENTER_LON = 7.219874
    MAPBOX_ZOOM = 13

    ITEMS_PER_PAGE = 25
    RESERVE_MINUTES = 30
    REPUTATION_TRASHOLD = 600

    MAIL_PORT = 587
    MAIL_USE_SSL = False
    MAIL_USE_TLS = True

    BASICAUTH = {}

    OPENAPI_CONTACT_MAIL = 'info@openbikebox.de'
    OPENAPI_TOS = 'https://openbikebox.de/api'
    OPENAPI_SERVERS = [
        {
            'url': 'https://backend.openbikebox.de',
            'description': 'production'
        },
        {
            'url': 'https://backend.openbikebox.next-site.de',
            'description': 'staging'
        }
    ]
