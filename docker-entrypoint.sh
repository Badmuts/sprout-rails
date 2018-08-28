#!/bin/sh
set -e

[ -f /usr/src/app/tmp/pids/server.pid ] && rm /usr/src/app/tmp/pids/server.pid

exec bundle exec "$@"