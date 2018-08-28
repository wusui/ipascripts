#! /bin/python
import yaml
import sys
try:
    fname="/tmp/ipasetup/%s/install.yaml" % sys.argv[1]
    print fname
    with open(fname, 'r') as fd1:
        out_val = yaml.load(fd1)
except (IOError, IndexError) as e:
    out_val = ['rhel-7-server-rpms', 'rhel-7-server-extras-rpms', 'rhel-7-server-rh-common-rpms', 'rhel-7-server-optional-rpms']
print ' '.join(out_val)
