#!/bin/bash

# Use PowerShell to get system information
HOSTNAME=$(powershell -Command "(Get-WmiObject Win32_ComputerSystem).Name")
KERNEL=$(powershell -Command "(Get-WmiObject Win32_OperatingSystem).Version")
CPU=$(powershell -Command "(Get-WmiObject Win32_Processor).Name")
MEMORY=$(powershell -Command "(Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB")
IP=$(powershell -Command "(Get-NetIPAddress | Where-Object {$_.InterfaceAlias -Eq 'Ethernet' -And $_.AddressFamily -Eq 'IPv4'}).IPAddress")

# Print the system information
echo "Hostname: $HOSTNAME"
echo "Kernel version: $KERNEL"
echo "CPU model: $CPU"
echo "Total memory: $MEMORY GB"
echo "IP address: $IP"
