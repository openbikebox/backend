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
from sqlalchemy.orm import Session
from flask import current_app, Config
from webapp.extensions import db


class UnsetValue:
    pass


unset_value = UnsetValue()


class BaseRepository:
    session: Session
    config: Config

    def __init__(self, session: Optional[Session] = None, config: Optional[Config] = None) -> None:
        self.session = db.session if session is None else session
        self.config = current_app.config if config is None else config
