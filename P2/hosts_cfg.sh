set -eux

function get_hosts_containers() {
    HOST_IMG_NAME=host

    docker ps --format '{{ .ID }}' --filter "ancestor=${HOST_IMG_NAME}"
}

ID=1
for host in $(get_hosts_containers); do
    docker exec $host bash -c "ip addr add 42.42.42.$ID/24 dev eth0; ip link show eth0"
    ID=$(($ID + 1))
done
