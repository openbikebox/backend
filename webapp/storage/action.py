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
from uuid import uuid4
from hashlib import sha256
from typing import Union, List
from datetime import datetime, timedelta
from ..extensions import db
from ..common.helpers import get_passcode, localize_datetime
from ..common.exceptions import BikeBoxAccessDeniedException, BikeBoxNotExistingException
from .base import BaseModel
from .resource_access import ResourceAccess
from .resource import Resource
from .location import Location
from .operator import Operator
from .pricegroup import Pricegroup
from .hardware import AuthMethod


class ActionStatus(Enum):
    reserved = 'reserved'
    booked = 'booked'
    timeouted = 'timeouted'
    cancelled = 'cancelled'
    disrupted = 'disrupted'


class PredefinedDaterange(Enum):
    day = 'day'
    week = 'week'
    month = 'month'
    year = 'year'


class Action(db.Model, BaseModel):
    __tablename__ = 'action'
    _description = 'Ein Buchungsvorgang'

    uid = db.Column(db.String(64), nullable=False, unique=True, info={'description': ''})
    request_uid = db.Column(db.String(64), nullable=False, info={'description': ''})
    session = db.Column(db.String(64), nullable=False, info={'description': ''})
    source = db.Column(db.String(128), index=True)
    user_identifier = db.Column(db.String(255))

    resource_id = db.Column(db.BigInteger)
    _resource = None
    location_id = db.Column(db.BigInteger)
    _location = None
    resource_access_id = db.Column(db.BigInteger)
    _resource_access = None
    pricegroup_id = db.Column(db.BigInteger)
    _pricegroup = None
    operator_id = db.Column(db.BigInteger)
    _operator = None

    resource_cache = db.Column(db.Text)
    location_cache = db.Column(db.Text)
    resource_access_cache = db.Column(db.Text)
    pricegroup_cache = db.Column(db.Text)
    operator_cache = db.Column(db.Text)

    requested_at = db.Column(db.DateTime, info={'description': ''})
    valid_till = db.Column(db.DateTime, info={'description': ''})
    paid_at = db.Column(db.DateTime, info={'description': ''})
    predefined_daterange = db.Column(db.Enum(PredefinedDaterange))
    begin = db.Column(db.DateTime, info={'description': ''})
    end = db.Column(db.DateTime, info={'description': ''})
    pin = db.Column(db.String(4))

    _auth_methods = db.Column('auth_methods', db.Integer)

    status = db.Column(db.Enum(ActionStatus), default=ActionStatus.reserved, nullable=False, info={'description': ''})

    value_gross = db.Column(db.Numeric(precision=8, scale=4), nullable=False, info={'description': ''})
    value_net = db.Column(db.Numeric(precision=8, scale=4), nullable=False, info={'description': ''})
    value_tax = db.Column(db.Numeric(precision=8, scale=4), nullable=False, info={'description': ''})
    tax_rate = db.Column(db.Numeric(precision=5, scale=4), nullable=False, info={'description': ''})

    def __init__(self):
        self.uid = str(uuid4())
        self.session = get_passcode(64)

    def set_cache(self, resource: 'Resource'):
        self.resource_id = resource.id
        self.location_id = resource.location_id
        self.resource_access_id = resource.resource_access_id
        self.pricegroup_id = resource.pricegroup_id
        self.operator_id = resource.location.operator_id
        self.resource_cache = resource.to_json()
        self.location_cache = resource.location.to_json(ignore=['geometry'])
        self._location = resource.location
        if resource.resource_access_id:
            self.resource_access_cache = resource.resource_access.to_json()
            self._resource_access = resource.resource_access
        self.pricegroup_cache = resource.pricegroup.to_json()
        self._pricegroup = resource.pricegroup
        self.operator_cache = resource.location.operator.to_json()
        self._operator = resource.location.operator

    @property
    def code(self) -> Union[str, None]:
        if self.status != ActionStatus.booked:
            return None
        if AuthMethod.code not in self.auth_methods:
            return None
        return self.generate_code()

    def generate_code(self):
        return None

    @property
    def location(self) -> Union['Location', None]:
        if not self._location:
            self._location = Location.query.get(self.location_id)
        return self._location

    @property
    def resource(self) -> Union['Resource', None]:
        if not self._resource:
            self._resource = Resource.query.get(self.resource_id)
        return self._resource

    @property
    def pricegroup(self) -> Union['Pricegroup', None]:
        if not self._pricegroup:
            self._pricegroup = Pricegroup.query.get(self.pricegroup_id)
        return self._pricegroup

    @property
    def resource_access(self) -> Union['ResourceAccess', None]:
        if not self._resource_access:
            self._resource_access = ResourceAccess.query.get(self.resource_access_id)
        return self._resource_access

    @property
    def operator(self) -> Union['Operator', None]:
        if not self._operator:
            self._operator = Operator.query.get(self.operator_id)
        return self._operator

    @property
    def begin_localized(self) -> Union[None, datetime]:
        if not self.begin:
            return
        return localize_datetime(self.begin)

    @property
    def end_localized(self) -> Union[None, datetime]:
        if not self.end:
            return
        return localize_datetime(self.end)

    def _get_auth_methods(self) -> List[AuthMethod]:
        if not self._auth_methods:
            return []
        return sorted(
            [item for item in list(AuthMethod) if item.value & self._auth_methods],
            key=lambda item: item.value
        )

    def _set_auth_methods(self, auth_methods: List[AuthMethod]) -> None:
        self._auth_methods = 0
        for supported_auth_method in auth_methods:
            self._auth_methods = self._auth_methods | supported_auth_method.value

    auth_methods = db.synonym('_auth_methods', descriptor=property(_get_auth_methods, _set_auth_methods))

    @classmethod
    def apiget(cls, uid: str, request_uid: str, session: str, hashed: bool = False):
        result = cls.query.filter_by(uid=uid).first()
        if not result:
            raise BikeBoxNotExistingException()
        if result.request_uid != request_uid:
            raise BikeBoxAccessDeniedException()
        if sha256(result.session.encode()).hexdigest() != session if hashed else result.session != session:
            raise BikeBoxAccessDeniedException()
        return result

    def to_dict(self, *args, extended: bool = False, **kwargs) -> dict:
        result = super().to_dict(*args, **kwargs)
        result['token'] = [{
            'type': 'code',
            'identifier': self.pin,
            'secret': self.code if self.code is not None else '00000',
            'date': (self.end - timedelta(hours=3)).strftime('%Y%m%d')
        }]
        if 'pin' in result:
            del result['pin']
        if extended:
            if self.resource:
                result['resource'] = {
                    'identifier': self.resource.user_identifier
                }
                if self.resource.hardware_id:
                    result['resource']['hardware'] = self.resource.hardware.to_dict()
            if self.location:
                result['location'] = self.location.to_dict(
                    fields=['id', 'name', 'slug', 'lat', 'lon'],
                    remove_none=kwargs.get('remove_none', False)
                )
            if self.operator:
                result['operator'] = self.operator.to_dict(
                    fields=['name'],
                    remove_none=kwargs.get('remove_none', False)
                )
        return result
