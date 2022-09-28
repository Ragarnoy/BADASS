set -e

ip link add name br0 type bridge
ip link set up dev br0

ip link add name vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 master br0
ip link set up dev vxlan10

ip link set dev eth1 master br0

cat /leaf_router.vtysh

vtysh --inputfile /leaf_router.vtysh
