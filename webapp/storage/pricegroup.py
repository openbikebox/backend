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


class Pricegroup(db.Model, BaseModel):
    __tablename__ = 'pricegroup'
    _description = 'Eine Preisgruppe'

    resource = db.relationship('Resource', backref='pricegroup', lazy='dynamic')

    operator_id = db.Column(db.BigInteger, db.ForeignKey('operator.id', use_alter=True), info={'description': 'operator id'})

    fee_hour = db.Column(db.Numeric(precision=7, scale=4), default=0)
    fee_day = db.Column(db.Numeric(precision=7, scale=4), default=0)
    fee_week = db.Column(db.Numeric(precision=7, scale=4), default=0)
    fee_month = db.Column(db.Numeric(precision=7, scale=4), default=0)
    fee_year = db.Column(db.Numeric(precision=7, scale=4), default=0)

    @classmethod
    def get_timespan(cls, begin, end):
        if (end - begin).days > 32:
            return 'year'
        if (end - begin).days > 8:
            return 'month'
        if (end - begin).days > 2:
            return 'week'
        return 'day'
