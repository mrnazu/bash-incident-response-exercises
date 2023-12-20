#!/bin/bash

# Set path to configuration file containing excluded accounts
config_file1="/tmp/predefined_accounts.txt"

# Set path to configuration file containing non-standard system accounts
config_file2="/tmp/predefined_sysaccounts.txt"

# Get list of predefined accounts to exclude (both system and non-standard)
excluded_accounts=$(grep -v '^#' "$config_file1" | tr '\n' '|')

# Get list of non-standard system accounts to exclude
non_standard_system_accounts=$(while read account_name; do
    uid=$(id -u "$account_name" 2>/dev/null)
    if [[ -n $uid ]] && [[ $uid -lt 1000 ]]; then
        echo -n "$account_name|"
    fi
done < "$config_file2")

# Get list of all user accounts, including system accounts
all_accounts=$(cat /etc/passwd)

# Filter out predefined and non-standard accounts from list of all accounts.
non_standard_user_accounts=$(echo "$all_accounts" | \
    awk -F: '{if ( ($3 >= 1000 && $3 != 65534 && $1 !~ /^('$excluded_accounts')$/) || \
    ($3 < 1000 && $1 !~ /^('$non_standard_system_accounts')$/) ) print $1}')

# Print list of non-standard user accounts
echo
echo "Non-standard user and system accounts"
echo "-------------------------------------"
echo "$non_standard_user_accounts"

