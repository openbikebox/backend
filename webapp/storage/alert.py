# encoding: utf-8

"""
Giro-e OCHP
Copyright (c) 2017 - 2021, binary butterfly GmbH
All rights reserved.
"""

from enum import Enum
from .base import BaseModel
from ..extensions import db


class AlertType(Enum):
    other = 'other'
    closure = 'closure'


class Alert(db.Model, BaseModel):
    __tablename__ = "alert"

    operator_id = db.Column(db.BigInteger, db.ForeignKey('operator.id'))

    active = db.Column(db.Boolean)
    url = db.Column(db.String(255))
    type = db.Column(db.Enum(AlertType))
    summary = db.Column(db.Text)
    description = db.Column(db.Text)
    start = db.Column(db.DateTime(timezone=True))
    end = db.Column(db.DateTime(timezone=True))
