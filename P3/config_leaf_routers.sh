set -eu

source utils.sh

TMP_FILE=$(mktemp)
trap "rm $TMP_FILE" EXIT INT

IP_LIST=(
    10.1.1.2
    10.1.1.6
    10.1.1.10
)
ID_LIST=(
    1.1.1.2
    1.1.1.3
    1.1.1.4
)
for i in {0..2}; do
    # We need to add `+ 1` because the leaf router start at id 2 as the first one is the spine router.
    ROUTER=$(get_router $((i + 2)))
    ROUTER_ID=${ROUTER% *}
    IP=${IP_LIST[$i]}
    ID=${ID_LIST[$i]}
    ROUTER_NAME=router-$((i + 1))

    echo "Configuring router $ROUTER_NAME with id:$ID and ip:$IP at $ROUTER_ID"

    sed -e "s/__ROUTER_IP__/$IP/;s/__LOOPBACK_ID__/$ID/;s/__ROUTER_NAME__/$ROUTER_NAME/" leaf_router.vtysh > $TMP_FILE

    docker cp $TMP_FILE $ROUTER_ID:/leaf_router.vtysh

    docker exec -i $ROUTER_ID bash < leaf_router_net.sh

    echo "Correctly configured $ROUTER_NAME"
done
