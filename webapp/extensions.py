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

# Flask-SQLAlchemy extension instance
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

# Flask-Login
from flask_login import LoginManager
login_manager = LoginManager()

# Flask-WTF csrf protection
from flask_wtf.csrf import CSRFProtect
csrf = CSRFProtect()

# Flask-Mail
from flask_mail import Mail
mail = Mail()

# Flask-Babel
from flask_babel import Babel
babel = Babel()

# Celery
from .common.celery import LogErrorsCelery
celery = LogErrorsCelery()

from flask_cors import CORS
cors = CORS()

# Redis
from flask_redis import FlaskRedis
redis = FlaskRedis()

from flask_httpauth import HTTPBasicAuth
auth = HTTPBasicAuth()

from .common.logger import Logger
logger = Logger()

from .api_documentation.ApiDocumentation import ApiDocumentation
api_documentation = ApiDocumentation()


