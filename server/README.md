# IPA installer

Install an IPA server on a machine in order to test ldap authentication of
Rados Gateway users.

To Run:
```
./runner.sh HOST
```

If you want to install using the subscription manager to setup a RHEL system, before running runner.sh create a file named secrets that minimally contains the following lines:

```
export subscrname='USER@redhat.com'
export subscrpassword='PASSWORD'
```

USER is a Red Hat subscription-manager user.
PASSWORD is USER's password.
