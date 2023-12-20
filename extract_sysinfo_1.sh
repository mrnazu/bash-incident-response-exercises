#!/bin/bash

# Set the path to the log file
LOG_FILE="/var/log/syslog"

SYSLOG_FIRST_LINE=$(head -n 1 "$LOG_FILE")
echo $SYSLOG_FIRST_LINE | sed -nE 's/^([^ ]* [^ ]*) .* (\w+\.\w+)/Service: \2, Date: \1/p'
echo "------------------------------------------------------------"
# Extract the hostname
HOSTNAME=$(echo $SYSLOG_FIRST_LINE | awk '{print $4}')

# Extract the kernel version
KERNEL=$(grep -oP "Linux version \S+" $LOG_FILE | awk '{print $3}')

# Extract the CPU model
CPU=$(grep -oP "model name\s+:\s+\K.+" /proc/cpuinfo | head -n1)

# Extract the total memory
MEMORY=$(grep -oP "MemTotal:\s+\K\d+" /proc/meminfo)

# Extract the IP address
IP=$(ip addr show | cut -d " " -f 5,6 | grep -oP "(?<=inet\s)\d+\.\d+\.\d+\.\d+" | head -n1)	

# Print the system information
echo "Hostname: $HOSTNAME"
echo "Kernel version: $KERNEL"
echo "CPU model: $CPU"
echo "Total memory: $MEMORY kB"
echo "IP address: $IP"
