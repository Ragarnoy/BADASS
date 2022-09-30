# Configure a switch device.
# Provide the list of docker container id/name to the script.
# This script will bridge on `eth\d+` network interface together in a bridge named `br0`.
set -eux

source config_routers.sh

SWITCH=$(get_router 3)

SWITCH_ID=${SWITCH% *}

docker exec -i $SWITCH_ID bash < switch_net_config.sh
