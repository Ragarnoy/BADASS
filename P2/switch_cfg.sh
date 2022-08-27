# Configure a switch device.
# Provide the list of docker container id/name to the script.
# This script will bridge on `eth\d+` network interface together in a bridge named `br0`.
set -eux

for host in $*; do
    docker exec $host bash -c "set -eux; ip link add name br0 type bridge && for eth in \$(ip link show | grep 'eth\d\d*' | sed 's/\d*: eth\(\d*\).*/eth\1/'); do brctl addif br0 \$eth; done && ip link set up br0 && brctl show br0"
done
