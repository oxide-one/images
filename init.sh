#!/usr/bin/env sh

# Exit on failure
set -e

# Check for files in directory
if [ -n "$(find /config -prune -empty 2>/dev/null)" ]
then
  echo "No files found in /config! Using default dnsmasq"
  cp /etc/dnsmasq.conf /config
fi


# Check the syntax of dnsmasq
dnsmasq --test

# Launch dnsmasq
dnsmasq -d --log-dhcp --log-debug -7 /config --dhcp-leasefile /data/dnsmasq.lease &

# Trap Sigterm n stuff
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

wait