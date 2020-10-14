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


echo "outfile: $of"

time $dir/dig.bash > $of 

echo "test complete - `date "+%H:%M"`"

. $dir/results.bash "$of"


