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

from math import ceil
from uuid import uuid4
from datetime import datetime
from ..models import Resource, Location, Pricegroup, Hardware, ResourceGroup, ResourceAccess
from ..extensions import db
from ..common.enum import ResourceStatus


def fill_location(
        location_id: int,
        pricegroup_id: int,
        resource_group_id: int,
        resource_access_id: int,
        hardware_id: int,
        start_x: int = 0,
        start_y: int = 0,
        max_x: int = 5,
        max_y: int = 10,
        counter_length: int = 3,
        space_direction: str = 'x'):
    counter = Resource.query.filter_by(resource_group_id=resource_group_id).count() + 1
    location = Location.query.get(location_id)
    hardware = Hardware.query.get(hardware_id)
    pricegroup = Pricegroup.query.get(pricegroup_id)
    resource_group = ResourceGroup.query.get(resource_group_id)
    resource_access = ResourceAccess.query.get(resource_access_id)

    for i in range(start_x, start_x + max_x):
        for j in range(start_y, start_y + max_y):
            resource = Resource()
            resource.location_id = location.id
            resource.resource_access_id = resource_access.id
            resource.resource_group_id = resource_group.id
            resource.hardware_id = hardware.id
            resource.pricegroup_id = pricegroup.id
            resource.slug = str(uuid4())
            resource.status = ResourceStatus.free
            resource.installed_at = datetime.utcnow()
            resource.polygon_bottom = ceil(j * 1.5) if space_direction == 'y' else j
            resource.polygon_top = (ceil(j * 1.5) if space_direction == 'y' else j) + 1
            resource.polygon_left = ceil(i * 1.5) if space_direction == 'x' else i
            resource.polygon_right = (ceil(i * 1.5) if space_direction == 'x' else i) + 1
            resource.user_identifier = ("%0" + str(counter_length) + "d") % counter
            resource.internal_identifier = ("%0" + str(counter_length) + "d") % counter
            db.session.add(resource)
            db.session.commit()
            counter += 1
