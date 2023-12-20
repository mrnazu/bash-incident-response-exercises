#!/bin/bash

# Generate sha256 checksum for httpd.conf
checksum=$(shasum -a 256 /etc/apache2/httpd.conf | awk '{print $1}')

# Read stored checksum from file
stored_checksum=$(cat apache_conf_checksum)

# Compare the two checksums
if [ "$checksum" = "$stored_checksum" ]; then
    echo "Everything is safe. The web server configuration has NOT changed."
else
    echo "Alerting endpoint that the web server configuration has changed"
    # Make a curl request to alert.globo.com with the message in the request body
    curl -X POST -d "The web server configuration has changed." https://alert.globo.com
fi
