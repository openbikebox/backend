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


class Operator(db.Model, BaseModel):
    __tablename__ = 'operator'
    _description = 'Betreiber von Ressourcen'

    location = db.relationship('Location', backref='operator', lazy='dynamic')
    logo_id = db.Column(db.BigInteger, db.ForeignKey('file.id', use_alter=True), info={'description': 'file id'})

    tax_rate = db.Column(db.Numeric(precision=5, scale=4), nullable=False, info={'description': ''})

    name = db.Column(db.String(255), info={'description': 'public name'})
    slug = db.Column(db.String(255), index=True, unique=True, info={'description': 'slug'})
    description = db.Column(db.Text, info={'description': 'public description'})
    address = db.Column(db.String(255), info={'description': 'public address'})
    postalcode = db.Column(db.String(255), info={'description': 'public postalcode'})
    locality = db.Column(db.String(255), info={'description': 'public locality'})
    country = db.Column(db.String(2), info={'description': 'public country'})
    url = db.Column(db.String(255))
    email = db.Column(db.String(255))
    future_booking = db.Column(db.String(255))
