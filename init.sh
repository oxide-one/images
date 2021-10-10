#!/usr/bin/env sh

# Exit on failure
set -e

# Check the syntax of dnsmasq
dnsmasq --test

# Launch dnsmasq
dnsmasq -d