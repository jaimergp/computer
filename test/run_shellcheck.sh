#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # ' At first you're like "shellcheck is awesome" but then you're
    #   like "wtf are we still using bash" '.
    #
    #  (from: https://twitter.com/astarasikov/status/568825996532707330)

    find \
        ../test \
        ../src/ \
        ../src/files/bash \
        ../src/install \
        ../src/post_install \
        ../src/pre_install \
        -type f \
        \( -name '*.sh' \
        -or -name 'bash*' \) \
        -exec shellcheck \
                -e SC1090 \
                -e SC1091 \
                -e SC1117 \
                -e SC2155 \
                -e SC2164 \
        {} +

    print_result $? "Run code through ShellCheck"

}

main
