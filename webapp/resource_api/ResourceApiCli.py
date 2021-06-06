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

import click
from ..services.resource.ResourceStatusService import queue_status_checks
from ..services.resource.FillLocationService import fill_location
from .ResourceApiController import resource_api


@resource_api.cli.command("queue_status_checks", help='should run a short time after midnight')
def cli_queue_status_checks():
    queue_status_checks()


@resource_api.cli.command("create")
@click.argument('location_id', type=int)
@click.argument('pricegroup_id', type=int)
@click.argument('resource_group_id', type=int)
@click.argument('resource_access_id', type=int)
@click.argument('start_x', type=int)
@click.argument('start_y', type=int)
@click.argument('max_x', type=int)
@click.argument('max_y', type=int)
@click.argument('counter_length', type=int)
@click.argument('space_direction', type=click.Choice(['x', 'y']))
def cli_fill_location(
        location_id,
        pricegroup_id,
        resource_group_id,
        resource_access_id,
        hardware_id,
        start_x,
        start_y,
        max_x,
        max_y,
        counter_length,
        space_direction):
    fill_location(
        location_id,
        pricegroup_id,
        resource_group_id,
        resource_access_id,
        hardware_id,
        start_x,
        start_y,
        max_x,
        max_y,
        counter_length,
        space_direction
    )

