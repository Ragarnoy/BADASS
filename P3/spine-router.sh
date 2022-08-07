# VTYSH Configuration
#
# ```bash
# $ vtysh
# $ conf t
# [paste the following content]
# ```

hostname spine_router
no ipv6 forwarding
!

interface eth0
    ip address 10.0.0.1/30
!

interface eth1
    ip address 10.0.0.5/30
!

interface eth2
    ip address 10.0.0.9/30
!

interface lo
    ip address 1.1.1.42/32
!

router bgp 1
    neighbor ibgp peer-group
    neighbor ibgp remote-as 1
    neighbor ibgp update-source lo
    bgp listen range 1.1.1.0/26 peer-group ibgp
    !

    address-family l2vpn evpn
      neighbor ibgp activate
      neighbor ibgp router-reflector-client
    exit-address-family
!

router ospf
    network 0.0.0.0/0 area 0
!

line vty
!
