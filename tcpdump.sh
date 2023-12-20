#!/bin/bash
#
 sudo tcpdump -i eth0 port 80 -A | grep -i "cmd=dir" >> tcpdump.log
