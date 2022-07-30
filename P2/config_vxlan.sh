# https://serverfault.com/questions/777179/configuring-vxlan-unicast-in-linux

set -eux

HOST=$(hostname)
ID=${HOST#router*-}
EGRESS_DEV=eth0
VXLAN_DEV=vxlan10
BRIDGE_DEV=br0
IGRESS_DEV=eth1
VNI=10

VXLAN_IP=10.0.0.$ID
LOCAL_IP=10.1.0.$ID

echo "Configuring host $HOST with ID $ID"
ip addr add $VXLAN_IP/24 dev $EGRESS_DEV
ip addr add $LOCAL_IP/24 dev $IGRESS_DEV

ip link add name $VXLAN_DEV type vxlan id $VNI dev $EGRESS_DEV local $VXLAN_IP dstport 4789

ip link set up $EGRESS_DEV
ip link set up $VXLAN_DEV
ip link set up $IGRESS_DEV

brctl addbr $BRIDGE_DEV
brctl addif $BRIDGE_DEV $VXLAN_DEV
brctl addif $BRIDGE_DEV $IGRESS_DEV

ip link set up $BRIDGE_DEV

set +eux
