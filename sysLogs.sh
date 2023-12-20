#!/bin/bash
#
# check the system log for any error or warnings

sudo tail -n 50 /var/log/syslog | grep -iE 'error|warning' >> sysLogs-outpu.txt
