# encoding: utf-8

"""
Copyright (c) 2012 - 2016, Ernesto Ruge
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"""

from flask_script import Manager
from flask import current_app
from webapp import launch
from webapp.extensions import db
import webapp.models as Models
from flask_migrate import Migrate, MigrateCommand
from webapp.common.prepare_unittest import prepare_unittest as prepare_unittest_run
from webapp.resource_backend.ResourceBackendWorker import fill_location as fill_location_run
from webapp.resource_backend.ResourceResetWorker import free_resource_worker as free_resource_worker_run


app = launch()

manager = Manager(app)
migrate = Migrate(app, db)

manager.add_command('db', MigrateCommand)


@manager.shell
def make_shell_context():
    return dict(app=current_app, db=db, models=Models)


@manager.command
def prepare_unittest():
    prepare_unittest_run()


@manager.command
def free_resource_worker():
    """
    should run a short time after midnight
    """
    free_resource_worker_run()


@manager.command
def fill_location(location_id, pricegroup_id, resource_group_id, resource_access_id, hardware_id, x, y, counter_length):
    fill_location_run(
        int(location_id),
        int(pricegroup_id),
        int(resource_group_id),
        int(resource_access_id),
        int(hardware_id),
        int(x),
        int(y),
        int(counter_length)
    )


if __name__ == "__main__":
    manager.run()
