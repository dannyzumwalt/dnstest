#!/usr/bin/env bash 
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
progress=FALSE

[[ $1 == "-v" ]] && progress=TRUE

source $scripts/nameservers.bash &> /dev/null
source $scripts/scripts/nameservers.bash &> /dev/null

[[ $progress = "TRUE" ]] && clear

echo "outfile: $of"
echo "Nameservers to test: ${nameArray[@]}"

. $scripts/dig.bash > $of 

# check progress
complete=0
while [ $complete -lt ${#nameArray[@]} ]; do
  sleep 5
  complete=`grep "Lookups Complete" "$of" | wc -l`
  [[ $progress = "TRUE" ]] && clear && echo "outfile: $of" && echo "Nameservers to test: ${nameArray[@]}"
  [[ $progress = "TRUE" ]] && . $scripts/results.bash "$of" 
  [[ $progress = "TRUE" ]] && echo "completed: [ $complete / ${#nameArray[@]} ]"
done

[[ $progress = "FALSE" ]] && . $scripts/results.bash "$of"
[[ $? -eq 0 ]] || exit

#clean just query time and server name from output file
filebase="${of%.*}"

grep -A1 "Query time:" "$of" | tr '\n' ' ' | tr '-' '\n' | grep Query | sed 's/#/ /g' | awk '{print $4 "," $8}' > ${filebase}_cleaned.csv

echo "All test batches complete - `date "+%Y-%m-%d %H:%M:%S %Z"` "
echo "Result file: $of"
echo "Cleaned result file: ${filebase}_cleaned.csv"
