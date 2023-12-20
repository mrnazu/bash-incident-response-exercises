#!/bin/bash
# Get installed software and versions
installed_software=$(dpkg-query -l)
echo "Installed software and versions:"
echo "$installed_software"

# Get user accounts and privileges
user_accounts=$(cat /etc/passwd)
echo "User accounts and privileges:"
echo "$user_accounts"

# Get network configuration
network_config=$(ifconfig)
echo "Network configuration:"
echo "$network_config"