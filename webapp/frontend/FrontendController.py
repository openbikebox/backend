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
import json
import time
from flask import Blueprint, request, current_app, render_template, redirect
from flask_login import current_user
from ..models import Option
from ..common.response import json_response
from ..services.user.UserAuth import user_authenticate

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


@frontend.route('/login', methods=['GET', 'POST'])
def login_html():
    if current_user.is_authenticated:
        return redirect('/admin')
    if request.method == 'POST':
        if user_authenticate(
                request.form.get('email'),
                request.form.get('password'),
                request.headers.get('X-Forwarded-For', None)
        ):
            return redirect('/admin')
    return render_template('login.html')


@frontend.route('/admin')
@frontend.route('/admin/<path:any_path>')
def admin_html(any_path=None):
    if not current_user.is_authenticated:
        return redirect('/login')
    if os.path.isfile(os.path.join(current_app.config['STATIC_DIR'], 'webpack-assets.json')):
        with open(os.path.join(current_app.config['STATIC_DIR'], 'webpack-assets.json')) as json_file:
            data = json.load(json_file)
            print(data)
            return render_template(
                'admin.html',
                css_file=data.get('main', {}).get('css'),
                js_file=data.get('main', {}).get('js')
            )
    return render_template('admin.html')
