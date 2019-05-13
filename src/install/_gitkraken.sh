#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "wget https://release.gitkraken.com/linux/gitkraken-amd64.deb -O gitkraken.deb" \
    "GitKraken (download)"
package_install "GitKraken" "./gitkraken.deb"
rm gitkraken.deb \
    || print_error "GitKraken (cleanup)"