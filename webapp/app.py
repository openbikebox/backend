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
import traceback
from hashlib import sha256
from flask import Flask, request, jsonify

from .config import Config
from .common.constants import BaseConfig
from .common.filter import register_global_filters
from .extensions import db, mail, celery, redis, cors, auth

# Blueprints
from .gbfs import gbfs_controller
from .tiles import tiles_controller
from .frontend import frontend
from .action_api import action_api
from .resource_api import resource_api
from .api_documentation.Controller import api_documentation_blueprint
from .common.reputation import reputation_cli

__all__ = ['launch']

BLUEPRINTS = [
    frontend,
    action_api,
    resource_api,
    api_documentation_blueprint,
    gbfs_controller,
    tiles_controller,
    reputation_cli
]


def launch():
    app = Flask(
        BaseConfig.PROJECT_NAME,
        instance_path=BaseConfig.INSTANCE_FOLDER_PATH,
        instance_relative_config=True,
        template_folder=os.path.join(BaseConfig.PROJECT_ROOT, 'templates')
    )
    configure_app(app)
    configure_hook(app)
    configure_blueprints(app)
    configure_extensions(app)
    configure_logging(app)
    configure_filters(app)
    configure_error_handlers(app)
    load_plugins(app)
    from .common import filter
    return app


def configure_app(app):
    app.config.from_object(Config)
    app.config['MODE'] = os.getenv('APPLICATION_MODE', 'DEVELOPMENT')
    print("Running in %s mode" % app.config['MODE'])


def configure_extensions(app):
    db.init_app(app)

    @auth.verify_password
    def verify_password(username, password):
        if username not in app.config['BASICAUTH'] or not password:
            return None
        if sha256(password.encode()).hexdigest() == app.config['BASICAUTH'][username]['password']:
            return username

    cors.init_app(app)
    mail.init_app(app)
    celery.init_app(app)
    redis.init_app(app)


def configure_blueprints(app):
    for blueprint in BLUEPRINTS:
        app.register_blueprint(blueprint)


def configure_filters(app):
    register_global_filters(app)


def load_plugins(app):
    if os.path.exists(app.config['PLUGIN_DIR']):
        import webapp.plugins


def configure_logging(app):
    if not os.path.exists(app.config['LOG_DIR']):
        os.makedirs(app.config['LOG_DIR'])

    from logging import INFO, DEBUG, ERROR, handlers, Formatter
    app.logger.setLevel(DEBUG)

    app_log_file = os.path.join(app.config['LOG_DIR'], 'app.log')
    app_log_handler = handlers.RotatingFileHandler(app_log_file, maxBytes=100000, backupCount=10)
    app_log_handler.setLevel(INFO)
    app_log_handler.setFormatter(Formatter(
        '%(asctime)s %(levelname)s: %(message)s ')
    )
    app.logger.addHandler(app_log_handler)


def configure_hook(app):
    @app.before_request
    def before_request():
        from .common.reputation import reputation_add
        reputation_add(1)


def configure_error_handlers(app):
    @app.errorhandler(403)
    def error_403(error):
        from .common.reputation import reputation_add
        reputation_add(5)
        return jsonify({'status': -1, 'code': 403})

    @app.errorhandler(404)
    def error_404(error):
        from .common.reputation import reputation_add
        reputation_add(5)
        return jsonify({'status': -1, 'code': 404})

    @app.errorhandler(429)
    def error_429(error):
        if request.path.startswith('/api'):
            return jsonify({'status': -1, 'code': 429})

    @app.errorhandler(500)
    def error_500(error):
        from .extensions import logger
        logger.critical('app', str(error), traceback.format_exc())
        from .common.reputation import reputation_add
        reputation_add(10)
        return jsonify({'status': -1, 'code': 500})

    if not app.config['DEBUG']:
        @app.errorhandler(Exception)
        def internal_server_error(error):
            from .extensions import logger
            logger.critical('app', str(error), traceback.format_exc())
            from .common.reputation import reputation_add
            reputation_add(10)
            return jsonify({'status': -1, 'code': 500})
