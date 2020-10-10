#!/bin/sh
if [ "$PLUGIN_TOKEN" = "" ];then
    echo "PLUGIN_TOKEN is empty"
    exit 1
fi
if [ "$PLUGIN_API" = "" ];then
    echo "PLUGIN_API is empty"
    exit 1
fi
curl -k -X POST -s -H "Content-Type: application/json" \
-H 'Authorization: Bearer '$PLUGIN_TOKEN \
$PLUGIN_API'?action=redeploy'