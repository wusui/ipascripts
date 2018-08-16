#!/bin/bash -fv
if [ -f /tmp/ipasetup/secrets ]; then
    source /tmp/ipasetup/secrets
fi
defaultlist="- -extras- -rh-common- -optional-"
mynameis=${subscrname:-'inigomontoya'}
mypassis=${subscrpassword:-'youkilledmyfatherpreparetodie'}
mypoolis=${subscrpool:-'8a85f98960dbf6510160df23e3367451'}
myrepolist=${subscrlist:-$defaultlist}
echo $mynameis
sudo subscription-manager register --username=${mynameis} --password=${mypassis} --force
sudo subscription-manager attach --pool=${mypoolis}
sudo subscription-manager repos --disable=*
for i in $myrepolist;
do
   sudo subscription-manager repos --enable=rhel-7-server"$i"rpms
done
sudo yum update -y
sudo reboot
