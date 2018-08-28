#!/bin/bash -fv
echo "Stuff goes here"
ssh $1 sudo yum install yum-utils vim -y
ssh $1 sudo yum-config-manager --disable epel
ssh $1 sudo iptables -F
