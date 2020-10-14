# registry image public > private
    大于号分隔原和目标 逗号空格换行分隔多个
## useage
```
docker run --rm \
-e REGISTRY=registry_url \
-e USERNAME=registry_username \
-e PASSWORD=registry_password \
-e IMAGES="mysql:latest>namespace/mysql:5.8 nginx,namespace/nginx" \
test

export REGISTRY=registry_url
export USERNAME=registry_username
export PASSWORD=registry_password
export IMAGES="mysql:latest>namespace/mysql:5.8
nginx,namespace/nginx"
./start.sh
```