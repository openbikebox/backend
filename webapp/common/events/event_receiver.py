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

from abc import ABC, abstractmethod
from typing import Optional, Union, List
from webapp.dependencies import dependencies
from .enum import EventSource, EventType


class EventReceiver(ABC):
    """
    This class is the entrypoint for a event. Usually it initializes a service class with all its dependencies and
    runs the desired method.
    """

    run_async: bool = False
    delay_seconds: Optional[int] = None
    listen_to_event_source: Optional[EventSource] = None

    @property
    @abstractmethod
    def listen_to_event_type(self) -> Union[EventType, List[EventType]]:
        pass

    def get_default_service_dependencies(self):
        return {
            'logger': dependencies.get_logger(),
            'config_helper': dependencies.get_config_helper(),
            'event_helper': dependencies.get_event_helper(),
        }

    @abstractmethod
    def run(self, event_source: EventSource, **kwargs):
        """
        remember to use **kwargs in all implementations because in future additional kwargs can be added
        """
