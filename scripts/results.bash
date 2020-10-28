#!/usr/bin/env bash
# get dns dig results and format.
 
# dz1317@att.com
# 10/08/2020
 
dir=`dirname "$0"`

if [[ $1 == "" ]]; then
  echo "USAGE: Enter file name to prepare results for (outfile from your dig test)"
  echo "example: ./results.bash my_out_file"
  echo
  exit
else
  file=$1
fi
 
#array of DNS servers to include in test - you should not need to edit this
source ${dir}/nameservers.bash &> /dev/null
source ${dir}/scripts/nameservers.bash &> /dev/null

mydt=`date "+%D"`
mytm=`date "+%T"`
dt=`head -1 $file`

for name in ${nameArray[@]}; do
  cycles=`grep ">> @${name} " $file | wc -l`
  [[ $cycles -eq 0 ]] && exit 
  #[[ $cycles -eq 0 ]] && echo " ... no cycles found. Still running? " && exit
  timeouts=`grep -B 3 "connection timed out" $file | grep "${name} " | wc -l`
  p=`echo "scale=2; 100 * $timeouts / $cycles" | bc`
  ns=`grep -B3 "SERVER: ${name}#" $file | grep localhost | awk '{print $5}' | uniq -c | head -1`
  printf "%17s - %13s - %3d timeouts (%.2f%% timeout rate) - [ %4d cycles %s ]\n" "$dt" $name $timeouts $p $cycles "- $ns"
done
 
