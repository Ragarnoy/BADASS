set -eux

source utils.sh

# The router 1 is the spine router
ROUTER_1=$(get_router 1)
ROUTER_ID=${ROUTER_1% *}

docker cp snapping_router.vtysh $ROUTER_ID:/spine_router.vtysh

docker exec -i $ROUTER_ID bash -c "vtysh --inputfile /spine_router.vtysh"

echo "Correctly configured the spine router"
