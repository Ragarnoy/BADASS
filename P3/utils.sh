function get_router_containers() {
    ROUTER_IMG_NAME=router

    docker ps --format '{{ .ID }}' --filter "ancestor=${ROUTER_IMG_NAME}" | xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
}

function get_router() {
    local ID=$1
    get_router_containers | grep -- -$ID
}
