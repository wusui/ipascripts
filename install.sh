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
        ssh $iyam@$1 sudo /tmp/ipasetup/subscribe.sh $2
        # To DO: Should probably come up with a better "wait until up" test.
        sleep 240
    fi
    ssh $iyam@$1 rm -fr /tmp/ipasetup/secrets
    cd ${2}
    ./local.sh $iyam@$1
fi
ssh $1 rm -rf /tmp/ipasetup
ssh $1 rm /tmp/unpacker.sh
