# IPA installer

Install an IPA server on a machine in order to test ldap authentication of
Rados Gateway users.

To Run:

create a file named secrets that minimally contains the following lines: 

```
export subscrname='USER@redhat.com'
export subscrpassword='PASSWORD'
```

USER is a Red Hat subscription-manager user.
PASSWORD is USER's password.

To run:

```
./runner.sh HOST
```
