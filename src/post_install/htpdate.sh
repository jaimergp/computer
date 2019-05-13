#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sudo timedatectl set-ntp false
install_package "htpdate" "htpdate"
echo 'HTP_PROXY="-P proxy.charite.de:8080"' | sudo tee -a /etc/default/htpdate
sudo systemctl start htpdate
sudo systemctl enable htpdate