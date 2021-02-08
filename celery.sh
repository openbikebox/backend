#!/bin/bash

while true; do
  celery -A webapp.entry_point_celery worker &
  PID=$!
  inotifywait -e modify -e move -e create -e delete -e attrib -r ./webapp
  kill $PID
done
