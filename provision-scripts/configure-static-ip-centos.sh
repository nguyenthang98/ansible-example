#!/bin/sh

echo 'Setting static IP address for Hyper-V instance...'

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
ONBOOT="yes"
DEVICE="eth0"
BOOTPROTO="static"
IPADDR=$1
NETMASK=255.255.255.0
GATEWAY=192.168.100.1
DNS1=8.8.8.8
DNS2=4.4.4.4
EOF

cat << EOF >> /etc/resolv.conf
nameserver 8.8.8.8
nameserver 4.4.4.4
EOF

sed -i "s/PasswordAuthentication\ no/PasswordAuthentication\ yes/g" /etc/ssh/sshd_config
