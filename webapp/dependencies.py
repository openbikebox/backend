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

from functools import wraps
from typing import Callable, TYPE_CHECKING
from sqlalchemy.orm import Session
from webapp.common.config import ConfigHelper
from webapp.common.remote_helper import RemoteHelper
from webapp.common.celery import CeleryHelper
from webapp.repositories import (
    LocationRepository
)

if TYPE_CHECKING:
    from webapp.common.logger import Logger
    from webapp.common.events import EventHelper


def cache_dependency(fn: Callable):
    """
    Decorator for methods of the Dependencies class that caches their return value inside the _cached_dependencies dict.
    """
    # Get name of wrapped function minus the "get_" prefix
    name = fn.__name__
    name = name[4:] if name.startswith('get_') else name

    # TODO: proper type hinting
    @wraps(fn)
    def wrapper(*args):
        self = args[0]
        # Check if dependency is cached
        if name not in self._cached_dependencies:
            # Create dependency by calling the wrapped function and cache it
            self._cached_dependencies[name] = fn(self)

        # Return the dependency from cache
        return self._cached_dependencies[name]
    return wrapper


class Dependencies:
    """
    Container class for dependency injection.

    Dependencies will be created as needed and cached in a dictionary by the "get_" methods.
    """

    # Dictionary for caching the dependencies
    _cached_dependencies: dict

    def __init__(self):
        self._cached_dependencies = {}

    # Common
    @cache_dependency
    def get_logger(self) -> 'Logger':
        # Late import (don't initialize all the extensions unless needed)
        from webapp.extensions import logger
        return logger

    @cache_dependency
    def get_celery_helper(self) -> CeleryHelper:
        return CeleryHelper()

    @cache_dependency
    def get_config_helper(self) -> ConfigHelper:
        return ConfigHelper()

    @cache_dependency
    def get_remote_helper(self) -> RemoteHelper:
        return RemoteHelper(
            logger=self.get_logger(),
            config_helper=self.get_config_helper(),
        )

    @cache_dependency
    def get_event_helper(self) -> 'EventHelper':
        from webapp.common.events import EventHelper
        return EventHelper(
            celery_helper=self.get_celery_helper()
        )

    # Database
    @cache_dependency
    def get_db_session(self) -> Session:
        # Late import (don't initialize all the extensions unless needed)
        from webapp.extensions import db
        return db.session

    @cache_dependency
    def get_location_repository(self) -> LocationRepository:
        return LocationRepository(
            session=self.get_db_session()
        )


# Instantiate one global dependencies object so we don't need to clutter the environment with lots of globals
dependencies = Dependencies()
