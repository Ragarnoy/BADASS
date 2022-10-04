# What is BUM

`BUM` also know as `BUM traffic` is an acrynom for **Broadcast, Unknown-unicast, Multicast traffic**.
`BUM traffic` is any network traffic transmitted using one of the three methods listed above to an destination where its address is **Unknown**.

## What is the differences between each method

### In Broadcast mode

In *Broadcast* mode, the message is transmitted to any reachable destination without the need to know any information about the destination.

### In Unknown-unicast mode

*Unknown-unicast* happens when a Switch receives *unicast* traffic to a destination that is not in its *forwarding information base*.
In that case the switch mark the *frame* as *flooding* and sends it to all ports within the `VLAN`.

### In Multicast mode

In *Multicast* mode, the message is transmitted to subset of hosts or devices joined into a group.

## BUM and VXLAN

`BUM` traffic can be encapsulated in `VXLAN`.

In *Data Plane Learning* the broadcast traffic is send to `VNI`[^vni] group members of the `VXLAN` using the multicast method.

In *Control Plane Learning* address are collected with `BGP`[^bgp].
In that mode, the broadcast traffic is reduced and `VTEPs`[^vteps] reply directly to the caller.

In *Multicast* mode (i.e. *Data Plana Learning*), each `VNI` is mapped to a single multicast group but a multicast group could be mapped to multiple `VNI`.
When a `VTEP` comes alive it use the protocol `IGMP`[^igmp] to join the multicast groups for the `VNIs` it uses.
When a `VTEP` has to send a `BUM` traffic, it just have to send to the relevant multicast group.

In *Head End Replication* mode (i.e. *Control Plane Learning*) (only available with `BGP` & `EVPN`[^evpn]),
when `BUM` traffic arrive, the `VTEP` creates several unicast packets and sends one to each `VTEP` that supports the `VNI`.

> This method is less efficent as the host need to send `n-1` (`-1` because the hosts doesn't count) unicast packets for `n` `VTEP` in the same `VNI`.

[^vni]: Virtual Network Identifier
[^vteps]: `VXLAN` tunnel endpoints
[^igmp]: Internet Group Management Protocol

## BUM and EVPN[^evpn]

In a `VXLAN-EVPN`, MAC addresses are learned via the *control plane* instead of the *data plane*.
In `EVPN`, the `VTEP` will only accept `BUM` traffic that is learnt via the *control plane*.

[^bgp]: Board Gateway Protocol
[^evpn]: Ethernet VPN

## Sources

- [Boardcst, Unknown-unicast and multicast traffic - Wikipedia](https://en.wikipedia.org/wiki/Broadcast,_unknown-unicast_and_multicast_traffic)
