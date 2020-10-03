#!/bin/sh
if [ "$CONSUL_KEYFILE" = "" ];then
    echo "CONSUL_KEYFILE is empty"
    exit 1
fi
while true;do
    kf_array=${CONSUL_KEYFILE//,/ }
    for kfa in $kf_array;do
        key=${kfa%:*}
        file=${kfa#*:}
        perfix=${key:0:1}
        if [ "$perfix" = "/" ];then
            key=${key:1}
        fi
        if [ "$CONSUL_OPT" = "put" ];then
            content=`cat ${file}`
            consul kv put ${key} "${content}"
        else
            consul kv get ${key} > ${file}
        fi
    done
    sleep $CONSUL_INTERVAL
done