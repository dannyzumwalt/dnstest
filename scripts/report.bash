#!/bin/bash
# 
# report out to csv all results 
# 
mydate=`date +%Y%m%d`

reportname="testResults.${mydate}.csv"
echo > $reportname

for name in 1.1.1.1 8.8.8.8 68.94.156.9 68.94.157.9 68.94.156.8 68.94.157.8; do
  grep -v Nameservers ~/dnsTestingOutput-noRetry.log | grep $name | sed "s/  / /g" | sed "s/  / /g" | sed "s/(//g" | awk '{print $1,$3,$5}' | sed "s/ /,/g" >> $reportname 
done
grep -v Nameservers ~/dnsTestingOutput-noRetry.log | grep complete > testTimes.txt

