# Create a bridge device to bridge the interface connected to the host & vxlan interface
ip link add name br0 type bridge
ip link set up dev br0

# Create the vxlan interface with the id 10
ip link add name vxlan10 type vxlan10 id 10 dstport 4789
ip link set up dev vxlan10

# Bridge vxlan10 & eth1
brctl addif br0 vxlan10
brctl addif br0 eth1


# VTYSH configuration
#
# => $ vtysh
# => $ conf t

hostname router_1
no ipv6 forwarding
!
# Configure the interface on the spice router side
interface eth0
    ip address 10.0.0.2/30              # COMMENT TO REMOVE: 10.1.1.2/30
    ip ospf area 0
!
# Configure the loopback interface
interface lo
    ip address 1.1.1.1/32               # COMMENT TO REMOVE: 1.1.1.2/32
    ip ospf area 0
!
router bgp 1
    neighbor 1.1.1.42 remote-as 1       # COMMENT TO REMOVE: 1.1.1.1
    neighbor 1.1.1.42 update-source lo  # COMMENT TO REMOVE: 1.1.1.1
    !
    address-family l2vpn evpn
        neighbor 1.1.1.42 activate      # COMMENT TO REMOVE: 1.1.1.1
        advertise-all-vni
    exit-address-family
!
router ospf
!
