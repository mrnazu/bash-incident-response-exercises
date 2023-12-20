#!/bin/bash

sudo netstat -anp | grep -i "established" | awk {'print $5'} | cut -d: -f1 | sort | uniq -c | sort -nr >> netstat.txt
