#!/bin/bash
domain=time.com
j=1000
i=0
grep nameserver /etc/resolv.conf

while [ $i -lt $j ]; do 
  let "i=i+1"
  echo -n "$i"
  time nslookup -timeout=10 $domain 
  test=`expr $i % 10`
  [[ $test -eq 0 ]] && sleep 1
done
