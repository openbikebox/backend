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

from abc import ABC
from webapp.common.logger import Logger
from webapp.common.config import ConfigHelper
from webapp.common.events import EventHelper
from webapp.dependencies import dependencies


class BaseService(ABC):
    logger: Logger
    config_helper: ConfigHelper
    event_helper: EventHelper

    def __init__(self, *, logger: Logger, config_helper: ConfigHelper, event_helper: EventHelper):
        self.logger = logger
        self.config_helper = config_helper
        self.event_helper = event_helper


def get_base_service_dependencies() -> dict:
    return {
        'logger': dependencies.get_logger(),
        'config_helper': dependencies.get_config_helper(),
        'event_helper': dependencies.get_event_helper(),
    }
