#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • VS Code extensions \n\n"

execute "code --install-extension --force ms-python.python" \
    "Python"
execute "code --install-extension --force meirbon.flatland-monokai-improved" \
    "Flatland Monokai Improved"
execute "code --install-extension --force visualstudioexptteam.vscodeintellicode" \
    "Intellicode"
execute "code --install-extension --force npxms.hide-gitignored" \
    "Hide Gitignored"
execute "code --install-extension --force colinfang.my-nbpreviewer" \
    "NBPreviewer"
execute "code --install-extension --force searking.preview-vscode" \
    "Preview"