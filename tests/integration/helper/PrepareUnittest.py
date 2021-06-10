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
from webapp.app import launch
from webapp.models import User, Operator, Hardware, Location, File, Pricegroup, Resource, ResourceAccess, ResourceGroup, \
    RegularHours
from webapp.extensions import db
from webapp.enum import ResourceStatus, ResourceGroupStatus, LocationType


def prepare_unittest():
    launch().app_context().push()

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
    user.email = 'test@binary-butterfly.de'
    user.password = 'unittest'
    user.first_name = 'Test'
    user.last_name = 'User'
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

    operator_bike = Operator()
    operator_bike.future_booking = False
    operator_bike.name = 'Open Bike GmbH'
    operator_bike.address = 'Fahrradstraße 1'
    operator_bike.postalcode = '12345'
    operator_bike.locality = 'Fahrradstadt'
    operator_bike.country = 'de'
    operator_bike.tax_rate = Decimal('0.19')
    operator_bike.logo_id = operator_logo.id
    operator_bike.slug = 'open-bike-gmbh'
    operator_bike.email = 'test@open-bike.gmbh'
    operator_bike.url = 'https://openbikebox.de'
    db.session.add(operator_bike)
    db.session.commit()

    operator_cargo = Operator()
    operator_cargo.future_booking = True
    operator_cargo.name = 'Open Cargo GmbH'
    operator_cargo.address = 'Fahrradstraße 1'
    operator_cargo.postalcode = '12345'
    operator_cargo.locality = 'Fahrradstadt'
    operator_cargo.country = 'de'
    operator_cargo.tax_rate = Decimal('0.19')
    operator_cargo.logo_id = operator_logo.id
    operator_cargo.slug = 'open-cargo-gmbh'
    operator_cargo.email = 'test@open-cargo.gmbh'
    operator_cargo.url = 'https://opencargobike.de'
    db.session.add(operator_cargo)
    db.session.commit()

    hardware_small = Hardware()
    hardware_small.name = 'Einzel-Box'
    hardware_small.future_booking = False
    db.session.add(hardware_small)
    hardware_big = Hardware()
    hardware_big.name = 'Sammel-Anlagen-Stellplatz'
    hardware_big.future_booking = False
    db.session.add(hardware_big)
    hardware_cargo = Hardware()
    hardware_cargo.name = 'Cargo-Bike'
    hardware_cargo.future_booking = True
    db.session.add(hardware_cargo)
    db.session.commit()
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
    location_small.type = LocationType.bikebox
    location_small.name = 'Fahrrad-Station Teststadt 1'
    location_small.description = 'This is a wonderful description for Fahrrad-Station Teststadt 1'
    location_small.slug = 'fahrrad-station-teststadt'
    location_small.address = 'Königswall 15'
    location_small.postalcode = '44137'
    location_small.locality = 'Dortmund'
    location_small.country = 'de'
    location_small.twentyfourseven = True
    location_small.booking_base_url = 'https://openbikebox.de'
    location_small.lat = 51.517477
    location_small.lon = 7.460547
    location_small.operator_id = operator_bike.id
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
    location_small.type = LocationType.bikebox
    location_big.name = 'Fahrrad-Station Demostadt'
    location_big.description = 'This is a wonderful description for Fahrrad-Station Demostadt'
    location_big.slug = 'fahrrad-station-demo'
    location_big.address = 'Kurt-Schumacher-Platz 1'
    location_big.postalcode = '44787'
    location_big.locality = 'Bochum'
    location_big.country = 'de'
    location_big.twentyfourseven = True
    location_big.booking_base_url = 'https://openbikebox.de'
    location_big.lat = 51.479158
    location_big.lon = 7.222904
    location_big.operator_id = operator_bike.id
    location_big.photo_id = location_photo_big.id
    db.session.add(location_big)
    db.session.commit()

    location_cargo_file = File()
    location_cargo_file.mimetype = 'image/jpeg'
    copy2(
        os.path.join(current_app.config['TESTS_DIR'], 'files', 'location-2.jpg'),
        os.path.join(current_app.config['FILES_DIR'], '4.jpg')
    )
    db.session.add(location_cargo_file)
    db.session.commit()

    location_cargo = Location()
    location_cargo.name = 'Cargo-Bike-Station'
    location_big.description = 'This is a wonderful description for Cargo-Bike-Station'
    location_cargo.slug = 'cargo-bike-station'
    location_cargo.address = 'Bahnhofstraße 12'
    location_cargo.postalcode = '71083'
    location_cargo.locality = 'Herrenberg'
    location_cargo.booking_base_url = 'https://opencargobike.de'
    location_cargo.twentyfourseven = False
    location_cargo.country = 'de'
    location_cargo.lat = 48.593811
    location_cargo.lon = 8.863288
    location_cargo.operator_id = operator_cargo.id
    location_cargo.photo_id = location_cargo_file.id
    db.session.add(location_cargo)
    db.session.commit()

    regular_hours = RegularHours()
    regular_hours.weekday = 2
    regular_hours.period_begin = 36000
    regular_hours.period_end = 68400
    db.session.add(regular_hours)

    regular_hours = RegularHours()
    regular_hours.weekday = 3
    regular_hours.period_begin = 54000
    regular_hours.period_end = 68400
    db.session.add(regular_hours)

    regular_hours = RegularHours()
    regular_hours.weekday = 4
    regular_hours.period_begin = 54000
    regular_hours.period_end = 68400
    db.session.add(regular_hours)

    regular_hours = RegularHours()
    regular_hours.weekday = 5
    regular_hours.period_begin = 36000
    regular_hours.period_end = 68400
    db.session.add(regular_hours)

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
    resource_group_small.name = 'Fahrrad-Station Teststadt'
    resource_group_small.slug = 'fahrrad-station-teststadt'
    resource_group_small.internal_identifier = 'teststadt-1'
    resource_group_small.user_identifier = 'teststadt-1'
    resource_group_small.max_bookingdate = 365
    resource_group_small.installed_at = datetime.utcnow()
    resource_group_small.status = ResourceGroupStatus.active
    db.session.add(resource_group_small)
    db.session.commit()

    resource_group_big = ResourceGroup()
    location_small.type = LocationType.cargobike
    resource_group_big.name = 'Fahrrad-Station Demostadt'
    resource_group_big.slug = 'fahrrad-station-demostadt'
    resource_group_big.internal_identifier = 'demostadt-1'
    resource_group_big.user_identifier = 'demostadt-1'
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

    resource_cargo_photo_main = File()
    resource_cargo_photo_main.mimetype = 'image/jpeg'
    copy2(
        os.path.join(current_app.config['TESTS_DIR'], 'files', 'cargobike-1.jpg'),
        os.path.join(current_app.config['FILES_DIR'], '5.jpg')
    )
    db.session.add(resource_cargo_photo_main)
    db.session.commit()

    resource_cargo_photos = []
    for i in range(3):
        resource_cargo_photo = File()
        resource_cargo_photo.mimetype = 'image/jpeg'
        copy2(
            os.path.join(current_app.config['TESTS_DIR'], 'files', 'cargobike-%s.jpg' % ((i % 2) + 1)),
            os.path.join(current_app.config['FILES_DIR'], '%s.jpg' % (6 + i))
        )
        db.session.add(resource_cargo_photo)
        db.session.commit()
        resource_cargo_photos.append(resource_cargo_photo)

    resource_cargo = Resource()
    resource_cargo.description = 'this is a wonderful cargobike'
    resource_cargo.hardware_id = hardware_cargo.id
    resource_cargo.pricegroup_id = pricegroup.id
    resource_cargo.slug = str(uuid4())
    resource_cargo.location_id = location_cargo.id
    resource_cargo.status = ResourceStatus.free
    resource_cargo.installed_at = datetime.utcnow()
    resource_cargo.user_identifier = 'cargobike-1'
    resource_cargo.internal_identifier = 'cargobike-1'
    resource_cargo.photo_id = resource_cargo_photo_main.id
    resource_cargo.photos = resource_cargo_photos
    db.session.add(resource_cargo)
    db.session.commit()


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
TRUNCATE `regular_hours`;
TRUNCATE `alert`;
SET FOREIGN_KEY_CHECKS=1;
'''

prepare_unittest()
