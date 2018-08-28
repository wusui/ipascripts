#!/bin/bash
export RGW_ACCESS_KEY_ID="newuser"
export RGW_SECRET_ACCESS_KEY='t0pSecret'
tkn=`radosgw-token --encode --ttype=ldap`
sed -i "s/XXXXX/${tkn}/" /tmp/bucket.py
python /tmp/bucket.py > /tmp/pyoutput
cat /tmp/pyoutput
