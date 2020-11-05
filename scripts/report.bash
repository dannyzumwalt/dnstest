#!/usr/bin/env bash
# 
# report out to csv all results 
# 
mydate=`date +%Y%m%d`

if [ -s $1 ]; then
  infile=$1
else
  echo "No filename given"
  exit
fi
dir=`dirname "$0"`
reportname="testResults.csv"
echo > $reportname

dt=`head -1 $infile`

#array of DNS servers to include in test - you should not need to edit this
source ${dir}/nameservers.bash &> /dev/null
source ${dir}/scripts/nameservers.bash &> /dev/null

for name in ${nameArray[@]}; do
  echo -n "." 
  grep -v Nameservers $infile | grep "$name " | sed "s/  / /g" | sed "s/  / /g" | sed "s/(//g" | awk '{print $1,$2,$4,$6,$8,$16}' | sed "s/ /,/g" | sed "s/\"//g" >> $reportname 
done

#grep -v Nameservers $infile | grep complete > testTimes.txt
grep timeouts $infile | awk '{print $1,$2 }' | uniq > testTimes.txt
echo done
