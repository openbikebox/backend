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

from datetime import datetime
from sqlalchemy import and_, or_
from typing import Optional, List
from ...models import Action
from ...enum import ActionStatus, ResourceStatus
from ...common.helpers import get_now


def resource_free_between(
        resource_id: int,
        begin: datetime,
        end: datetime,
        exclude_ids: Optional[List[int]] = None) -> bool:
    actions = Action.query \
        .filter_by(resource_id=resource_id) \
        .filter(Action.begin < end) \
        .filter(Action.end > begin)
    if exclude_ids is not None:
        actions = actions.filter(Action.id.notin_(exclude_ids))
    return actions.filter(or_(
        Action.status == ActionStatus.booked,
        and_(Action.status == ActionStatus.reserved, Action.valid_till > get_now())
    )).count() == 0


def resource_status_at(resource_id: int, moment: datetime) -> ResourceStatus:
    actions = Action.query \
        .with_entities(Action.id) \
        .filter(Action.resource_id == resource_id) \
        .filter(Action.begin <= moment) \
        .filter(Action.end >= moment) \
        .filter(or_(
            Action.status == ActionStatus.booked,
            and_(Action.status == ActionStatus.reserved, Action.valid_till > get_now())
        ))
    return ResourceStatus.free if actions.count() == 0 else ResourceStatus.taken
