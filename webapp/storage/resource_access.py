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

from ..extensions import db
from .base import BaseModel


class ResourceAccess(db.Model, BaseModel):
    __tablename__ = 'resource_access'
    _description = 'Eine Zugangs-Gruppe'

    resource = db.relationship('Resource', backref='resource_access', lazy='dynamic')
    location_id = db.Column(db.BigInteger, db.ForeignKey('location.id', use_alter=True), info={'description': 'location id'})

    internal_identifier = db.Column(db.String(255), info={'description': 'internal identifier'})
    salt = db.Column(db.String(255))
