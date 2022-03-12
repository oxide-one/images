#!/usr/bin/env sh

# Exit on failure
set -e

# Check for the pxelinux-cfg environment variable
if [[ -z "${PXELINUX_CFG_DIR}" ]]; then
  echo "$0: PXELINUX_CFG_DIR not set or does not exist. continuing"
else
  echo "$0: PXELINUX_CFG_DIR set, value: \"$PXELINUX_CFG_DIR\""
  ln -sfn $PXELINUX_CFG_DIR /usr/share/syslinux/pxelinux.cfg
  
fi


# Check the syntax of dnsmasq
dnsmasq --test

# Launch dnsmasq
dnsmasq -d $@
