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
from ..models import Resource
from ..common.enum import ResourceStatus
from ..extensions import db


def free_resource_worker():
    resources = Resource.query\
        .filter(Resource.status.in_([ResourceStatus.taken, ResourceStatus.reserved]))\
        .filter(Resource.unavailable_until < datetime.utcnow())\
        .all()
    for resource in resources:
        resource.status = ResourceStatus.free
        db.session.add(resource)
    db.session.commit()
