#!/bin/bash -fv
function cpy() {
    echo $1
    scp /tmp/ipatar $1:/tmp/ipatar
    scp unpacker.sh $1:/tmp/unpacker.sh
    ssh $1 sudo /tmp/unpacker.sh
}

./paranoia.sh $1
if $retv; then
    tar cvf /tmp/ipatar .
    iyam=`whoami`
    if [ -f secrets ]; then
        cpy $iyam@$1
        ssh $iyam@$1 sudo /tmp/ipasetup/subscribe.sh
        sleep 240
    fi
    cpy $iyam@$1
    ssh $iyam@$1 rm -fr /tmp/ipasetup/secrets
    ssh $iyam@$1 sudo /tmp/ipasetup/ipasetup.sh
    ssh $iyam@$1 sudo /tmp/ipasetup/useradd.sh
fi
