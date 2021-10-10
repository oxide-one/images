#!/usr/bin/env sh

# Exit on failure
set -e

# Check for files in directory
if [ -n "$(find /config -prune -empty 2>/dev/null)" ]
then
  echo "No files found in /config! Using default dnsmasq"
  cp /etc/dnsmasq.conf /config
fi

cp /usr/share/syslinux/efi64/syslinux.efi /tftp
cp /usr/share/syslinux/efi64/ldlinux.e64 /tftp
cp /usr/share/syslinux/lpxelinux.0 /tftp

# Check the syntax of dnsmasq
dnsmasq --test

# Launch dnsmasq
dnsmasq -d &

# Trap Sigterm n stuff
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

wait