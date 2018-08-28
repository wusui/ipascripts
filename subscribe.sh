#!/bin/bash -fv
if [ -f /tmp/ipasetup/secrets ]; then
    source /tmp/ipasetup/secrets
fi
mynameis=${subscrname:-'inigomontoya'}
mypassis=${subscrpassword:-'youkilledmyfatherpreparetodie'}
mypoolis=${subscrpool:-'8a85f98960dbf6510160df23e3367451'}
sudo yum -y install yaml
myrepolist=`python /tmp/ipasetup/loadrepos.py ${1}`
echo $myrepolist
sudo subscription-manager register --username=${mynameis} --password=${mypassis} --force
sudo subscription-manager attach --pool=${mypoolis}
sudo subscription-manager repos --disable=*
for i in $myrepolist;
do
   echo $i
   sudo subscription-manager repos --enable="$i"
done
sudo yum update -y
sudo reboot
