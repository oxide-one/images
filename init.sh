#!/usr/bin/env sh

# Exit on failure
set -e

cp /usr/share/syslinux/efi64/syslinux.efi
cp /usr/share/syslinux/efi64/ldlinux.e64
cp /usr/share/syslinux/lpxelinux.0

# Check the syntax of dnsmasq
dnsmasq --test

# Launch dnsmasq
dnsmasq -d &

# Trap Sigterm n stuff
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

wait