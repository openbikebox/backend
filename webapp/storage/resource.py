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

from enum import Enum
from lxml import etree
from ..extensions import db
from .base import BaseModel


class ResourceStatus(Enum):
    free = 'free'
    taken = 'taken'
    reserved = 'reserved'
    inactive = 'inactive'
    faulted = 'faulted'


resource_file = db.Table(
    'resource_file',
    db.Column('resource_id', db.BigInteger, db.ForeignKey('resource.id')),
    db.Column('file_id', db.BigInteger, db.ForeignKey('file.id'))
)

resource_alert = db.Table(
    'resource_alert',
    db.Column('resource_id', db.BigInteger, db.ForeignKey('resource.id')),
    db.Column('alert_id', db.BigInteger, db.ForeignKey('alert.id'))
)


class Resource(db.Model, BaseModel):
    __tablename__ = 'resource'
    _description = 'Eine buchbare Ressource'

    photos = db.relationship('File', secondary=resource_file, backref=db.backref('resources', lazy='dynamic'))
    alerts = db.relationship('Alert', secondary=resource_alert, backref=db.backref('resources', lazy='dynamic'))

    location_id = db.Column(db.BigInteger, db.ForeignKey('location.id', use_alter=True), info={'description': 'location id'})
    pricegroup_id = db.Column(db.BigInteger, db.ForeignKey('pricegroup.id', use_alter=True), info={'description': 'pricegroup id'})
    hardware_id = db.Column(db.BigInteger, db.ForeignKey('hardware.id', use_alter=True), info={'description': 'hardware id'})
    resource_group_id = db.Column(db.BigInteger, db.ForeignKey('resource_group.id', use_alter=True), info={'description': 'resource group id'})
    resource_access_id = db.Column(db.BigInteger, db.ForeignKey('resource_access.id', use_alter=True), info={'description': 'resource access id'})
    photo_id = db.Column(db.BigInteger, db.ForeignKey('file.id', use_alter=True), info={'description': 'file id'})

    name = db.Column(db.String(255), info={'description': 'public name'})
    slug = db.Column(db.String(255), index=True, unique=True, info={'description': 'slug'})
    description = db.Column(db.Text, info={'description': 'public description'})
    internal_identifier = db.Column(db.String(255), info={'description': 'internal identifier'})
    user_identifier = db.Column(db.String(255), info={'description': 'user readable identifier'})
    status = db.Column(db.Enum(ResourceStatus), info={'description': 'current status, does not include booking status'})
    unavailable_until = db.Column(db.DateTime, info={'description': 'booked until'})
    installed_at = db.Column(db.DateTime, info={'description': 'installed at'})
    maintenance_from = db.Column(db.DateTime, info={'description': 'location id'})
    maintenance_till = db.Column(db.DateTime, info={'description': 'location id'})
    polygon_top = db.Column(db.Float)
    polygon_right = db.Column(db.Float)
    polygon_bottom = db.Column(db.Float)
    polygon_left = db.Column(db.Float)

    def to_dict(self, *args, **kwargs) -> dict:
        result = super().to_dict(*args, **kwargs)
        if 'user_identifier' in result:
            result['identifier'] = result['user_identifier']
            del result['user_identifier']
        return result

    @property
    def future_booking(self):
        return self.location.operator.future_booking and self.hardware.future_booking

    @property
    def polygon_geojson(self) -> dict:
        return {
            'type': 'Feature',
            'geometry': {
                'type': 'Polygon',
                'coordinates': [[
                    [self.polygon_left, self.polygon_top],
                    [self.polygon_left, self.polygon_bottom],
                    [self.polygon_right, self.polygon_bottom],
                    [self.polygon_right, self.polygon_top],
                    [self.polygon_left, self.polygon_top]
                ]]
            },
            'properties': {
                'id': self.id,
                'identifier': self.user_identifier,
                'status': self.status,
                'pricegroup_id': self.pricegroup_id,
                'hardware_id': self.hardware_id
            }
        }

    @property
    def polygon_svg(self) -> etree.Element:
        elem = etree.Element('polygon')
        elem.attrib['points'] = '{3},{0} {3},{1} {2},{1} {2},{0} {3},{0}'.format(self.polygon_top, self.polygon_bottom, self.polygon_right, self.polygon_left)
        elem.attrib['data-id'] = str(self.id)
        elem.attrib['data-identifier'] = self.user_identifier
        elem.attrib['data-status'] = self.status.value
        elem.attrib['data-pricegroup-id'] = str(self.pricegroup_id)
        elem.attrib['data-hardware-id'] = str(self.hardware_id)
        return elem
