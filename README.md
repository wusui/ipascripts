# LDAP authentication tester

This directory contains a subdirectory for the LDAP server, a subdirectory for a ceph node, and a subdirectory for the client (the radosgw node that will use LDAP authentication).

Each subdirectory contains a corresponding README.md file.

This directory also contains an install script, install.sh, which can be used toinstall the ldap_server, or to setup sites on a ceph cluster prior to running the appropriate ansible playbooks.  It uses the subscription manager to setup a RHEL system.

Before running install.sh, create a file named secrets that minimally contains the following lines:

```
export subscrname='USER@redhat.com'
export subscrpassword='PASSWORD'
```

USER is a Red Hat subscription-manager user.
PASSWORD is USER's password.

Then run ./install.sh <site> { ldap_server | ceph_node } to install on that site.
