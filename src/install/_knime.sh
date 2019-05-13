#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "wget https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz -O knime.tar.gz" \
    "KNIME (download)"
execute "sudo tar xf knime.tar.gz -C /opt" \
    "KNIME (extract)"
knime_install_path=$(find /opt -maxdepth 1 -type d -name 'knime*')
knime_version=${knime_install_path:6}
sudo ln -s "${knime_install_path}/knime" "/usr/local/bin/knime" \
    || print_error "KNIME (symlink)"


cat << EOF | sudo tee "/usr/share/applications/KNIME.desktop" > /dev/null
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=KNIME ${knime_version}
Comment=A sample application
Exec=knime
Icon="${knime_install_path}/icon.xpm
Terminal=false
EOF
