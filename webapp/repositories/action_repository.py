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

from typing import List
from decimal import Decimal
from datetime import datetime
from dataclasses import dataclass
from webapp.models import Action, Operator, Location, Resource, Hardware
from webapp.enum import ActionStatus, PredefinedDaterange
from .base_repository import BaseRepository


@dataclass
class ExportableAction:
    id: int
    uid: str
    source: str
    requested_at: datetime
    paid_at: datetime
    begin: datetime
    end: datetime
    status: ActionStatus
    value_gross: Decimal
    value_net: Decimal
    value_tax: Decimal
    user_identifier: str
    predefined_daterange: PredefinedDaterange
    operator_id: int
    operator_name: str
    location_id: int
    location_name: str
    location_address: str
    location_postalcode: str
    location_locality: str
    location_lat: Decimal
    location_lon: Decimal
    resource_id: int
    resource_identifier: str
    hardware_id: str
    hardware_name: str


class ActionRepository(BaseRepository):

    def fetch_exportable_actions(self, begin: datetime, end: datetime) -> List[ExportableAction]:
        actions_raw = self.session.query(
            Action.id, Action.uid, Action.requested_at, Action.paid_at, Action.begin, Action.end, Action.status,
            Action.value_gross, Action.value_net, Action.value_tax, Action.source, Action.user_identifier,
            Action.predefined_daterange, Operator.id.label('operator_id'), Operator.name.label('operator_name'),
            Location.id.label('location_id'), Location.name.label('location_name'),
            Location.address.label('location_address'), Location.postalcode.label('location_postalcode'),
            Location.locality.label('location_locality'), Location.lat.label('location_lat'),
            Location.lon.label('location_lon'), Resource.id.label('resource_id'),
            Resource.user_identifier.label('resource_identifier'), Hardware.id.label('hardware_id'),
            Hardware.name.label('hardware_name')
        ).filter(Action.created >= begin)\
            .filter(Action.created < end)\
            .join(Operator, Operator.id == Action.operator_id, isouter=True)\
            .join(Location, Location.id == Action.location_id, isouter=True)\
            .join(Resource, Resource.id == Action.resource_id, isouter=True)\
            .join(Hardware, Hardware.id == Resource.hardware_id, isouter=True)\
            .all()
        return [ExportableAction(**action_raw) for action_raw in actions_raw]




