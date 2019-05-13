#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directories() {

    declare -a DIRECTORIES=(
        "$HOME/devel"
        "$HOME/devel/go"
        "$HOME/devel/js"
        "$HOME/devel/py"
        "$HOME/outreach"
        "$HOME/mnt"
        "$HOME/prj"
        "$HOME/tmp"
        "$HOME/www"

        "$HOME/.config/Code/User"
        "$HOME/.config/fish/functions"
        "$HOME/.local/bin"
        "$HOME/.ssh"

    )

    for i in "${DIRECTORIES[@]}"; do
        mkdir -p "$i"
    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n • Create directories\n\n"
    create_directories
}

main
