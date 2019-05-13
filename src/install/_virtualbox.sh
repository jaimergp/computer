#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sudo add-apt-repository multiverse && sudo apt-get update
install_package "VirtualBox" "virtualbox"
install_package "VirtualBox Extension Pack" "virtualbox-ext-pack"