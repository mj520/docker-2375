#!/bin/sh
dockerd-entrypoint.sh  --registry-mirror="https://r1w81y9g.mirror.aliyuncs.com" &
#默认env无法本地连接
DOCKER_HOST=""
#等待启动
sleep 3
#大于号分隔原和目标 逗号空格换行分隔多个
imageList=${IMAGES//,/ }
docker login $REGISTRY -u $USERNAME -p $PASSWORD
for image in $imageList;
do
    source=${image%>*}
    target=${image#*>}
    docker pull $source
    docker tag $source $REGISTRY/$target
    docker push $REGISTRY/$target
    if [ $? -eq 0 ];then
        echo "$source > $target ok"
    else
        echo "$source > $target fail"
    fi
    docker rmi $source
    docker rmi $REGISTRY/$target
done
echo "finish"