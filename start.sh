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
            if [ "$CONSUL_HTTP_TOKEN" != "" ];then
                curl -s -H "X-Consul-Token: ${CONSUL_HTTP_TOKEN}" -X PUT -d "${content}" "${CONSUL_HTTP_ADDR}/v1/kv/${key}"
            else
                curl -s -X PUT -d "${content}" "${CONSUL_HTTP_ADDR}/v1/kv/${key}"
            fi
        else
            if [ "$CONSUL_HTTP_TOKEN" != "" ];then
                curl -s -H "X-Consul-Token: ${CONSUL_HTTP_TOKEN}" -o "${file}" --create-dirs "${CONSUL_HTTP_ADDR}/v1/kv/${key}?raw=true"
            else
                curl -s -o "${file}" --create-dirs "${CONSUL_HTTP_ADDR}/v1/kv/${key}?raw=true"
            fi
        fi
    done
    if [ "$HOOK_COMMAND" != "" ];then
        $HOOK_COMMAND
    fi
    sleep $CONSUL_INTERVAL
done