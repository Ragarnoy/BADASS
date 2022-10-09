# What is `BGP with EVPN`

## What is `EVPN`

`EVPN` for `Ethernet VPN` is a technology for carrying layer 2 Ethernet traffic in a VPN using WAN[^wan] protocols.
`EVPN` technologies include Ethernet over `MPLS`[^mpls] and Ethernet over `VXLAN`[^vxlan].

[^wan]: Wide Area Network
[^mpls]: Multiprotocol Label Switching
[^vxlan]: Virtual Extensible Local Area Network

## What is `BGP`

`BGP` stand for `Border Gateway Protocol`, it's an *exterior gateway protocol* designed to exchange routing and reachability information on the Internet.

`BGP` is classified as a `path-vector routing protocol`. It makes routing decisions based on paths, network policies or rule-sets configured by a network admin.

## What is `BGP EVPN`

`BGP EVPN` is the combination of `BGP` and `EVPN`, thus the name.
It's a protocol that can be used with VXLAN.
With `BGP EVPN` our `VTEPs`[^vtep] will publish 2 type of routes:

1. Type 3 route for the local `VNI`.
2. Type 2 route for each MAC address in a `VNI`.

[^vtep]: Virtual Tunnel Endpoint
[^vni]: Virtual Network Identifier

## Sources

- [EVPN-VXLAN - juniper](https://www.juniper.net/fr/fr/research-topics/what-is-evpn-vxlan.html)
- [VXLAN: BGP EVPN avec FRR - vincent.bernat.ch](https://vincent.bernat.ch/fr/blog/2017-vxlan-bgp-evpn)
- [BGP - Wikipedia](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
- [EVPN - Wikipedia](https://en.wikipedia.org/wiki/Ethernet_VPN)
