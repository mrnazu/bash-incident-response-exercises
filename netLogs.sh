#!/bin/bash
#

sudo netstat -tn | awk '$6 == "ESTABLISHED" {print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr >> netLogs.txt
