#!/bin/bash

# Set path to configuration file
config_file="/tmp/predefined_accounts.txt"

# Get list of predefined accounts to exclude
excluded_accounts=$(grep -v '^#' "$config_file" | tr '\n' '|')

# Get list of all user accounts
all_accounts=$(cat /etc/passwd)

# Filter out predefined accounts from list of all accounts
non_standard_accounts=$(echo "$all_accounts" | \
    awk -F: '{if ($3 >= 1000 && $3 != 65534 && $1 !~ /^('$excluded_accounts')$/) print $1}')

# Print list of non-standard accounts
echo "Non-standard user accounts:"
echo "$non_standard_accounts"

