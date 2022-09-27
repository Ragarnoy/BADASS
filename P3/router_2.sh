set -eux

source utils.sh

# We need to get the router 3 because the leaf router start at 2,
# the first one is the spine router.
ROUTER_2=$(get_router 3)
ROUTER_ID=${ROUTER_2% *}

TMP_FILE=$(mktemp)
IP=10.1.1.6
ID=1.1.1.3
ROUTER_NAME=router-2

trap "rm $TMP_FILE" EXIT INT

sed -e "s/__ROUTER_IP__/$IP/;s/__LOOPBACK_ID__/$ID/;s/__ROUTER_NAME__/$ROUTER_NAME/" leaf_router.vtysh > $TMP_FILE
docker cp $TMP_FILE $ROUTER_ID:/leaf_router.vtysh

docker exec -i $ROUTER_ID bash < leaf_router_net.sh

echo "Correctly configured $ROUTER_NAME"
# ip link add name br0 type bridge
# ip link set up dev br0

# ip link add name vxlan10 type vxlan id 10 dstport 4789
# ip link set up dev vxlan10

# brctl addif br0 vxlan10
# brctl addif br0 eth1

# # VTYSH Configuration

# hostname router_2
# no ipv6 forwarding
# !

# interface eth0
#     ip address 10.1.1.6/30
#     ip ospf area 0
# !

# interface lo
#     ip address 1.1.1.3/32
#     ip ospf area 0
# !

# router bgp 1
#     neighbor 1.1.1.1 remote-as 1
#     neighbor 1.1.1.1 update-source lo
#     !
#     address-family l2vpn evpn
#         neighbor 1.1.1.1 activate
#         advertise-all-vni
#     exit-address-family
# !

# router ospf
# !
