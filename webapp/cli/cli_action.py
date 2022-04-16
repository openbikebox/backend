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
from typing import Optional, List
from datetime import date, timedelta
from flask.cli import AppGroup
from webapp.services.base_service import get_base_service_dependencies
from webapp.services.action.action_exporter_service import ActionExporterService
from webapp.dependencies import dependencies

action_cli = AppGroup('action')


@action_cli.command("export", help='Exports all actions to an xlsx and sends it as an email attachment.')
@click.option('-b', '--begin', 'begin', type=click.DateTime(formats=['%Y-%m-%d']), help='If unset, the last month will be exported.')
@click.option('-e', '--end', 'end', type=click.DateTime(formats=['%Y-%m-%d']), help='If unset, the last month will be exported.')
@click.option('-r', '--recipient', 'recipients', multiple=True, help='If unset, admin emails will be used.')
def cli_queue_status_checks(begin: Optional[date] = None, end: Optional[date] = None, recipients: Optional[List[str]] = None):
    if begin is None or end is None:
        begin = (date.today().replace(day=1) - timedelta(days=1)).replace(day=1)
        end = date.today().replace(day=1) - timedelta(days=1)
    action_exporter_service = ActionExporterService(
        **get_base_service_dependencies(),
        mail_helper=dependencies.get_mail_helper(),
        action_repository=dependencies.get_action_repository(),
    )
    file_name = action_exporter_service.export(
        begin=begin,
        end=end,
    )
    action_exporter_service.send_export(
        begin=begin,
        end=end,
        file_name=file_name,
        recipients=recipients or dependencies.get_config_helper().get('SUMMARY_RECIPIENTS'),
    )
