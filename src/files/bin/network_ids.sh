#!/bin/bash

echo "-> Hostname: $(hostname)"
echo "-> Ethernetadresse (MAC address): find the LAN adapter in the output below"
echo ""
lshw -C network 2> /dev/null | grep -v 'WARNING' | grep --color=always -10 -e 'serial: [a-f0-9:]*'



