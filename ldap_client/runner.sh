#!/bin/bash -fv
iyam=`whoami`
ssh $iyam@$1 sudo iptables -F
ssh $iyam@$1 sudo ceph osd pool set .rgw.root pg_num 64
ssh $iyam@$1 sudo ceph osd pool set .rgw.root pgp_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.control pg_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.control pgp_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.meta pg_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.meta pgp_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.log pg_num 64
ssh $iyam@$1 sudo ceph osd pool set default.rgw.log pgp_num 64
sleep 240
ssh $iyam@$1 sudo yum -y install openldap-clients
ssh $iyam@$1 sudo yum-config-manager --enable epel
ssh $iyam@$1 sudo yum -y install python-boto
ssh $iyam@$1 sudo yum-config-manager --disable epel
scp setbindpass.py $iyam@$1:/tmp/setbindpass.py
ssh $iyam@$1 sudo python /tmp/setbindpass.py
ssh $iyam@$1 '(sudo ceph node ls > /tmp/nodes.json)'
scp $iyam@$1:/tmp/nodes.json /tmp/nodes.json
scp $iyam@$1:/etc/ceph/ceph.conf /tmp/ceph.conf
scp $iyam@$1:/etc/bindpass /tmp/bindpass
python ./copy_conf.py
scp setglobals.py $iyam@$1:/tmp/setglobals.py
ssh $iyam@$1 sudo python /tmp/setglobals.py $2
ssh $iyam@$1 sudo chown admin:admin /etc/bindpass
ssh $iyam@$1 sudo systemctl restart ceph-radosgw
ssh $iyam@$1 sudo systemctl restart ceph-radosgw@rgw.$1
scp bucket.py $iyam@$1:/tmp/bucket.py
ssh $iyam@$1 sudo chmod 0777 /tmp/bucket.py
scp runbucket.sh $iyam@$1:/tmp/runbucket.sh
ssh $iyam@$1 sudo /tmp/runbucket.sh
scp $iyam@$1:/tmp/pyoutput /tmp/pyoutput
exitcode=0
z=`tail -1 /tmp/pyoutput | grep 'new-bucket'`
if [ -z "$z" ]; then
    exitcode=1
fi
ssh $iyam@$1 rm /tmp/setbindpass.py /tmp/nodes.json /tmp/setglobals.py /tmp/bucket.py /tmp/runbucket.sh /tmp/pyoutput /tmp/ceph.conf /tmp/bindpass
rm /tmp/pyoutput /tmp/nodes.json /tmp/ceph.conf /tmp/bindpass
exit $exitcode
