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

from typing import Optional
from sqlalchemy import or_, and_
from datetime import timedelta, datetime
from ...common.helpers import get_local_now, get_now, unlocalize_datetime
from ...storage import Resource, Action
from ...enum import ActionStatus, ResourceStatus
from ...extensions import celery, db, logger
from .ResourceHelper import resource_status_at


def queue_status_checks():
    """
    this is done every night to live-update status during day
    """
    # check to clean up
    for resource in Resource.query.all():
        update_resource_status(resource)

    # queue possible changes during day
    begin_local = get_local_now().replace(hour=0, minute=0, second=0, microsecond=0)
    begin = unlocalize_datetime(begin_local)
    end = unlocalize_datetime((begin_local + timedelta(hours=25)).replace(hour=0))
    actions = Action.query\
        .filter(or_(and_(Action.begin >= begin, Action.begin < end), and_(Action.end >= begin, Action.end < end)))\
        .filter_by(status=ActionStatus.booked)\
        .all()
    for action in actions:
        logger.info('resource.status', 'queue action %s for resource status check' % action.id)
        eventually_queue_status_checks(action, begin, end)


def eventually_queue_status_checks(action: Action, begin: Optional[datetime] = None, end: Optional[datetime] = None):
    if not begin or not end:
        begin_local = get_local_now().replace(hour=0, minute=0, second=0, microsecond=0)
        begin = unlocalize_datetime(begin_local)
        end = unlocalize_datetime((begin_local + timedelta(hours=25)).replace(hour=0))
    if begin <= action.begin <= end:
        if action.begin <= get_now():
            logger.info('resource.status', 'check action %s for resource status at begin' % action.id)
            update_resource_status(action.resource_id)
        else:
            logger.info('resource.status', 'delay check action %s for resource status at begin' % action.id)
            update_resource_status_delay.delay((action.resource_id,), eta=action.begin)
    if begin <= action.end <= end:
        if action.end <= get_now():
            logger.info('resource.status', 'check action %s for resource status at end' % action.id)
            update_resource_status(action.resource_id)
        else:
            logger.info('resource.status', 'delay check action %s for resource status at end' % action.id)
            update_resource_status_delay.delay((action.resource_id,), eta=action.end)


@celery.task()
def update_resource_status_delay(resource_id: int):
    update_resource_status(resource_id)


def update_resource_status(resource_id: Optional[int] = None, resource: Optional[Resource] = None):
    resource = Resource.query.get(resource_id) if resource is None else resource
    if resource.status in [ResourceStatus.faulted, ResourceStatus.inactive]:
        return
    new_status = resource_status_at(resource.id, get_now())
    if resource.status == new_status:
        return
    logger.info('resource.status', 'set resource %s status from %s to %s' % (resource.id, resource.status, new_status))
    resource.status = new_status
    db.session.add(resource)
    db.session.commit()

