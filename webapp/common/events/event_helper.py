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

from typing import Dict, List, Type
from webapp.common.celery import CeleryHelper
from .delayed_events import trigger_delayed_event
from .enum import EventType, EventSource
from .event_receiver import EventReceiver


class EventHelper:
    celery_helper: CeleryHelper
    # events is a dict with service classes. The service entrypoint has to be a method called run.
    events: Dict[EventType, List[EventReceiver]]

    def __init__(self, celery_helper: CeleryHelper):
        self.celery_helper = celery_helper
        self.events = {}

    def trigger(self, event_type: EventType, event_source: EventSource, **kwargs):
        """
        this function is for triggering events. If the event recipient is async, it gives the event with its position in our event list
        to celery, then it will be triggered in our celery worker by trigger_async() below.
        """
        if not event_type in self.events.keys():
            return
        for i in range(len(self.events[event_type])):
            # check for event source
            if self.events[event_type][i].listen_to_event_source is not None \
                    and self.events[event_type][i].listen_to_event_source != event_source:
                continue
            # run in-sync events directly
            if not self.events[event_type][i].run_async:
                self.events[event_type][i].run(event_source=event_source, **kwargs)
                continue
            # push async events in celery queue which will trigger trigger_async() afterwards
            self.celery_helper.with_delay(
                task=trigger_delayed_event,
                delay_seconds=0 if self.events[event_type][i].delay_seconds is None else self.events[event_type][i].delay_seconds,
                event_type_str=event_type.name,
                event_source_str=event_source.name,
                event_id=i,
                **kwargs
            )

    def trigger_async(self, event_type: EventType, event_source: EventSource, event_id: int, **kwargs):
        self.events[event_type][event_id].run(event_source=event_source, **kwargs)

    def register(self, event_receiver_classes: List[Type[EventReceiver]]):
        for event_receiver_class in event_receiver_classes:
            event_receiver = event_receiver_class()
            listen_to_event_types = event_receiver.listen_to_event_type \
                if type(event_receiver.listen_to_event_type) is list \
                else [event_receiver.listen_to_event_type]
            for listen_to_event_type in listen_to_event_types:
                if event_receiver.listen_to_event_type not in self.events.keys():
                    self.events[listen_to_event_type] = []
                self.events[listen_to_event_type].append(event_receiver)
