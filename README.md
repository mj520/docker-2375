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

## for cups  lpd 打印队列设置为打印机名字 raw 建议设置默认打印机
```
docker run -d --restart=always --name cupsd-lpd \
-p 631:631 -p 515:515 -p 9100:9100 --privileged --user=0:0 \
-v /var/run/dbus:/var/run/dbus \
-v /dev/bus/usb:/dev/bus/usb \
registry.cn-hangzhou.aliyuncs.com/mj520/docker-2375:cupsd-lpd
```

## for metabase clickhouse 修改默认版本--build-arg TAG=v0.51.x --build-arg DRIVER_VERSION=1.51.0
```
docker build -f metabase/Dockerfile -t registry.cn-hangzhou.aliyuncs.com/mj520/docker2375:metabase .
docker push registry.cn-hangzhou.aliyuncs.com/mj520/docker2375:metabase

docker run -d --restart=always -p 3000:3000 --name metabase \
-v /data/metabase/metabase.db:/metabase.db \
registry.cn-hangzhou.aliyuncs.com/mj520/docker2375:metabase

注意 metabase.db是目录 plugins 不能直接替换 只能加文件、
手动插件clickhouse 1.51.0、其他插件一样的
latest=$(curl -s https://api.github.com/repos/ClickHouse/metabase-clickhouse-driver/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
curl -L -o /data/metabase/plugins/clickhouse.metabase-driver.jar "https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/${latest}/clickhouse.metabase-driver.jar" && \
chmod 744 /data/metabase/plugins/clickhouse.metabase-driver.jar
增加参数
-v /data/metabase/plugins/clickhouse.metabase-driver.jar:/plugins/clickhouse.metabase-driver.jar \
```