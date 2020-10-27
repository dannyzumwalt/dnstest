#!/usr/bin/env bash

if [ ! -s $1 ]; then
  tail=$1
else
  echo "No value given for 'tail'. How many results do you want to output? "
  exit
fi

source ~/dnstest-overlap/scripts/nameservers.bash

for name in ${nameArray[@]}; do  
  ns=`grep "$name," ~/dnstest-overlap/servers.txt | awk -F, '{print $2}'`
  grep -v nameserver ~/dnstest-overlap/testResults.*.csv | grep "$name," | awk -F, '{ print $1 "," $2 "," $4 "," $5 "," $3 }' | sed "s/${name}/${ns}/g" | tail -${tail}
done

