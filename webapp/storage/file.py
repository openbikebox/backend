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

from typing import Optional, List
from flask import current_app
from ..extensions import db
from .base import BaseModel


class File(db.Model, BaseModel):
    __tablename__ = 'file'
    _description = 'Eine Datei'

    operator = db.relationship('Operator', backref='logo', lazy='dynamic')
    location = db.relationship('Location', backref='photo', lazy='dynamic')
    resource = db.relationship('Resource', backref='photo', lazy='dynamic')

    name = db.Column(db.String(255), info={'description': 'name'})
    mimetype = db.Column(db.String(255))

    file_extensions = {
        'image/jpeg': 'jpg',
        'image/png': 'png',
        'image/svg+xml': 'svg'
    }

    def to_dict(
            self,
            localized: bool = False,
            with_cache: bool = False,
            fields: Optional[List[str]] = None,
            ignore: Optional[List[str]] = None,
            remove_none: bool = False) -> dict:
        result = super(File, self).to_dict(localized, with_cache, fields, ignore, remove_none)
        if 'url' in fields:
            result['url'] = self.url
        return result

    @property
    def url(self) -> str:
        return '%s/static/files/%s.%s' % (current_app.config['PROJECT_URL'], self.id, self.file_extension)

    @property
    def file_extension(self) -> str:
        return self.file_extensions.get(self.mimetype, '')
