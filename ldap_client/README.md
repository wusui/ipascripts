# Test RGW authentication via LDAP 

This script should be run on a ceph node on which rgw is installed.  It sets up a user that can be authenticated with ldap, and tests that the authentication worked by running a short python boto script.

```
Usage:
    ./runner.sh <ceph-node> <ldap-node>
```
