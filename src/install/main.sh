#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Update installed packages\n\n"

update
upgrade

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installing new packages\n\n"
print_in_purple "\n   Build Essentials\n\n"
# Install tools for compiling/building software from source.
install_package "Build Essential" "build-essential"
# GnuPG archive keys of the Debian archive.
install_package "GnuPG archive keys" "debian-archive-keyring"
install_package "Curl" "curl"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development\n\n"

install_package "Git" "git"

if ! cmd_exists "conda" || [ ! -e "/opt/miniconda" ]; then
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
        || print_error "Miniconda (download)"
    execute "sudo bash Miniconda3-latest-Linux-x86_64.sh -bup /opt/miniconda" "Miniconda" \
        || print_error "Miniconda (installation)"
    rm Miniconda3-latest-Linux-x86_64.sh \
        || print_error "Miniconda (cleanup)"
fi

if ! package_is_installed "code"; then
    add_key "https://packages.microsoft.com/keys/microsoft.asc" \
        || print_error "VSCode (add key)"
    add_to_source_list "[arch=amd64] https://packages.microsoft.com/repos/vscode stable main" "code.list" \
        || print_error "VSCode (add to package resource list)"
    update &> /dev/null \
        || print_error "VSCode (resync package index files)"
fi
install_package "VSCode" "code"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Shell\n\n"
install_package "Fish" "fish"
execute "curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish" \
    "Fish: fisher"
execute "fish -c 'fisher add oh-my-fish/theme-bobthefish'" \
    "Fish: bobthefish theme"

install_package "SSH server" "openssh-server"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Browsers\n\n"
if ! package_is_installed "google-chrome-stable"; then
    add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        || print_error "Chrome (add key)"
    add_to_source_list "[arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" "google-chrome.list" \
        || print_error "Chrome (add to package resource list)"
    update &> /dev/null \
        || print_error "Chrome (resync package index files)"
fi
install_package "Chrome" "google-chrome-stable"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Image Tools\n\n"
install_package "GIMP" "gimp"
install_package "InkScape" "inkscape"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous Tools\n\n"
install_package "cURL" "curl"
install_package "ShellCheck" "shellcheck"
install_package "xclip" "xclip"
install_package "Screen" "screen"
install_package "htop" "htop"
install_package "Gnome Tweaks" "gnome-tweak-tool"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Fonts\n\n"
declare -a FONT_FAMILIES=(
    "DroidSansMono"
    "FiraCode"
    "FiraMono"
    "RobotoMono"
    "SourceCodePro"
    "UbuntuMono"
)
for fontfamily in "${FONT_FAMILIES[@]}"; do
    execute "wget -q \"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/${fontfamily}.zip\" -O \"${fontfamily}.zip\"" \
        "Font ${fontfamily} (Download)"
    execute "sudo unzip -qq \"${fontfamily}.zip\" -d /usr/share/fonts/" \
        "Font ${fontfamily} (Install)"
    rm "${fontfamily}.zip" \
        || print_error "Font ${fontfamily} (Cleanup)"
done
execute 'cd /usr/share/fonts/ && sudo rm *Nerd*Windows\ Compatible* Fura*Nerd*.otf' \
    "Clean duplicate fonts"
execute "fc-cache -f -v" \
     "Font cache rebuild"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Optional packages\n\n"

for installer in _*.sh; do
    title=${installer:1:-3^}
    ask_for_confirmation "Do you want to install ${title^}?"
        if answer_is_yes; then
            chmod +x "${installer}"
            execute "./${installer}" \
                "${title^}"
        fi
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Cleanup\n\n"
autoremove
