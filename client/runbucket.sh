#!/bin/python
export RGW_ACCESS_KEY_ID="tester"
export RGW_SECRET_ACCESS_KEY='t0pSecret'
tkn=`radosgw-token --encode --type=ldap`
sed -i "s/XXXXX/${tkn}/" /tmp/bucket.py
python /tmp/bucket.py
