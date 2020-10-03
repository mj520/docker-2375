# docker-2375
open docker 2375 port
## useage
```
docker run -d --restart=always --name=docker-2375 -v /var/run/docker.sock:/var/run/docker.sock:rw \
    -p 2375:2375 mj520/docker-2375

docker run -d --restart=always --name=docker-auth -e PROXY_PASS=https://www.baidu.com -e PROXY_PORT=80 \
    -p 80:80 mj520/docker-2375:auth
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
-e CONSUL_HTTP_ADDR=http://domain \
-e CONSUL_KEYFILE=your_key:/start.sh \
-e CONSUL_OPT=put \
mj520/docker-2375:consul

#use consul-template
echo {{ key "key" }} > key.template
docker run --rm -v d:/data:/data hashicorp/consul-template:alpine \
-template "/key.template:/key"

docker run --rm -e consul kv get key > file