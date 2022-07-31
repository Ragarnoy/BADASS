set -eux

ROUTER_IMG_NAME=router

function get_router_containers() {
    docker ps --format '{{ .ID }}' --filter "ancestor=${ROUTER_IMG_NAME}" | xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
}

function configure_vxlan_router() {
    local container_id=$1
    local local_ip=$2
    local remote_ip=$3

    docker exec -e LOCAL_IP=$local_ip -e REMOTE_IP=$remote_ip -i $container_id bash < vxlan_1.sh
}

ROUTERS="$(get_router_containers)"
ROUTER_1=$(grep -- -1 <<< $ROUTERS)
ROUTER_2=$(grep -- -2 <<< $ROUTERS)

if [ -z "$ROUTER_1" ] || [ -z "$ROUTER_2" ]; then
    echo "Cannot get 2 router to configure them"
    exit 2
fi

ROUTER_1_ID=${ROUTER_1% *}

configure_vxlan_router $ROUTER_1_ID 10.0.0.1 10.0.0.2

ROUTER_2_ID=${ROUTER_2% *}

configure_vxlan_router $ROUTER_2_ID 10.0.0.2 10.0.0.1
