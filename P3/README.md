# Part 3 of BADASS

This part will require to build a network using evpn, bgp & vxlan.

## Configuration

Configure the spine router:

```bash
bash config_spine_router.sh
```

Configure the leaf router:

```bash
bash config_leaf_routers.sh
```

Configure the host:

```bash
bash config_hosts.sh
```

## Inspecting

```vtysh
do sh ip route
```

```vtysh
do sh bgp summary
```

```bash
do sh bgp l2vpn evpn
```

## Sources

- [EVPN with FRRouting](https://www.youtube.com/watch?v=Ek7kFDwUJBM)
