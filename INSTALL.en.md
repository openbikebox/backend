# Installation

## Requirements

Our backend is a Flask-based web-application:
* Python 3.6+
* Virtual Environment
* SQLAlchemy-compatible SQL-server (tested: MariaDB, planned: PostgreSQL)
* An AMQP-Queue (eg RabbitMQ)


## Deploying a production version

// TODO


## Development-version via docker

1) Copy `/webapp/config_dist_dev.py` to `/webapp/config.py` and insert values
2) Fix `/Dockerfile.flask` und `Dockerfile.webpack` uuid and guid
3) Build container using `docker-compose build`
4) Start container using `docker-compose up`
5) Get in container context by using `docker exec -i -t open-bike-box-backend-flask /bin/bash` in another shell
6) Init database using `python manage.py db upgrade`
7) Deploy test data by using `python manage.py prepare_unittest`
