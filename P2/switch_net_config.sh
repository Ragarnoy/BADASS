# Configuration script used by `switch_cfg.sh`
set -eux

ip link add name br0 type bridge

# Add every network interface named `eth*` to the bridge `br0`
for eth in $(ip link show | grep 'eth\d\d*' | sed 's/\d*: eth\(\d*\).*/eth\1/'); do
    brctl addif br0 $eth;
done

ip link set up br0
brctl show br0
