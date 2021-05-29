# encoding: utf-8

"""
Giro-e OCHP
Copyright (c) 2017 - 2021, binary butterfly GmbH
All rights reserved.
"""

from typing import Optional, List
from .base import BaseModel
from ..extensions import db


class RegularHours(db.Model, BaseModel):
    __tablename__ = "regular_hours"

    location_id = db.Column(db.BigInteger, db.ForeignKey('location.id'))

    weekday = db.Column(db.SmallInteger)
    period_begin = db.Column(db.Integer)
    period_end = db.Column(db.Integer)
