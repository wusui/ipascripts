#!/bin/python
import ConfigParser
c2= ConfigParser.ConfigParser
with open('/etc/ceph/ceph.conf') as x:
    c2.readfp(x)
c2.set('global','rgw_ldap_secret','"/etc/bindpass"')
with open('/etc/ceph/ceph.conf') as x:
    c2.write(x)
