#!/bin/bash
# 
# wrapper to run the dig.bash script and save to a timestamped file
# 10/14/2020
# dz1317@att.com 
# 
ts=`date "+%y%m%d-%H%M"`
dir=`dirname "$0"`
out="${dir}/results"
scripts=${dir}/scripts

of="${out}/digout.${ts}.txt"

source $scripts/nameservers.bash

echo "outfile: $of"
echo "Nameservers to test: ${nameArray[@]}"

time $scripts/dig.bash > $of 

echo "test cycle complete - `date "+%Y-%m-%d %H:%M:%S %Z"` "

. $scripts/results.bash "$of"
[[ $? -eq 0 ]] || exit

#clean just query time and server name from output file
filebase="${of%.*}"

grep -A1 "Query time:" "$of" | tr '\n' ' ' | tr '-' '\n' | grep Query | sed 's/#/ /g' | awk '{print $4 "," $8}' > ${filebase}_cleaned.csv


