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
    cpy $iyam@$1
    if [ -f secrets ]; then
        ssh $iyam@$1 sudo /tmp/ipasetup/subscribe.sh
        sleep 240
    fi
    ssh $iyam@$1 rm -fr /tmp/ipasetup/secrets
    ssh $iyam@$1 sudo /tmp/ipasetup/server/ipasetup.sh
    ssh $iyam@$1 sudo /tmp/ipasetup/server/useradd.sh
fi
