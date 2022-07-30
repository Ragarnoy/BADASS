#!/bin/sh

# List router container id and their mac address for a specific device

ROUTER_IMG_NAME=router
DEVICE=eth0

function get_macs() {
    for container_id in $@; do
        MAC=$(docker exec $container_id ip link show $DEVICE | grep ether | cut -f 6 -d ' ')
        echo "{ \"$container_id\": \"$MAC\" }"
    done
}

function get_router_containers() {
    docker ps --format '{{ .ID }} {{ .Image }} {{ .Names }}' --filter "ancestor=${ROUTER_IMG_NAME}"
}

ROUTER_CONTAINERS=$(get_router_containers | cut -f 1 -d ' ')
get_macs $ROUTER_CONTAINERS | jq -s '.'
