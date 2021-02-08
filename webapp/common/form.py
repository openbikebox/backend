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

from typing import List
from flask import current_app
from flask_wtf import FlaskForm
from flask_babel import _
from wtforms import IntegerField, SelectField, SubmitField, StringField, IntegerField, FloatField
from wtforms import validators
from ..common.form_field import DateTimeField


class SchemaForm:
    @property
    def schema(self) -> dict:
        result = {
            '$schema': 'http://json-schema.org/draft-07/schema#',
            '$id': '%s/%s.schema.json' % (current_app.config['SCHEMA_URL'], getattr(self.meta, 'schema_id', 'generic')),
            'title': getattr(self.meta, 'schema_title', 'generic'),
            'type': 'object',
            'properties': {}
        }
        if getattr(self.meta, 'schema_description'):
            result['description'] = getattr(self.meta, 'schema_description')
        required = []
        for item in self.data:
            result['properties'][item] = self.schema_field(item, required)
        result['required'] = required
        return result

    def schema_field(self, item: str, required: List[str]) -> dict:
        field = getattr(self, item)
        field_validators = {type(validator): validator for validator in getattr(field, 'validators', [])}
        result = {}
        if type(field) in [StringField, DateTimeField, SelectField]:
            result['type'] = 'string'
            if validators.Length in field_validators:
                if getattr(field_validators[validators.Length], 'min') != -1:
                    result['minLength'] = getattr(field_validators[validators.Length], 'min')
                if getattr(field_validators[validators.Length], 'max') != -1:
                    result['maxLength'] = getattr(field_validators[validators.Length], 'max')
        if type(field) is DateTimeField:
            result['format'] = 'date-time'
        if type(field) is IntegerField:
            result['type'] = 'integer'
            if validators.NumberRange in field_validators:
                if getattr(field_validators[validators.NumberRange], 'min'):
                    result['minimum'] = getattr(field_validators[validators.NumberRange], 'min')
                if getattr(field_validators[validators.NumberRange], 'max'):
                    result['maximum'] = getattr(field_validators[validators.NumberRange], 'max')
        if getattr(field, 'description'):
            result['description'] = getattr(field, 'description')
        if validators.DataRequired in field_validators:
            required.append(item)

        return result
