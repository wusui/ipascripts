#!/bin/bash -fv
iptables -F
sudo yum -y install ipa-server ipa-server-dns
sudo yum -y remove mod_ssl
sudo systemctl restart messagebus
sudo ipa-server-install --realm ceph.redhat.com --ds-password t0pSecret --admin-password t0pSecret --unattended
