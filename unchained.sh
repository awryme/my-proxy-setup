#!/bin/bash
set -e

docker pull ghcr.io/awryme/unchained:latest

servername=$1

tags=""
if [ -n "${servername}" ]; then
    tags="--tags $servername"
fi

id=$(cat /dev/urandom | head | md5sum | cut -c1-8)

id=$( docker run -d --restart always --network host \
    --name unchained-$id ghcr.io/awryme/unchained:latest \
    run $tags --id $id )

sleep 3
docker logs $id