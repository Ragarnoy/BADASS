set -eux

source utils.sh

# We need to get the router 2 because the leaf router start at 2,
# the first one is used for the spine router
ROUTER_1=$(get_router 2)
ROUTER_1_ID=${ROUTER_1% *}

TMP_FILE=$(mktemp)
IP=10.1.1.2
ID=1.1.1.2
ROUTER_NAME=router-1

trap "rm $TMP_FILE" EXIT INT
sed -e "s/__ROUTER_IP__/$IP/;s/__LOOPBACK_ID__/$ID/;s/__ROUTER_NAME__/$ROUTER_NAME/" leaf_router.vtysh > $TMP_FILE
docker cp $TMP_FILE $ROUTER_1_ID:/leaf_router.vtysh

docker exec -i $ROUTER_1_ID bash < leaf_router_net.sh

echo "Correctly configured $ROUTER_NAME"
# # Create a bridge device to bridge the interface connected to the host & vxlan interface
# ip link add name br0 type bridge
# ip link set up dev br0

# # Create the vxlan interface with the id 10
# ip link add name vxlan10 type vxlan id 10 dstport 4789
# ip link set up dev vxlan10

# # Bridge vxlan10 & eth1
# brctl addif br0 vxlan10
# brctl addif br0 eth1


# # VTYSH configuration
# #
# # => $ vtysh
# # => $ conf t

# hostname router_1
# no ipv6 forwarding
# !
# # Configure the interface on the spice router side
# interface eth0
#     ip address 10.1.1.2/30
#     ip ospf area 0
# !
# # Configure the loopback interface
# interface lo
#     ip address 1.1.1.2/32
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
