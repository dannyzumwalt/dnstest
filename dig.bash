#!/bin/bash 
# use dig to test dns response times from various dns servers 
#
# dz1317@att.com
# 10/08/2020 
# 
# - v1 - initial draft (10/08/2020)
# - v2 - allows try and 1 retry values for each lookup, set timeout to default 5s (10/08/2020)

# check for dig
which dig >/dev/null
if [[ $? -ne 0 ]]; then 
  echo "dig tool not found. Is it installed? Exiting."
fi

dir=`dirname "$0"`

# set # of digs per server to perform (default 1000)
lookups=1000

#set domain you wish to lookup for this test. this domain is not accessed, just resolved by the dns server
domain="time.com"

#array of DNS servers to include in test - you should not need to edit this
source ${dir}/nameservers.bash
#nameArray=(8.8.8.8 1.1.1.1 68.94.156.9 68.94.157.9 68.94.156.8 68.94.157.8)

# do not edit below this line 

i=0
for name in ${nameArray[@]}; do
  i=0
  while [ $i -lt $lookups ]; do
    cooldown=`expr $i % 20`
    [[ $cooldown -eq 0 ]] && echo "nameserver: $name, iteration: $i" && sleep 1
    let "i=i+1"
    #queryopts="+noanswer +retry=1"
    queryopts="+noanswer +tries=1 +retry=0 +time=10"
    dig @$name -4 $domain $queryopts #| grep "Query time: "
  done
done 

# end
