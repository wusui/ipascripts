#!/bin/bash -fv
ssh $1 sudo yum install yum-utils vim -y
ssh $1 sudo yum-config-manager --disable epel
ssh $1 sudo iptables -F
ssh $1 sudo parted /dev/sdb<<EOF
mklabel gpt
quit
EOF
ssh $1 sudo parted /dev/sdc<<EOF
mklabel gpt
quit
EOF
ssh $1 sudo parted /dev/sdd<<EOF
mklabel gpt
quit
EOF
ifcfg=`ssh $1 ls /etc/sysconfig/network-scripts/ifcfg-* | head -1`
echo "sed -i 's/BOOTPROTO.*/BOOTPROTO=none/' $ifcfg"  > /tmp/ifcfg.sh
echo "sed -i 's/ONBOOT.*/ONBOOT=yes/' $ifcfg"  >> /tmp/ifcfg.sh
scp /tmp/ifcfg.sh $1:/tmp/ifcfg.sh
ssh $1 sudo chmod 0777 /tmp/ifcfg.sh
ssh $1 sudo /tmp/ifcfg.sh
ssh $1 sudo rm -rf /tmp/ifcfg.sh
rm -rf /tmp/ifcfg.sh
ssh $1 sudo useradd admin
ssh $1 sudo passwd admin<<EOF
admin
admin
EOF
echo "admin ALL = (root) NOPASSWD:ALL" > /tmp/admin
scp /tmp/admin $1:/tmp/admin
ssh $1 sudo cp /tmp/admin /etc/sudoers.d/admin
ssh $1 sudo chmod 0440 /etc/sudoers.d/admin
