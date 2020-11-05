#!/usr/bin/env bash

if [ ! -s $1 ]; then
  tail=$1
else
  echo "No value given for 'tail'. How many results do you want to output? "
  exit
fi

dir=`dirname "$0"`

source ${dir}/nameservers.bash
sourcename=`cat "${dir}/../source.txt" | head -1 | cut -c1-15` || sourcename=""

for name in ${nameArray[@]}; do  
  ns=`grep "$name," ${dir}/../servers.txt | awk -F, '{print $2}'`
  grep -v nameserver ${dir}/../testResults.csv | grep "$name," | awk -F, -v s="$sourcename" '{ print $1 "," $2 "," $4 "," $5 "," $3 "," $6 "," s }' | sed "s/${name}/${ns}/g" | tail -${tail}
done

