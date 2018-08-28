#!/bin/python
import sys
import ConfigParser
site = sys.argv[1]
c2= ConfigParser.SafeConfigParser()
c2.read('/etc/ceph/ceph.conf')
c2.set('global','rgw_ldap_uri','"ldap://%s.ceph.redhat.com:389"' % site)
c2.set('global','rgw_ldap_binddn','"uid=rgw,cn=users,cn=accounts,dc=ceph,dc=redhat,dc=com"')
c2.set('global','rgw_ldap_searchdn','"cn=users,cn=accounts,dc=ceph,dc=redhat,dc=com"')
c2.set('global','rgw_ldap_dnattr','"uid"')
c2.set('global','rgw_s3_auth_use_ldap','"true"')
c2.set('global','debug rgw','20')
with open('/etc/ceph/ceph.conf', 'w') as x:
    c2.write(x)
