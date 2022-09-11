# This script is used by `routers_unicast.sh`
set -eux

LOCAL_IP=$LOCAL_IP
REMOTE_IP=$REMOTE_IP

HOST=$(hostname)
ID=${HOST#router*-}

EGRESS_DEV=eth0
IGRESS_DEV=eth1

VXLAN_DEV=vxlan10
VNI=10

BRIDGE_DEV=br0

ip addr add $LOCAL_IP/24 dev $EGRESS_DEV

ip link add name $VXLAN_DEV type vxlan id $VNI local $LOCAL_IP remote $REMOTE_IP dstport 4789 dev $EGRESS_DEV
ip link set up dev $VXLAN_DEV

ip link add name $BRIDGE_DEV type bridge

ip link set dev $VXLAN_DEV master $BRIDGE_DEV
ip link set dev $IGRESS_DEV master $BRIDGE_DEV

ip link set up dev $BRIDGE_DEV

ip link show master $BRIDGE_DEV
ip -d link show $BRIDGE_DEV
ip -d link show $VXLAN_DEV
