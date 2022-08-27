# Part 2 of BADASS

- [Part 2 of BADASS](#part-2-of-badass)
  - [Configuration](#configuration)
    - [Configure the switch](#configure-the-switch)
    - [Configure the routers](#configure-the-routers)
      - [Configure the routers with UNICAST VXLAN](#configure-the-routers-with-unicast-vxlan)
      - [Configure the routers with GROUP VXLAN](#configure-the-routers-with-group-vxlan)
    - [Configure the hosts](#configure-the-hosts)
  - [Sources](#sources)

## Configuration

### Configure the switch

To configure the script, execute the script [`switch_cfg.sh`](switch_cfg.sh) with the container name/id of the switch

```bash
$ bash switch_cfg.sh b4db6a44a83e
+ for host in $*
+ docker exec b4db6a44a83e bash -c 'set -eux; ip link add name br0 type bridge && for eth in $(ip link show | grep '\''eth\d\d*'\'' | sed '\''s/\d*: eth\(\d*\).*/eth\1/'\''); do brctl addif br0 $eth; done && ip link set up br0 && brctl show br0'
+ ip link add name br0 type bridge
++ ip link show
++ grep 'eth\d\d*'
++ sed 's/\d*: eth\(\d*\).*/eth\1/'
+ for eth in $(ip link show | grep 'eth\d\d*' | sed 's/\d*: eth\(\d*\).*/eth\1/')
+ brctl addif br0 eth0
+ for eth in $(ip link show | grep 'eth\d\d*' | sed 's/\d*: eth\(\d*\).*/eth\1/')
+ brctl addif br0 eth1
+ ip link set up br0
+ brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.02f818a83962       no              eth0
                                                        eth1
```

This script will bridge every `eth*` interface together by using a bridge interface.

### Configure the routers

#### Configure the routers with UNICAST VXLAN

```bash
$ bash routers_unicast.sh
+ source config_routers.sh
++ get_router 1
++ local ID=1
++ get_router_containers
++ ROUTER_IMG_NAME=router
++ grep -- -1
++ docker ps --format '{{ .ID }}' --filter ancestor=router
++ xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
+ ROUTER_1='feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f router_fbenneto-1'
++ get_router 2
++ local ID=2
++ get_router_containers
++ ROUTER_IMG_NAME=router
++ grep -- -2
++ docker ps --format '{{ .ID }}' --filter ancestor=router
++ xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
+ ROUTER_2='760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 router_fbenneto-2'
+ '[' -z 'feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f router_fbenneto-1' ']'
+ '[' -z '760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 router_fbenneto-2' ']'
+ VXLAN_CONFIG=vxlan_unicast.sh
+ ROUTER_1_ID=feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f
+ configure_vxlan_router feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f 10.0.0.1 10.0.0.2
+ local container_id=feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f
+ local local_ip=10.0.0.1
+ local remote_ip=10.0.0.2
+ docker exec -e LOCAL_IP=10.0.0.1 -e REMOTE_IP=10.0.0.2 -i feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f bash
+ LOCAL_IP=10.0.0.1
+ REMOTE_IP=10.0.0.2
++ hostname
+ HOST=router_fbenneto-1
+ ID=1
+ EGRESS_DEV=eth0
+ IGRESS_DEV=eth1
+ VXLAN_DEV=vxlan10
+ VNI=10
+ BRIDGE_DEV=br0
+ ip addr add 10.0.0.1/24 dev eth0
+ ip link add name vxlan10 type vxlan id 10 local 10.0.0.1 remote 10.0.0.2 dstport 4789 dev eth0
+ ip link set up dev vxlan10
+ ip link add name br0 type bridge
+ brctl addif br0 vxlan10
+ brctl addif br0 eth1
+ ip link set up dev br0
+ brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.3ea73dbfbba1       no              eth1
                                                        vxlan10
+ ip -d link show br0
3: br0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:a7:3d:bf:bb:a1 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.3E:A7:3D:BF:BB:A1 designated_root 8000.3E:A7:3D:BF:BB:A1 root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer    0.10 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ip -d link show vxlan10
2: vxlan10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master br0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether ea:75:4d:86:4f:57 brd ff:ff:ff:ff:ff:ff promiscuity 1 minmtu 68 maxmtu 65535
    vxlan id 10 remote 10.0.0.2 local 10.0.0.1 dev eth0 srcport 0 0 dstport 4789 ttl auto ageing 300 udpcsum noudp6zerocsumtx noudp6zerocsumrx
    bridge_slave state forwarding priority 32 cost 100 hairpin off guard off root_block off fastleave off learning on flood on port_id 0x8001 port_no 0x1 designated_port 32769 designated_cost 0 designated_bridge 8000.3E:A7:3D:BF:BB:A1 designated_root 8000.3E:A7:3D:BF:BB:A1 hold_timer    0.00 message_age_timer    0.00 forward_delay_timer   14.99 topology_change_ack 0 config_pending 0 proxy_arp off proxy_arp_wifi off mcast_router 1 mcast_fast_leave off mcast_flood on mcast_to_unicast off neigh_suppress off group_fwd_mask 0 group_fwd_mask_str 0x0 vlan_tunnel off isolated off addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ROUTER_2_ID=760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836
+ configure_vxlan_router 760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 10.0.0.2 10.0.0.1
+ local container_id=760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836
+ local local_ip=10.0.0.2
+ local remote_ip=10.0.0.1
+ docker exec -e LOCAL_IP=10.0.0.2 -e REMOTE_IP=10.0.0.1 -i 760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 bash
+ LOCAL_IP=10.0.0.2
+ REMOTE_IP=10.0.0.1
++ hostname
+ HOST=router_fbenneto-2
+ ID=2
+ EGRESS_DEV=eth0
+ IGRESS_DEV=eth1
+ VXLAN_DEV=vxlan10
+ VNI=10
+ BRIDGE_DEV=br0
+ ip addr add 10.0.0.2/24 dev eth0
+ ip link add name vxlan10 type vxlan id 10 local 10.0.0.2 remote 10.0.0.1 dstport 4789 dev eth0
+ ip link set up dev vxlan10
+ ip link add name br0 type bridge
+ brctl addif br0 vxlan10
+ brctl addif br0 eth1
+ ip link set up dev br0
+ brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.9e4e21a3b87e       no              eth1
                                                        vxlan10
+ ip -d link show br0
3: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 9e:4e:21:a3:b8:7e brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.9E:4E:21:A3:B8:7E designated_root 8000.9E:4E:21:A3:B8:7E root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer    0.09 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ip -d link show vxlan10
2: vxlan10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master br0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether de:71:1a:f3:24:cb brd ff:ff:ff:ff:ff:ff promiscuity 1 minmtu 68 maxmtu 65535
    vxlan id 10 remote 10.0.0.1 local 10.0.0.2 dev eth0 srcport 0 0 dstport 4789 ttl auto ageing 300 udpcsum noudp6zerocsumtx noudp6zerocsumrx
    bridge_slave state forwarding priority 32 cost 100 hairpin off guard off root_block off fastleave off learning on flood on port_id 0x8001 port_no 0x1 designated_port 32769 designated_cost 0 designated_bridge 8000.9E:4E:21:A3:B8:7E designated_root 8000.9E:4E:21:A3:B8:7E hold_timer    0.00 message_age_timer    0.00 forward_delay_timer   14.99 topology_change_ack 0 config_pending 0 proxy_arp off proxy_arp_wifi off mcast_router 1 mcast_fast_leave off mcast_flood on mcast_to_unicast off neigh_suppress off group_fwd_mask 0 group_fwd_mask_str 0x0 vlan_tunnel off isolated off addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
```

#### Configure the routers with GROUP VXLAN

```bash
$ bash routers_group.sh
+ source config_routers.sh
++ get_router 1
++ local ID=1
++ get_router_containers
++ ROUTER_IMG_NAME=router
++ grep -- -1
++ docker ps --format '{{ .ID }}' --filter ancestor=router
++ xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
+ ROUTER_1='feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f router_fbenneto-1'
++ get_router 2
++ local ID=2
++ get_router_containers
++ ROUTER_IMG_NAME=router
++ grep -- -2
++ docker ps --format '{{ .ID }}' --filter ancestor=router
++ xargs -n 1 docker inspect --format '{{ .Id }} {{ .Config.Hostname }}'
+ ROUTER_2='760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 router_fbenneto-2'
+ '[' -z 'feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f router_fbenneto-1' ']'
+ '[' -z '760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 router_fbenneto-2' ']'
+ VXLAN_CONFIG=vxlan_group.sh
+ ROUTER_1_ID=feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f
+ configure_vxlan_router feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f 10.0.0.1 10.0.0.2
+ local container_id=feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f
+ local local_ip=10.0.0.1
+ local remote_ip=10.0.0.2
+ docker exec -e LOCAL_IP=10.0.0.1 -e REMOTE_IP=10.0.0.2 -i feca9f69b64080abf5609e85dd5b73842a24a4006fefa00b61d193db5ca4ea2f bash
+ LOCAL_IP=10.0.0.1
+ REMOTE_IP=10.0.0.2
++ hostname
+ HOST=router_fbenneto-1
+ ID=1
+ EGRESS_DEV=eth0
+ IGRESS_DEV=eth1
+ VXLAN_DEV=vxlan10
+ VXLAN_GROUP=239.1.1.1
+ VNI=10
+ BRIDGE_DEV=br0
+ ip addr add 10.0.0.1/24 dev eth0
+ ip link add name vxlan10 type vxlan id 10 group 239.1.1.1 dstport 4789 dev eth0
+ ip link set up dev vxlan10
+ ip link add name br0 type bridge
+ brctl addif br0 vxlan10
+ brctl addif br0 eth1
+ ip link set up dev br0
+ brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.76191a6e6de6       no              eth1
                                                        vxlan10
+ ip -d link show br0
3: br0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 76:19:1a:6e:6d:e6 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.76:19:1A:6E:6D:E6 designated_root 8000.76:19:1A:6E:6D:E6 root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer    0.09 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ip -d link show vxlan10
2: vxlan10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master br0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 76:19:1a:6e:6d:e6 brd ff:ff:ff:ff:ff:ff promiscuity 1 minmtu 68 maxmtu 65535
    vxlan id 10 group 239.1.1.1 dev eth0 srcport 0 0 dstport 4789 ttl auto ageing 300 udpcsum noudp6zerocsumtx noudp6zerocsumrx
    bridge_slave state forwarding priority 32 cost 100 hairpin off guard off root_block off fastleave off learning on flood on port_id 0x8001 port_no 0x1 designated_port 32769 designated_cost 0 designated_bridge 8000.76:19:1A:6E:6D:E6 designated_root 8000.76:19:1A:6E:6D:E6 hold_timer    0.00 message_age_timer    0.00 forward_delay_timer   14.99 topology_change_ack 0 config_pending 0 proxy_arp off proxy_arp_wifi off mcast_router 1 mcast_fast_leave off mcast_flood on mcast_to_unicast off neigh_suppress off group_fwd_mask 0 group_fwd_mask_str 0x0 vlan_tunnel off isolated off addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ROUTER_2_ID=760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836
+ configure_vxlan_router 760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 10.0.0.2 10.0.0.1
+ local container_id=760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836
+ local local_ip=10.0.0.2
+ local remote_ip=10.0.0.1
+ docker exec -e LOCAL_IP=10.0.0.2 -e REMOTE_IP=10.0.0.1 -i 760b85d64cb1f6393b1a6e4f0ef4e3a58d26b1bb87885f45b2b66b5352ff4836 bash
+ LOCAL_IP=10.0.0.2
+ REMOTE_IP=10.0.0.1
++ hostname
+ HOST=router_fbenneto-2
+ ID=2
+ EGRESS_DEV=eth0
+ IGRESS_DEV=eth1
+ VXLAN_DEV=vxlan10
+ VXLAN_GROUP=239.1.1.1
+ VNI=10
+ BRIDGE_DEV=br0
+ ip addr add 10.0.0.2/24 dev eth0
+ ip link add name vxlan10 type vxlan id 10 group 239.1.1.1 dstport 4789 dev eth0
+ ip link set up dev vxlan10
+ ip link add name br0 type bridge
+ brctl addif br0 vxlan10
+ brctl addif br0 eth1
+ ip link set up dev br0
+ brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.863af8401ac7       no              eth1
                                                        vxlan10
+ ip -d link show br0
3: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 86:3a:f8:40:1a:c7 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.86:3A:F8:40:1A:C7 designated_root 8000.86:3A:F8:40:1A:C7 root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer    0.10 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
+ ip -d link show vxlan10
2: vxlan10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master br0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether d2:1e:f6:c7:40:e8 brd ff:ff:ff:ff:ff:ff promiscuity 1 minmtu 68 maxmtu 65535
    vxlan id 10 group 239.1.1.1 dev eth0 srcport 0 0 dstport 4789 ttl auto ageing 300 udpcsum noudp6zerocsumtx noudp6zerocsumrx
    bridge_slave state forwarding priority 32 cost 100 hairpin off guard off root_block off fastleave off learning on flood on port_id 0x8001 port_no 0x1 designated_port 32769 designated_cost 0 designated_bridge 8000.86:3A:F8:40:1A:C7 designated_root 8000.86:3A:F8:40:1A:C7 hold_timer    0.00 message_age_timer    0.00 forward_delay_timer   15.00 topology_change_ack 0 config_pending 0 proxy_arp off proxy_arp_wifi off mcast_router 1 mcast_fast_leave off mcast_flood on mcast_to_unicast off neigh_suppress off group_fwd_mask 0 group_fwd_mask_str 0x0 vlan_tunnel off isolated off addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
```

### Configure the hosts

To configure the hosts, simply execute [`hosts_cfg.sh`](hosts_cfg.sh)

```bash
$ bash hosts_cfg.sh
+ ID=1
++ get_hosts_containers
++ HOST_IMG_NAME=host
++ docker ps --format '{{ .ID }}' --filter ancestor=host
+ for host in $(get_hosts_containers)
+ docker exec 9cf680281f2e bash -c 'ip addr add 42.42.42.1/24 dev eth0; ip link show eth0'
18: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN qlen 1000
    link/ether 7a:73:49:8a:fc:27 brd ff:ff:ff:ff:ff:ff
+ ID=2
+ for host in $(get_hosts_containers)
+ docker exec 8c7200d2ca2f bash -c 'ip addr add 42.42.42.2/24 dev eth0; ip link show eth0'
13: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN qlen 1000
    link/ether b2:33:f4:04:e5:72 brd ff:ff:ff:ff:ff:ff
+ ID=3
```


## Sources

- [Configure VXLAN for ConnectX-3](https://support.mellanox.com/s/article/howto-configure-vxlan-for-connectx-3-pro--linux-bridge-x)
- [Kernel networking vxlan](https://www.kernel.org/doc/Documentation/networking/vxlan.txt)
- [Kernel doc vxlan](https://www.kernel.org/doc/html/v5.12/networking/vxlan.html)
- [Configure VXLAN with unicast endpoint](https://joejulian.name/post/how-to-configure-linux-vxlans-with-multiple-unicast-endpoints/)
- [Serverfault Configuring VXLAN unicast in linux](https://serverfault.com/questions/777179/configuring-vxlan-unicast-in-linux)
- [Vagrantfile vxlan configuration](https://gist.github.com/hkwi/bf37f478bbddafbad21b67d0adcd3370)
- [VXLAN without multicast](https://vincent.bernat.ch/fr/blog/2017-vxlan-linux#sans-multicast)
