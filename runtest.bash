#!/bin/bash
# 
# wrapper to run the dig.bash script and save to a timestamped file
# 10/14/2020
# dz1317@att.com 
# 
ts=`date "+%y%m%d-%H%M"`
dir=`dirname "$0"`
out="${dir}/results"

of="${out}/digout.${ts}.txt"

source ${dir}/nameservers.bash

echo "outfile: $of"
echo "Nameservers to test: ${nameArray[@]}"

time $dir/dig.bash > $of 

echo "test cycle complete - `date "+%Y-%m-%d %H:%M:%S %Z"` "

. $dir/results.bash "$of"


