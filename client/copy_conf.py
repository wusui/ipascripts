#!/bin/python
import json
import os
from subprocess import Popen

with open('/tmp/nodes.json') as x:
    cnodes = json.loads(x)
sites = set()
for mtype in cnodes.keys:
    for indx in mtype:
        noden = mtype[indx].split('.')[0]
        sites.add(noden)
slist = list(sites)
for nnode in slist:
    p = Popen('ssh %s sudo echo t0pSecret > /etc/bindpass' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('scp /tmp/ceph.conf %s:/tmp/ceph.conf' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('ssh %s sudo cp /tmp/ceph.conf /etc/ceph/ceph.conf' % nnode, shell=True)
    os.waitpid(p.pid,0)
