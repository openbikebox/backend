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

import json
from typing import Optional, List
from sqlalchemy.types import UserDefinedType
from sqlalchemy.sql.sqltypes import DateTime, Numeric, Enum, String, Boolean, Integer, Text, Date, SmallInteger
from flask import current_app
from ..extensions import db
from ..common.helpers import get_current_time, localize_datetime, DefaultJSONEncoder


class BaseModel:
    __tablename__ = None
    __table_args__ = {
        'mysql_charset': 'utf8',
        'mysql_collate': 'utf8_unicode_ci'
    }
    _description = 'generic object'
    version = '1.0'

    id = db.Column(db.BigInteger, primary_key=True)
    created = db.Column(db.DateTime, nullable=False, default=get_current_time)
    modified = db.Column(db.DateTime, nullable=False, default=get_current_time)

    def to_dict(
            self,
            localized: bool = False,
            with_cache: bool = False,
            fields: Optional[List[str]] = None,
            ignore: Optional[List[str]] = None,
            remove_none: bool = False) -> dict:
        result = {'id_url': self.id_url} if fields and 'id_url' in fields else {}
        for field in self.metadata.tables[self.__tablename__].c.keys():
            if fields is not None and field not in fields:
                continue
            if ignore is not None and field in ignore:
                continue
            if getattr(self, field) is None and remove_none:
                continue
            if field.endswith('_cache') and not with_cache:
                continue
            if localized and type(self.metadata.tables.get(self.__tablename__).c[field].type) is DateTime and getattr(self, field):
                result[field] = localize_datetime(getattr(self, field))
                continue
            result[field] = getattr(self, field)
        return result

    def to_json(self, *args, **kwargs) -> str:
        return json.dumps(self.to_dict(*args, **kwargs), cls=DefaultJSONEncoder)

    @property
    def id_url(self):
        return '%s/api/%s/%s' % (current_app.config['PROJECT_URL'], self.__tablename__, self.id)

    @classmethod
    def to_json_schema(cls) -> dict:
        result = {}
        for field in cls.metadata.tables[cls.__tablename__].c.keys():
            field_type = cls.metadata.tables.get(cls.__tablename__).c[field].type
            if type(field_type) is Boolean:
                result[field] = {
                    'type': 'boolean'
                }
            elif type(field_type) is Integer:
                result[field] = {
                    'type': 'integer'
                }
            elif type(field_type) is SmallInteger:
                result[field] = {
                    'type': 'integer'
                }
            elif type(field_type) in [String, Text]:
                result[field] = {
                    'type': 'string'
                }
                if field_type.length:
                    result[field]['maxLength'] = field_type.length
            elif type(field_type) is Enum:
                result[field] = {
                    'type': 'string',
                    'enum': field_type.enums
                }
            elif type(field_type) is Numeric:
                result[field] = {
                    'type': 'string',
                    'pattern': "^[+-]?\d+(\.\d+)?$"
                }
            elif type(field_type) is Date:
                result[field] = {
                    'type': 'string',
                    'format': 'date'
                }
            elif type(field_type) is DateTime:
                result[field] = {
                    'type': 'string',
                    'format': 'date-time'
                }
            if field in result:
                result[field]['description'] = cls.metadata.tables.get(cls.__tablename__).c[field].info.get('description', '')
        return {
            '$schema': 'http://json-schema.org/draft-07/schema#',
            'title': cls.__name__,
            'type': 'object',
            'description': cls._description,
            'properties': result
        }


class Point(UserDefinedType):
    def get_col_spec(self):
        return 'POINT'
