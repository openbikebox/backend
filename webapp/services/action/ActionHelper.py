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

from typing import Union
from wtfjson.util import UnsetValue
from datetime import timedelta, datetime
from ...models import Action, Pricegroup, Resource
from ...common.helpers import get_current_time_local, unlocalize_datetime, localize_datetime
from ...extensions import celery, db, logger
from ...enum import ActionStatus
from ..resource.ResourceStatusService import update_resource_status
from ...services.pricegroup.PriceCalculation import calculate_detailed_price


predefined_daterange_def = {
    'day': timedelta(days=1),
    'week': timedelta(days=7),
    'month': timedelta(days=31),
    'year': timedelta(days=365)
}


def calculate_price(action: Action) -> bool:
    if not action.resource or not action.operator or not action.begin or not action.end:
        return False
    if action.pricegroup.detailed_calculation:
        action.value_gross = calculate_detailed_price(action.pricegroup, action.begin, action.end)
    else:
        action.value_gross = getattr(action.pricegroup, 'fee_%s' % Pricegroup.get_timespan(action.begin, action.end))
    if not action.value_gross:
        return False
    action.tax_rate = action.operator.tax_rate
    action.value_tax = action.value_gross / (1 + action.tax_rate) * action.tax_rate
    action.value_net = action.value_gross - action.value_tax
    return True


def calculate_begin_end(
        predefined_daterange: Union[UnsetValue, str],
        begin: Union[UnsetValue, datetime],
        end: Union[UnsetValue, datetime]) -> [Union[None, datetime], Union[None, datetime]]:
    if begin and end:
        return begin, end
    if not begin and end:
        return unlocalize_datetime(get_current_time_local().replace(microsecond=0)).replace(tzinfo=None), end

    if begin:
        begin_local = localize_datetime(begin).replace(tzinfo=None)
    else:
        begin_local = get_current_time_local().replace(microsecond=0)
        begin = unlocalize_datetime(begin_local).replace(tzinfo=None)
    end_local = (begin_local + predefined_daterange_def[predefined_daterange] + timedelta(days=1, hours=1))\
        .replace(hour=0, minute=0, second=0)
    end = unlocalize_datetime(end_local).replace(tzinfo=None)
    return begin, end


@celery.task
def check_reservation_timeout_delay(resource_id: int, action_id: int) -> None:
    resource = Resource.query.get(resource_id)
    action = Action.query.get(action_id)
    if not resource or not action:
        return
    check_reservation_timeout(resource, action)


def check_reservation_timeout(resource: Resource, action: Action):
    if action.status == ActionStatus.reserved:
        logger.info('action.status', 'set action %s status from %s to %s' % (action.id, action.status, ActionStatus.timeouted))
        action.status = ActionStatus.timeouted
        db.session.add(action)
        db.session.commit()
    update_resource_status(resource=resource)
