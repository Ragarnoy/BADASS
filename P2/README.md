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

To configure the script, execute the script [`switch_cfg.sh`](switch_cfg.sh) with the container name/id of the switch.

```bash
bash switch_cfg.sh b4db6a44a83e
```

This script will bridge every `eth*` interface together by using a bridge interface.

### Configure the routers

#### Configure the routers with UNICAST VXLAN

To configure the routers to use VXLAN in UNICAST mode, execute [`routers_unicast.sh`](routers_unicast.sh)

```bash
bash routers_unicast.sh
```

#### Configure the routers with GROUP VXLAN

To configure the routers to use VXLAN in GROUP mode, execute [`routers_group.sh`](routers_group.sh)

```bash
bash routers_group.sh
```

### Configure the hosts

To configure the hosts, simply execute [`hosts_cfg.sh`](hosts_cfg.sh)

```bash
bash hosts_cfg.sh
```

## Sources

- [Configure VXLAN for ConnectX-3](https://support.mellanox.com/s/article/howto-configure-vxlan-for-connectx-3-pro--linux-bridge-x)
- [Kernel networking vxlan](https://www.kernel.org/doc/Documentation/networking/vxlan.txt)
- [Kernel doc vxlan](https://www.kernel.org/doc/html/v5.12/networking/vxlan.html)
- [Configure VXLAN with unicast endpoint](https://joejulian.name/post/how-to-configure-linux-vxlans-with-multiple-unicast-endpoints/)
- [Serverfault Configuring VXLAN unicast in linux](https://serverfault.com/questions/777179/configuring-vxlan-unicast-in-linux)
- [Vagrantfile vxlan configuration](https://gist.github.com/hkwi/bf37f478bbddafbad21b67d0adcd3370)
- [VXLAN without multicast](https://vincent.bernat.ch/fr/blog/2017-vxlan-linux#sans-multicast)
