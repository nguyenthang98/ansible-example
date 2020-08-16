#!/bin/sh

echo 'Setting static IP address for Hyper-V instance...'

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
ONBOOT="yes"
DEVICE="eth0"
BOOTPROTO="static"
IPADDR=$1
NETMASK=255.255.255.0
GATEWAY=192.168.100.1
EOF

cat << EOF >> /etc/resolve.conf
nameserver 8.8.8.8
nameserver 4.4.4.4
EOF
