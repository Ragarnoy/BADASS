# Configure a switch device.
# Provide the list of docker container id/name to the script.
# This script will bridge on `eth\d+` network interface together in a bridge named `br0`.
set -eux

for host in $*; do
    docker exec -i $host bash < switch_net_config.sh
done
