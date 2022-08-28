ip link add name br0 type bridge
ip link set up dev br0

ip link add name vlxan10 type vxlan id 10 dstport 4789
ip link set up vxlan10

brctl addif br0 vxlan10
brctl addif eth0

# VTYSH Configuration

hostname router_2
no ipv6 forwarding
!

interface eth0
    ipaddress 10.0.0.6/30
    ip ospf area 0
!

interace lo
    ip address 1.1.1.2/32
    ip ospf area 0
!

router bgp 1
    neighbor 1.1.1.42 remote-as 1
    neighbor 1.1.1.42 update-source lo
    !
    address-family l2vpn evpn
        neighbor 1.1.1.42 activate
        advertise-all-vni
    exit-address-family
!

router ospf
!
