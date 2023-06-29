#!/bin/bash
# Create /dev/ppp device node
if [ ! -c /dev/ppp ]; then
  mknod /dev/ppp c 108 0
fi

# Execute the SSLVPN CLI command
/forticlientsslvpn/64bit/forticlientsslvpn_cli "$@"

