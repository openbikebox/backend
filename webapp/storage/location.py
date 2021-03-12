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

from lxml import etree
from flask import current_app
from ..extensions import db
from .base import BaseModel


class Location(db.Model, BaseModel):
    __tablename__ = 'location'

    operator_id = db.Column(db.BigInteger, db.ForeignKey('operator.id', use_alter=True), info={'description': 'operator id'})
    resource = db.relationship('Resource', backref='location', lazy='dynamic')
    resource_group = db.relationship('ResourceGroup', backref='location', lazy='dynamic')
    resource_access = db.relationship('ResourceAccess', backref='location', lazy='dynamic')

    photo_id = db.Column(db.BigInteger, db.ForeignKey('file.id', use_alter=True), info={'description': 'file id'})

    name = db.Column(db.String(255), info={'description': 'public name'})
    slug = db.Column(db.String(255), index=True, unique=True, info={'description': 'slug'})

    lat = db.Column(db.Numeric(precision=10, scale=7), info={'description': 'lat'})
    lon = db.Column(db.Numeric(precision=10, scale=7), info={'description': 'lon'})

    address = db.Column(db.String(255), info={'description': 'street and number'})
    postalcode = db.Column(db.String(255), info={'description': 'postalcode'})
    locality = db.Column(db.String(255), info={'description': 'locality'})
    country = db.Column(db.String(2), info={'description': 'country'})
    description = db.Column(db.Text, info={'description': 'public description'})

    osm_id = db.Column(db.BigInteger, info={'description': 'openstreetmap id'})

    @property
    def booking_url(self) -> str:
        return '%s/location/%s' % (current_app.config['FRONTEND_URL'], self.slug)

    @property
    def polygon_geojson(self) -> dict:
        return {
            'type': 'FeatureCollection',
            'features': [resource.polygon_geojson for resource in self.resource]
        }

    def to_dict(self, *args, **kwargs):
        result = super().to_dict(*args, **kwargs)
        if 'lat' in result:
            result['lat'] = float(result['lat'])
        if 'lon' in result:
            result['lon'] = float(result['lon'])
        return result

    @property
    def polygon_svg(self) -> etree.Element:
        root = etree.Element('svg', nsmap={
            None: 'http://www.w3.org/2000/svg',
            'xlink': 'http://www.w3.org/1999/xlink'
        })
        root.attrib['viewBox'] = "0 0 10 10"
        for resource in self.resource:
            root.append(resource.polygon_svg)
        return root
