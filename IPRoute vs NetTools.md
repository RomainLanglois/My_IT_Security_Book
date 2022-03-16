# IPRoute vs NetTools
Many sysadmins still manage and troubleshoot various network configurations by using a combination of `ifconfig`, `route`, `arp` and `netstat` command-line tools, collectively known as `net-tools`. Originally rooted in the BSD TCP/IP toolkit, the `net-tools` was developed to configure network functionality of older Linux kernels. Its development in the Linux community so far has ceased since 2001. Some Linux distros such as Arch Linux and CentOS/RHEL 7 have already deprecated `net-tools`, and others are planning to do so in favor of `iproute2`.

## Relation
| Description | Net-tool | iproute2|
| --- | --- | --- |
| Configure address and link | ifconfig | ip address, ip link |
| Routing tables | route | ip route |
| Statistics | netstat | ss |
| Neighbours | arp | ip neighbour |
| Vlan | vconfig | ip link|
| Tunnels | iptunnel | ip tunnel |
| Multicast | ipmaddr | ip maddr |

## Important commands for IPRoute
```bash
# Show All Connected Network Interfaces
$ ip link show

# Activate or Deactivate a Network Interface
$ sudo ip link set down eth1
$ sudo ip link set up eth1

# Assign IPv4 address(es) to a Network Interface
$ sudo ip addr add 10.0.0.1/24 broadcast 10.0.0.255 dev eth1
$ sudo ip addr add 10.0.0.2/24 broadcast 10.0.0.255 dev eth1
$ sudo ip addr add 10.0.0.3/24 broadcast 10.0.0.255 dev eth1

# Remove an IPv4 address from a Network Interface
$ sudo ip addr del 10.0.0.1/24 dev eth1

# Change the MAC Address of a Network Interface
$ sudo ip link set dev eth1 address AA:BB:CC:DD:EE:FF

# View the IP Routing Table
$ ip route show

# Add or Modify a Default Route
$ sudo ip route add default via 192.168.1.2 dev eth0
$ sudo ip route replace default via 192.168.1.2 dev eth0

# Add or Remove a Static Route
$ sudo ip route add 172.16.32.0/24 via 192.168.1.1 dev eth0
$ sudo ip route del 172.16.32.0/24

# Configure VLANs
$ sudo ip link add link eth0 name eth0.1 type vlan id 1
$ sudo ip link del eth0.1
```

## Permanent configuration
#### On Debian / Ubuntu
- All configuration must be performed on the /etc/network/interfaces file

## Important link
- https://www.xmodulo.com/linux-tcpip-networking-net-tools-iproute2.html
- https://www.tala-informatique.fr/wiki/index.php/Iproute2