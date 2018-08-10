#!/bin/python
import json
import os
from subprocess import Popen

with open('/tmp/nodes.json') as x:
    cnodes = json.loads(x.read())
sites = set()
for mtype in cnodes:
    for isite in cnodes[mtype]:
        noden = isite.split('.')[0]
        sites.add(noden)
slist = list(sites)
with open('/tmp/bindpass', 'w') as x:
    x.write('t0pSecret')
for nnode in slist:
    p = Popen('scp /tmp/bindpass %s:/tmp/bindpass' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('ssh %s sudo cp /tmp/bindpass /etc/bindpass' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('ssh %s sudo chown root:root /etc/bindpass' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('ssh %s sudo chmod 0600 /etc/bindpass' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('scp /tmp/ceph.conf %s:/tmp/ceph.conf' % nnode, shell=True)
    os.waitpid(p.pid,0)
    p = Popen('ssh %s sudo cp /tmp/ceph.conf /etc/ceph/ceph.conf' % nnode, shell=True)
    os.waitpid(p.pid,0)
