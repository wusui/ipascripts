#!/bin/bash -fv
ssh $1 sudo /tmp/ipasetup/server/ipasetup.sh
ssh $1 sudo /tmp/ipasetup/server/useradd.sh
ssh $1 sudo iptables -F
