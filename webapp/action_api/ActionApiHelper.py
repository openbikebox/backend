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

from ..extensions import celery, db
from ..models import Resource, Action
from ..enum import ResourceStatus, ActionStatus


@celery.task
def check_reservation_timeout(resource_id: int, action_id: int) -> None:
    resource = Resource.query.get(resource_id)
    action = Action.query.get(action_id)
    if not resource or not action:
        return
    if resource.status != ResourceStatus.reserved:
        return
    action.status = ActionStatus.timeouted
    db.session.add(action)
    resource.status = ResourceStatus.free
    db.session.add(resource)
    db.session.commit()
