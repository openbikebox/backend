# Installation

## Systemvoraussetzungen

Bei der Anwendung handelt es sich um eine Flask-basierte Webanwendung mit folgenden Voraussetzungen:
* Python 3.6+
* Virtual Environment
* SQLAlchemy-kompatibler SQL-Server (Tests aktuell: MariaDB, geplant: PostgreSQL)
* Eine AMQP-Queue (z.B. RabbitMQ)


## Produktiv-Version auf einem Server

// TODO


## Entwicklungs-Version via docker

1) `/webapp/config_dist_dev.py` zu `/webapp/config.py` umbenennen und anpassen
2) In `/Dockerfile.flask` und `Dockerfile.webpack` uuid und guid anpassen
3) Mit `docker-compose build` die Container bauen
4) Mit `docker-compose up` die Container starten
5) In einer anderen Shell sich via `docker exec -i -t open-bike-box-backend-flask /bin/bash` in den Flask-Docker-Kontext versetzen
6) Mit `python manage.py db upgrade` die Datenbank initialisieren
7) Mit `python manage.py prepare_unittest` Test-Daten in die Datenbank laden
