#!/bin/bash -fv
iyam=`whoami`
#ssh $iyam@$1 sudo yum install openldap-clients
ssh $iyam@$1 sudo iptables -F
scp setbindpass.py $iyam@$1:/tmp/setbindpass.py
ssh $iyam@$1 sudo python /tmp/setbindpass.py
ssh $iyam@$1 '(sudo ceph node ls > /tmp/nodes.json)'
scp $iyam@$1:/tmp/nodes.json /tmp/nodes.json
scp $iyam@$1:/etc/ceph/ceph.conf /tmp/ceph.conf
python ./copy_conf.py
scp setglobals.py $iyam@$1:/tmp/setglobals.py
ssh $iyam@$1 sudo python /tmp/setglobals.py $2
ssh $iyam@$1 sudo systemctl restart ceph-radosgw
ssh $iyam@$1 sudo systemctl restart ceph-radosgw@rgw.$1
scp bucket.py $iyam@$1:/tmp/bucket.py
scp runbucket.sh $iyam@$1:/tmp/runbucket.sh
ssh $iyam@$1 sudo /tmp/runbucket.sh
scp $iyam@$1:/tmp/pyoutput /tmp/pyoutput
z=`tail -1 /tmp/pyoutput | grep 'new-bucket'`
if [ -z "$z" ]; then
    exit 1
fi
exit 0
