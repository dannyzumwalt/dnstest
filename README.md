# dnstest

Perform DNS lookups, using BIND DIG tool, and measure performance in terms of number of connection timeouts. 

## prereqs

Assumes running from bash environment (linux, macos, etc)
BIND Dig must be installed. Does not check for install prior to running, but is included in a typical linux/macos install

## setup

Set name servers to test in the ./nameservers.bash file (bash array)
Set domain to lookup in dig.bash file (Default: time.com)
Set lookup count in dig.bash file (Default: 1000)

## run 

Run with ./runtest.bash script. 
This script is a wrapper that will kick of dig.bash and output to a timestamped log file. 
After all lookup tests are done to each defined name server, the results.bash script is run to summarize the results. 

## sample output
```
$ ./runtest.bash
outfile: ./results/digout.201014-1151.txt
test cycle complete - 2020-10-14 11:59:23 CDT
8.8.8.8 -   0 timeouts (0.00% failure rate) - [ 1000 cycles ]
    1.1.1.1 -   0 timeouts (0.00% failure rate) - [ 1000 cycles ]
68.94.156.9 -   3 timeouts (0.30% failure rate) - [ 1000 cycles ]
68.94.157.9 -   0 timeouts (0.00% failure rate) - [ 1000 cycles ]
68.94.156.8 -   0 timeouts (0.00% failure rate) - [ 1000 cycles ]
68.94.157.8 -   0 timeouts (0.00% failure rate) - [ 1000 cycles ]
```
