# docker-2375
open docker 2375 port
## useage
```
docker run -d --restart=always --name=docker-2375 -v /var/run/docker.sock:/var/run/docker.sock:rw \
    -p 2375:2375 mj520/docker-2375

docker run -d --restart=always --name=docker-auth -e PROXY_PASS=https://www.baidu.com -e PROXY_PORT=80 \
    -p 80:80 mj520/docker-2375:auth
要PROXY_UPSTREAM=your.server:8500 生效 必须 配置PROXY_PASS=http://backup
```

## env for stream
```
PROXY_PORT 2375
PROXY_PASS unix:/var/run/docker.sock
```

## env for auth
```
PROXY_PORT 2375
PROXY_PASS http://unix:/var/run/docker.sock
# admin 123456
PROXY_USER "admin:T8PxFzD7p5DUc"
PROXY_AUTH /etc/nginx/conf.d/htpasswd #change PROXY_USER is invalid
```

## for consul key <> file
```
docker run -d --restart=always --name=docker-consul \
-e CONSUL_HTTP_ADDR=http://consul:8500 \
-e CONSUL_KEYFILE=key:/start.sh \
-e CONSUL_OPT=put \
-e HOOK_COMMAND="nsenter -m -u -i -n -p -t 1 host cmd"
mj520/docker-2375:consul
```