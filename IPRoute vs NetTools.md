# IPRoute2 vs Net-Tools

`net-tools` (`ifconfig`, `route`, `arp`, `netstat`, ...) is the historical BSD-inspired toolkit used to configure networking on Linux. It has been mostly unmaintained since 2001 and does not know about many modern kernel features (multiple addresses per interface, network namespaces, policy routing, ...). Most distributions (Arch, RHEL/Fedora, Debian, Ubuntu) no longer install it by default.

`iproute2` is its replacement: a single `ip` command (plus `ss`, `bridge`, `tc`) that talks to the kernel through Netlink.

> Changes made with `ip` are **not persistent**: they are lost at reboot. See [Permanent configuration](#permanent-configuration).

## Equivalence table

| Task | net-tools | iproute2 |
| --- | --- | --- |
| Show interfaces and addresses | `ifconfig -a` | `ip addr` / `ip -br a` |
| Bring an interface up / down | `ifconfig eth0 up` | `ip link set eth0 up` |
| Add an IP address | `ifconfig eth0 10.0.0.1 netmask 255.255.255.0` | `ip addr add 10.0.0.1/24 dev eth0` |
| Change MAC address | `ifconfig eth0 hw ether AA:BB:..` | `ip link set eth0 address AA:BB:..` |
| Routing table | `route -n` | `ip route` |
| Default gateway | `route add default gw 10.0.0.254` | `ip route add default via 10.0.0.254` |
| ARP / neighbour table | `arp -n` | `ip neigh` |
| Sockets / open ports | `netstat -tulpn` | `ss -tulpn` |
| Interface statistics | `netstat -i` | `ip -s link` |
| VLAN | `vconfig add eth0 10` | `ip link add link eth0 name eth0.10 type vlan id 10` |
| Bridge | `brctl addbr br0` | `ip link add br0 type bridge` |
| Tunnels | `iptunnel` | `ip tunnel` |
| Multicast | `ipmaddr` | `ip maddr` |

## Useful options

```bash
ip -br a          # brief: one line per interface
ip -c a           # coloured output
ip -4 a           # IPv4 only (ip -6 a for IPv6)
ip -s link        # statistics (RX/TX, errors, drops)
ip -j a | jq .    # JSON output, easy to parse in scripts
```

Objects can be abbreviated: `ip a` = `ip addr`, `ip r` = `ip route`, `ip n` = `ip neigh`, `ip l` = `ip link`.

## Interfaces and addresses

```bash
# List interfaces (state, MAC, MTU)
ip link show

# Bring an interface up / down
sudo ip link set dev eth1 up
sudo ip link set dev eth1 down

# Add / remove an IPv4 address (several addresses per interface are allowed)
sudo ip addr add 10.0.0.1/24 dev eth1
sudo ip addr add 10.0.0.2/24 dev eth1
sudo ip addr del 10.0.0.1/24 dev eth1

# Remove every address from an interface
sudo ip addr flush dev eth1

# Change MAC address (interface must be down)
sudo ip link set dev eth1 down
sudo ip link set dev eth1 address AA:BB:CC:DD:EE:FF
sudo ip link set dev eth1 up

# Change MTU
sudo ip link set dev eth1 mtu 9000
```

## Routing

```bash
# Show the routing table
ip route show

# Which route / interface / source IP is used to reach a host?
ip route get 1.1.1.1

# Add or replace the default gateway
sudo ip route add default via 192.168.1.254 dev eth0
sudo ip route replace default via 192.168.1.1 dev eth0

# Add / remove a static route
sudo ip route add 172.16.32.0/24 via 192.168.1.1 dev eth0
sudo ip route del 172.16.32.0/24
```

## Neighbours (ARP / NDP)

```bash
ip neigh show                                           # ARP + IPv6 neighbour cache
sudo ip neigh add 192.168.1.50 lladdr AA:BB:CC:DD:EE:FF dev eth0   # static entry
sudo ip neigh flush dev eth0                            # clear the cache
```

## Sockets with `ss`

```bash
ss -tulpn                            # listening TCP/UDP ports + process (needs sudo for all PIDs)
ss -tan state established            # established TCP connections
ss -tn dst 192.168.1.10              # connections to a given host
ss -tlnp '( sport = :22 )'           # who listens on port 22
ss -s                                # summary
```

## VLANs, bridges and tunnels

```bash
# VLAN 10 on eth0
sudo ip link add link eth0 name eth0.10 type vlan id 10
sudo ip link set eth0.10 up
sudo ip link del eth0.10

# Bridge (e.g. for VMs) and attach eth1 to it
sudo ip link add br0 type bridge
sudo ip link set eth1 master br0
sudo ip link set br0 up
bridge link show

# GRE tunnel
sudo ip tunnel add gre1 mode gre local 198.51.100.1 remote 203.0.113.2 ttl 255
sudo ip addr add 10.10.10.1/30 dev gre1
sudo ip link set gre1 up
```

## Troubleshooting

```bash
ip monitor all                 # watch link / address / route changes live
ip -s -s link show dev eth0    # detailed error counters
```

## Permanent configuration

The configuration tool depends on the distribution / network stack.

### Debian (ifupdown) — `/etc/network/interfaces`

```bash
sudo tee /etc/network/interfaces.d/eth0 <<'EOF'
auto eth0
iface eth0 inet static
    address 192.168.1.10/24
    gateway 192.168.1.1
EOF
sudo systemctl restart networking   # or: sudo ifdown eth0 && sudo ifup eth0
```

### Fedora / RHEL / desktops (NetworkManager)

```bash
nmcli connection show
sudo nmcli connection modify eth0 ipv4.method manual \
     ipv4.addresses 192.168.1.10/24 ipv4.gateway 192.168.1.1 ipv4.dns 1.1.1.1
sudo nmcli connection up eth0
```

### systemd-networkd

```bash
sudo tee /etc/systemd/network/10-eth0.network <<'EOF'
[Match]
Name=eth0

[Network]
Address=192.168.1.10/24
Gateway=192.168.1.1
DNS=1.1.1.1
EOF
sudo systemctl enable --now systemd-networkd
```

> Ubuntu uses **Netplan** (`/etc/netplan/*.yaml`, then `sudo netplan apply`), which generates a NetworkManager or systemd-networkd configuration.

## Links

- <https://www.xmodulo.com/linux-tcpip-networking-net-tools-iproute2.html>
- <https://www.tala-informatique.fr/wiki/index.php/Iproute2>
- `man ip`, `man ip-route`, `man ss`
