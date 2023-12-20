#!/bin/bash

# Get the target file path from command-line argument
target_file="$1"

# Get the permissions string for the target file
permissions=$(stat -f "%Sp" "$target_file")

# Read stored permissions from file
stored_permissions=$(cat target_file_permissions.txt)

# Compare the two permissions strings
if [ "$permissions" = "$stored_permissions" ]; then
    echo "Everything is safe. The web server configuration file permissions have NOT changed."
else
    echo "Alerting endpoint that the web server configuration permissions have changed"
    # Make a curl request to alert-permissions.globo.com with the message in the request body
    curl -X POST -d "The web server configuration permissions have changed." https://alert-permissions.globo.com
fi
