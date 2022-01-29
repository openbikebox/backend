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

from webapp.dependencies import dependencies
from webapp.extensions import celery
from .enum import EventSource, EventType


@celery.task
def trigger_delayed_event(event_type_str, event_source_str, event_id: int, **kwargs):
    dependencies.get_event_helper().trigger_async(
        event_type=EventType[event_type_str],
        event_source=EventSource[event_source_str],
        event_id=event_id,
        **kwargs
    )
