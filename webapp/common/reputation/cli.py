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

from flask import Blueprint
from .reputation import reputation_heartbeat, reputation_list

reputation_cli = Blueprint('reputation', __name__)


@reputation_cli.cli.command("heartbeat", help='heartbeat should run every 600 seconds')
def cli_reputation_heartbeat():
    reputation_heartbeat()


@reputation_cli.cli.command("list", help='lists all reputations')
def cli_reputation_list():
    reputation_list()
