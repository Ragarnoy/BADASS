set -eux

source config_routers.sh

ROUTER_1=$(get_router 1)
ROUTER_2=$(get_router 2)

if [ -z "$ROUTER_1" ] || [ -z "$ROUTER_2" ]; then
    echo "Cannot get 2 router to configure them"
    exit 2
fi

VXLAN_CONFIG=vxlan_unicast.sh

ROUTER_1_ID=${ROUTER_1% *}

configure_vxlan_router $ROUTER_1_ID 10.0.0.1 10.0.0.2

ROUTER_2_ID=${ROUTER_2% *}

configure_vxlan_router $ROUTER_2_ID 10.0.0.2 10.0.0.1
