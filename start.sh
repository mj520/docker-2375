#!/bin/sh
set -e
source /etc/profile

#启动docker
dockerd-entrypoint.sh  --registry-mirror="https://r1w81y9g.mirror.aliyuncs.com" &
#默认env无法本地连接
DOCKER_HOST=""

exec "$@"
