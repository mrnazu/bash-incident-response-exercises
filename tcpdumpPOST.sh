#!/bin/bash


sudo tcpdump -i eth0 port 80 | grep -i "POST" | grep -Ei "(eval|system|exec|bash|sh|wget|curl)" | awk '{print $8}' >> tcpdumpPOST.txt
