#!/bin/sh
set -e

source /etc/profile\
chown -R nginx:nginx /var/run/docker.sock

exec "$@"
