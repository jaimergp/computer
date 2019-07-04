#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! on_wsl; then
./privacy.sh
./ui_and_ux.sh
./shortcuts.sh
fi