#!/bin/bash -fv
export retv
export Q=`teuthology-lock --brief | sed 's/ .*//'`
retv=false
for i in $Q; do
     if [[ $i == ${1}* ]] ; then
         echo $1
         retv=true
     fi
done
