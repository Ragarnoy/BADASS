# Configuration script used by `switch_cfg.sh`
set -eux

ip link add name br0 type bridge

# Add every network interface named `eth*` to the bridge `br0`
for eth in $(ip link show | grep 'eth\d\d*' | sed 's/\d*: eth\(\d*\).*/eth\1/'); do
    ip link set dev $eth master br0;
done

ip link set up br0
ip link show br0
ip a | grep 'master br0'
