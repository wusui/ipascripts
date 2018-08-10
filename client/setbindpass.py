#!/bin/python
import ConfigParser
c2= ConfigParser.SafeConfigParser()
c2.read('/etc/ceph/ceph.conf')
c2.set('global','rgw_ldap_secret','"/etc/bindpass"')
with open('/etc/ceph/ceph.conf', 'w') as x:
    c2.write(x)
