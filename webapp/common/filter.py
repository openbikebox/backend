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
import pytz
import math
import decimal
import datetime
from dateutil.parser import parse as dateutil_parse
from urllib.parse import quote_plus
from flask import current_app
from flask_babel import _
from .misc import DefaultJSONEncoder


def register_global_filters(app):
    app.json_encoder = DefaultJSONEncoder

    @app.template_filter('commatize')
    def commatize(value):
        output = str(value).replace('.', ',')
        return output

    @app.template_filter('decimal')
    def to_decimal(value):
        if not value:
            return 0
        return decimal.Decimal(value)

    @app.template_filter('beautifuljson')
    def template_beautifiljson(data):
        if not data:
            return ''
        if type(data) == str:
            data = json.loads(data)
        return json.dumps(data, indent=4)

    @app.template_filter('tax')
    def to_decimal(value):
        return str(value * 100).rstrip('0').rstrip('.').replace('.', ',')

    @app.template_filter('jsontolist')
    def json_to_dict(value):
        try:
            return json.loads(value)
        except (ValueError, TypeError):
            return []

    @app.template_filter('ceil')
    def template_price(value):
        return math.ceil(value)

    @app.template_filter('datetime')
    def template_datetime(value, format='medium'):
        if not value:
            return '...'
        if type(value) == str:
            value = dateutil_parse(value)
        if not value.tzinfo:
            value = pytz.UTC.localize(value).astimezone(pytz.timezone('Europe/Berlin'))
        elif value.tzname() == 'UTC':
            value = value.astimezone(pytz.timezone('Europe/Berlin'))
        if format == 'full':
            strftime_format = "%A, der %d.%m.%y um %H:%M Uhr"
        elif format == 'medium':
            strftime_format = "%d.%m.%y, %H:%M"
        elif format == 'short':
            strftime_format = "%d.%m., %H:%M"
        elif format == 'fulldate':
            strftime_format = "%d.%m.%Y"
        else:
            return '-'
        value = value.strftime(strftime_format)
        return value

    @app.template_filter('date')
    def to_decimal(value):
        if not value:
            return None
        return value.strftime("%d.%m.%Y")

    @app.template_filter('price')
    def template_price(value, digits=2):
        if not value:
            return '0,00 €'
        output = str(round(value, digits)).replace('.', ',')
        if digits == 3 and output[-1] == '0':
            output = output[0:-1]
        return output + ' €'

    @app.template_filter('timedelta')
    def template_timedelta(value, format='medium'):
        result = "%2d" % math.floor(value / 60 / 60)
        if math.floor((value / 60) % 60) or math.floor(value % 60):
            result += ":%02d" % math.floor((value / 60) % 60)
        if math.floor(value % 60):
            result += ":%02d" % math.floor(value % 60)

        if format == 'medium':
            result += ' ' + _('Stunden')
        return result

    @app.template_filter('filter_list')
    def filter_list(list, field, value):
        return [item for item in list if item.get(field) == value]

    @app.context_processor
    def primary_processor():
        def combine_datetime(datetime_from, datetime_till, link=' - ', format='medium'):
            if not datetime_from:
                return '-'
            if type(datetime_from) == str:
                datetime_from = dateutil_parse(datetime_from)
            if not datetime_from.tzinfo:
                datetime_from = pytz.UTC.localize(datetime_from).astimezone(pytz.timezone('Europe/Berlin'))
            elif datetime_from.tzname() == 'UTC':
                datetime_from = datetime_from.astimezone(pytz.timezone('Europe/Berlin'))
            if not datetime_till:
                return template_datetime(datetime_from, format) + link + '...'
            if type(datetime_till) == str:
                datetime_till = dateutil_parse(datetime_till)
            if not datetime_till.tzinfo:
                datetime_till = pytz.UTC.localize(datetime_till).astimezone(pytz.timezone('Europe/Berlin'))
            elif datetime_till.tzname() == 'UTC':
                datetime_till = datetime_till.astimezone(pytz.timezone('Europe/Berlin'))

            if datetime_from.year == datetime_till.year and datetime_from.month == datetime_till.month and datetime_from.day == datetime_till.day:
                strftime_format_day = "%d.%m.%y"
                strftime_format_time = "%H:%M"
                return "%s, %s%s%s" % (
                    datetime_from.strftime(strftime_format_day), datetime_from.strftime(strftime_format_time), link,
                    datetime_till.strftime(strftime_format_time)
                )
            else:
                return template_datetime(datetime_from, format) + link + template_datetime(datetime_till, format)

        return dict(combine_datetime=combine_datetime)

    @app.context_processor
    def inject_now():
        return {'now': datetime.datetime.now()}

    @app.template_filter('urlencode')
    def urlencode(data):
        return (quote_plus(data))

    @app.context_processor
    def static_content():
        if not os.path.isfile(os.path.join(current_app.config['STATIC_DIR'], 'webpack-assets.json')):
            return None
        with open(os.path.join(current_app.config['STATIC_DIR'], 'webpack-assets.json')) as json_file:
            data = json.load(json_file)
            return dict(static_content=data)
