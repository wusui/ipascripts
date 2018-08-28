#!/bin/bash
# TO DO: add to end of ipasetup for testing.
kinit admin <<EOF
t0pSecret
EOF
ipa user-add rgw <<EOF
r
gw
EOF
ipa user-add newuser <<EOF
new
user
EOF
ipa user-mod rgw --password <<EOF
t0pSecret
t0pSecret
EOF
ipa user-mod newuser --password <<EOF
t0pSecret
t0pSecret
EOF
