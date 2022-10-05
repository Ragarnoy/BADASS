# What is MPLS

`MPLS` stand for `Multiprotocol Label Switching`.
It's a routing technique that directs data from one node to the next using labels instead of addresses.

The difference between a Network addresses and labels is that the addresses identify specific endpoints whereas labels identify paths between endpoints

> Something like:
>
>     Switch1-Router1-Host1
>
> Where the label identify the paths `Switch1 => Router1 => Host1`.

In a `MPLS` network, labels are assigned to data packets and those the packet-forwarding decisions are made only on that label without the need to inspect the packet itself.

`MPLS` operates between the OSI layer 2 (*data link layer*) and layer 3 (*network layer*).

## Sources

- [Multiprotocol Label Switching - Wikipedia](https://en.wikipedia.org/wiki/Multiprotocol_Label_Switching)
