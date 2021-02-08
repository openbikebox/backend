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
from ..common.enum import ResourceGroupStatus


resource_group_image = db.Table(
    'resource_group_image',
    db.Column('resource_group_id', db.BigInteger, db.ForeignKey('resource_group.id')),
    db.Column('file_id', db.BigInteger, db.ForeignKey('file.id'))
)


class ResourceGroup(db.Model, BaseModel):
    __tablename__ = 'resource_group'
    _description = 'Eine Ressourcen-Gruppe (z.B. für mehrstöckige Anlagen)'

    location_id = db.Column(db.BigInteger, db.ForeignKey('location.id', use_alter=True), info={'description': 'location id'})
    images = db.relationship('File', secondary=resource_group_image, backref=db.backref('resource_group', lazy='dynamic'))
    resource = db.relationship('Resource', backref='resource_group', lazy='dynamic')

    name = db.Column(db.String(255), info={'description': 'public name'})
    description = db.Column(db.Text, info={'description': 'public description'})
    slug = db.Column(db.String(255), index=True, unique=True, info={'description': 'slug'})
    internal_identifier = db.Column(db.String(255), info={'description': 'internal identifier'})
    user_identifier = db.Column(db.String(255), info={'description': 'user readable identifier'})
    status = db.Column(db.Enum(ResourceGroupStatus), info={'description': 'current status'})
    max_bookingdate = db.Column(db.Integer, info={'description': 'max days in future which can be booked'})
    installed_at = db.Column(db.DateTime, info={'description': 'installed at'})
    maintenance_from = db.Column(db.DateTime, info={'description': 'maintenance from'})
    maintenance_till = db.Column(db.DateTime, info={'description': 'maintenance till'})
