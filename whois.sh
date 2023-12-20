#!/bin/bash

input_file="netLogs.txt"
output_file="netLogs-whois_results.txt"

while IFS= read -r line; do
  count=$(echo "$line" | awk '{print $1}')
  ip_address=$(echo "$line" | awk '{print $2}')
  
  whois_result=$(whois "$ip_address")
  
  domain=$(echo "$whois_result" | grep -E 'Domain Name|domain:' | head -n 1 | awk '{print $NF}')
  identifying_info=$(echo "$whois_result" | grep -E 'Organization|OrgName|owner:|descr:' | head -n 1 | awk '{$1=""; print $0}')
  
  echo "Connections: $count" >> "$output_file"
  echo "IP Address: $ip_address" >> "$output_file"
  echo "Domain: $domain" >> "$output_file"
  echo "Identifying Info: $identifying_info" >> "$output_file"
  echo >> "$output_file"  # Add an empty line between entries
done < "$input_file"

