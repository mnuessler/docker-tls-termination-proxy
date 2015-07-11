#!/bin/bash

set -e

if [ ! -f "/cert.pem" ]; then
    echo "Certificate file '/cert.pem' not found. Make sure it is mounted as a volume when starting the container."
    exit 1
fi

# Prepare configuration file
config=/etc/pound/pound.cfg

echo "Resolving placeholders in configuration file: $config"

export HTTPS_UPSTREAM_SERVER_PORT=${HTTPS_UPSTREAM_SERVER_PORT:-8080}

perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' $config

# Start pound
exec /usr/sbin/pound \
     -f $config \
     -p /var/run/pound/pound.pid

