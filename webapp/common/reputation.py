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

from hashlib import md5
from flask import request, current_app, abort
from webapp.extensions import redis, logger


def reputation_add(count: int) -> None:
    user_identifier = md5(request.headers.get('X-Forwarded-For', 'none').encode()).hexdigest()
    if user_identifier in current_app.config.get('TRUSTED_IPS', []):
        logger.info('reputation', 'reputation not increased because %s is a trustworthy IP' % request.remote_addr)
        return
    old_count = redis.hget('reputation', user_identifier)
    if not old_count:
        old_count = 0
    new_count = int(old_count) + count
    redis.hset('reputation', user_identifier, new_count)
    logger.info('reputation', 'added %s to %s (%s, %s)' % (
        count,
        user_identifier,
        request.headers.get('X-Forwarded-For', 'none'),
        request.headers.get('User-Agent', 'none')
    ))
    if new_count > current_app.config['REPUTATION_TRASHOLD']:
        logger.error('reputation', 'user %s banned' % user_identifier)
        if not current_app.config['DEBUG']:
            abort(429)


def reputation_heartbeat() -> None:
    for key, value in redis.hscan_iter('reputation'):
        new_value = int(value) - 300
        if new_value < 0:
            logger.info('reputation', 'delete reputation id %s' % key)
            redis.hdel('reputation', key)
        else:
            logger.info('reputation', 'set reputation id %s to %s' % (key, new_value))
            redis.hset('reputation', key, new_value)


def reputation_list() -> None:
    for key, value in redis.hscan_iter('reputation'):
        print('%s: %s' % (key.decode(), int(value)))


def get_reputation_list() -> dict:
    result = {}
    for key, value in redis.hscan_iter('reputation'):
        result[key.decode()] = int(value)
    return result

