set -eux

source utils.sh

# We need to get the router 4 because the leaf router start at 2,
# the first one is the spine router.
ROUTER_3=$(get_router 4)
ROUTER_3_ID=${ROUTER_3% *}

TMP_FILE=$(mktemp)
IP=10.1.1.10
ID=1.1.1.4
ROUTER_NAME=router-3

trap "rm $TMP_FILE" EXIT INT
sed -e "s/__ROUTER_IP__/$IP/;s/__LOOPBACK_ID__/$ID/;s/__ROUTER_NAME__/$ROUTER_NAME/" leaf_router.vtysh > $TMP_FILE
docker cp $TMP_FILE $ROUTER_3_ID:/leaf_router.vtysh

docker exec -i $ROUTER_3_ID bash < leaf_router_net.sh

echo "Correctly configured $ROUTER_NAME"
