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

import time
from flask import Blueprint, current_app, render_template
from ..models import Option
from ..common.response import json_response

frontend = Blueprint('frontend', __name__, template_folder='templates')


@frontend.route('/status')
def status():
    try:
        start = time.time()
        option = Option.get('app-status', 1)
    except:
        return json_response({
            'status': -1
        })
    return json_response({
        'status': 0 if option == 1 else -1,
        'version': current_app.config['PROJECT_VERSION'],
        'db': {
            'status': 'online',
            'time': round((time.time() - start) * 1000)
        }
    })


@frontend.route('/browserconfig.xml')
def browserconfig_xml():
    return render_template('browserconfig.xml')


@frontend.route('/admin')
def admin_html():
    return render_template('admin.html')
