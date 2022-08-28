# This script is used by `routers_group.sh`
set -eux

LOCAL_IP=$LOCAL_IP
REMOTE_IP=$REMOTE_IP

HOST=$(hostname)
ID=${HOST#router*-}

EGRESS_DEV=eth0
IGRESS_DEV=eth1

VXLAN_DEV=vxlan10
VXLAN_GROUP=239.1.1.1
VNI=10

BRIDGE_DEV=br0

ip addr add $LOCAL_IP/24 dev $EGRESS_DEV

ip link add name $VXLAN_DEV type vxlan id $VNI group $VXLAN_GROUP dstport 4789 dev $EGRESS_DEV
ip link set up dev $VXLAN_DEV

ip link add name $BRIDGE_DEV type bridge

brctl addif $BRIDGE_DEV $VXLAN_DEV
brctl addif $BRIDGE_DEV $IGRESS_DEV

ip link set up dev $BRIDGE_DEV

brctl show $BRIDGE_DEV
ip -d link show $BRIDGE_DEV
ip -d link show $VXLAN_DEV
