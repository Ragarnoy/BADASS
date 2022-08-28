function get_router_containers() {
    ROUTER_IMG_NAME=router

    docker ps --format '{{ .ID }}' --filter "ancestor=${ROUTER_IMG_NAME}" | xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
}

function configure_vxlan_router() {
    local container_id=$1
    local local_ip=$2
    local remote_ip=$3

    docker exec -e LOCAL_IP=$local_ip -e REMOTE_IP=$remote_ip -i $container_id bash < $VXLAN_CONFIG
}

function get_router() {
    local ID=$1
    get_router_containers | grep -- -$ID
}
