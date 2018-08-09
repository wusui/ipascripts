#!/bin/bash -fv
./paranoia.sh $1
if $retv; then
    tar cvf /tmp/ipatar .
    iyam=`whoami`
    scp /tmp/ipatar $iyam@$1:/tmp/ipatar
    scp unpacker.sh $iyam@$1:/tmp/unpacker.sh
    ssh $iyam@$1 sudo /tmp/unpacker.sh
    ssh $iyam@$1 sudo /tmp/ipasetup/subscribe.sh
    rm -fr /tmp/ipasetup/secrets
    sleep 240
    scp /tmp/ipatar $iyam@$1:/tmp/ipatar
    scp unpacker.sh $iyam@$1:/tmp/unpacker.sh
    rm -fr /tmp/ipasetup/secrets
    ssh $iyam@$1 sudo /tmp/unpacker.sh
    ssh $iyam@$1 sudo /tmp/ipasetup/ipasetup.sh
    ssh $iyam@$1 sudo /tmp/ipasetup/useradd.sh
fi
