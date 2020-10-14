#!/bin/bash 
# use dig to test dns response times from various dns servers 
#
# dz1317@att.com
# 10/08/2020 
# 
i=0
j=1000

nameArray=(8.8.8.8 1.1.1.1 68.94.156.9 68.94.157.9 68.94.156.8 68.94.157.8)

for name in ${nameArray[@]}; do
  i=0
  while [ $i -lt $j ]; do
    cooldown=`expr $i % 20`
    [[ $cooldown -eq 0 ]] && echo "nameserver: $name, iteration: $i" && sleep 1
    let "i=i+1"
    queryopts="+tries=1 +retry=0 +time=5 +noanswer"
    dig @$name -4 time.com $queryopts #| grep "Query time: "
  done
done 

# end 
