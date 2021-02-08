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

import os
import pymysql
from math import ceil
from uuid import uuid4
from shutil import copy2
from decimal import Decimal
from datetime import datetime
from urllib.parse import urlparse

from flask import current_app
from ..models import User, Operator, Hardware, Location, File, Pricegroup, Resource, ResourceAccess, ResourceGroup
from ..extensions import db
from ..common.enum import ResourceStatus, ResourceGroupStatus


def prepare_unittest():
    if current_app.config['MODE'] != 'DEVELOPMENT' or not current_app.config['DEBUG']:
        print('wrong mode')
        return

    url = urlparse(current_app.config['SQLALCHEMY_DATABASE_URI'])
    connection = pymysql.connect(
        host=url.hostname,
        user=url.username,
        password=url.password,
        db=url.path[1:],
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    with connection.cursor() as cursor:
        for line in truncate_dbs.split("\n"):
            if not line:
                continue
            cursor.execute(line)
    connection.commit()

    user = User()
    user.email = 'mail@ernestoruge.de'
    user.password = 'unittest'
    user.first_name = 'Ernesto'
    user.last_name = 'Ruge'
    user.company = 'binary butterfly GmbH'
    user.address = 'Am Hertinger Tor'
    user.postalcode = '59423'
    user.locality = 'Unna'
    user.country = 'DE'
    user.status = 'active'
    user.capabilities = ['admin']
    db.session.add(user)
    db.session.commit()

    operator_logo = File()
    operator_logo.mimetype = 'image/svg+xml'
    operator_logo.name = 'Logo'
    copy2(
        os.path.join(current_app.config['TESTS_DIR'], 'files', 'operator-logo.svg'),
        os.path.join(current_app.config['FILES_DIR'], '1.svg')
    )
    db.session.add(operator_logo)
    db.session.commit()

    operator = Operator()
    operator.name = 'Open Bike GmbH'
    operator.address = 'Fahrradstraße 1'
    operator.postalcode = '12345'
    operator.locality = 'Fahrradstadt'
    operator.country = 'de'
    operator.tax_rate = Decimal('0.16')
    operator.logo_id = operator_logo.id
    db.session.add(operator)
    db.session.commit()

    hardware_small = Hardware()
    hardware_small.name = 'Einzel-Box'
    db.session.add(hardware_small)
    hardware_big = Hardware()
    hardware_big.name = 'Sammel-Anlagen-Stellplatz'
    db.session.add(hardware_big)
    db.session.commit()

    location_photo_small = File()
    location_photo_small.mimetype = 'image/jpeg'
    copy2(
        os.path.join(current_app.config['TESTS_DIR'], 'files', 'location-1.jpg'),
        os.path.join(current_app.config['FILES_DIR'], '2.jpg')
    )
    db.session.add(location_photo_small)
    db.session.commit()

    location_small = Location()
    location_small.name = 'Fahrrad-Station Dortmund'
    location_small.slug = 'fahrrad-station-dortmund'
    location_small.address = 'Königswall 15'
    location_small.postalcode = '44137'
    location_small.locality = 'Dortmund'
    location_small.country = 'de'
    location_small.lat = 51.517477
    location_small.lon = 7.460547
    location_small.operator_id = operator.id
    location_small.photo_id = location_photo_small.id
    db.session.add(location_small)
    db.session.commit()

    location_photo_big = File()
    location_photo_big.mimetype = 'image/jpeg'
    copy2(
        os.path.join(current_app.config['TESTS_DIR'], 'files', 'location-2.jpg'),
        os.path.join(current_app.config['FILES_DIR'], '3.jpg')
    )
    db.session.add(location_photo_big)
    db.session.commit()

    location_big = Location()
    location_big.name = 'Fahrrad-Station Bochum'
    location_big.slug = 'fahrrad-station-bochum'
    location_big.address = 'Kurt-Schumacher-Platz 1'
    location_big.postalcode = '44787'
    location_big.locality = 'Bochum'
    location_big.country = 'de'
    location_big.lat = 51.479158
    location_big.lon = 7.222904
    location_big.operator_id = operator.id
    location_big.photo_id = location_photo_big.id
    db.session.add(location_big)
    db.session.commit()

    pricegroup = Pricegroup()
    pricegroup.fee_hour = '0.20'
    pricegroup.fee_day = '1.0'
    pricegroup.fee_week = '5.0'
    pricegroup.fee_month = '15.0'
    pricegroup.fee_year = '100.0'
    db.session.add(pricegroup)
    db.session.commit()

    resource_access_small = ResourceAccess()
    resource_access_small.internal_identifier = '001'
    resource_access_small.salt = '123456'
    db.session.add(resource_access_small)

    resource_access_big = ResourceAccess()
    resource_access_big.internal_identifier = '002'
    resource_access_big.salt = '654321'
    db.session.add(resource_access_big)

    resource_group_small = ResourceGroup()
    resource_group_small.name = 'Fahrrad-Station Dortmund'
    resource_group_small.slug = 'fahrrad-station-dortmund'
    resource_group_small.internal_identifier = 'dortmund-1'
    resource_group_small.user_identifier = 'dortmund-1'
    resource_group_small.max_bookingdate = 365
    resource_group_small.installed_at = datetime.utcnow()
    resource_group_small.status = ResourceGroupStatus.active
    db.session.add(resource_group_small)
    db.session.commit()

    resource_group_big = ResourceGroup()
    resource_group_big.name = 'Fahrrad-Station Bochum'
    resource_group_big.slug = 'fahrrad-station-bochum'
    resource_group_big.internal_identifier = 'bochum-1'
    resource_group_big.user_identifier = 'bochum-1'
    resource_group_big.max_bookingdate = 365
    resource_group_big.installed_at = datetime.utcnow()
    resource_group_big.status = ResourceGroupStatus.active
    db.session.add(resource_group_big)
    db.session.commit()

    counter = 1
    for i in range(0, 5):
        for j in range(0, 2):
            resource = Resource()
            resource.location_id = location_small.id
            resource.resource_access_id = resource_access_small.id
            resource.resource_group_id = resource_group_small.id
            resource.hardware_id = hardware_small.id
            resource.pricegroup_id = pricegroup.id
            resource.slug = str(uuid4())
            resource.status = ResourceStatus.free
            resource.installed_at = datetime.utcnow()
            resource.polygon_bottom = 2 * j
            resource.polygon_top = 2 * j + 1
            resource.polygon_left = i
            resource.polygon_right = i + 1
            resource.user_identifier = "%02d" % counter
            resource.internal_identifier = "%02d" % counter
            db.session.add(resource)
            db.session.commit()
            counter += 1

    counter = 1
    for i in range(0, 6):
        for j in range(0, 10):
            resource = Resource()
            resource.location_id = location_big.id
            resource.resource_access_id = resource_access_big.id
            resource.resource_group_id = resource_group_big.id
            resource.hardware_id = hardware_big.id
            resource.pricegroup_id = pricegroup.id
            resource.slug = str(uuid4())
            resource.status = ResourceStatus.free
            resource.installed_at = datetime.utcnow()
            resource.polygon_bottom = j
            resource.polygon_top = j + 1
            resource.polygon_left = ceil(i * 1.5)
            resource.polygon_right = ceil(i * 1.5) + 1
            resource.user_identifier = "%03d" % counter
            resource.internal_identifier = "%03d" % counter
            db.session.add(resource)
            db.session.commit()
            counter += 1


truncate_dbs = '''
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE `action`;
TRUNCATE `file`;
TRUNCATE `hardware`;
TRUNCATE `location`;
TRUNCATE `operator`;
TRUNCATE `option`;
TRUNCATE `pricegroup`;
TRUNCATE `resource`;
TRUNCATE `resource_access`;
TRUNCATE `resource_group`;
TRUNCATE `user`;
SET FOREIGN_KEY_CHECKS=1;
'''
