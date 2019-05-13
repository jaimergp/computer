#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

print_in_purple "\n   Shortcuts\n\n"

execute "gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot \"'<Primary>Print'\"" \
    "Shortcut for area screenshot"
execute "gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip \"'<Primary><Shift>Print'\"" \
    "Shortcut for area screenshot to clipboard"
execute "gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot \"'<Super>Print'\"" \
    "Shortcut for screenshot"
execute "gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip \"'Print'\"" \
    "Shortcut for screenshot to clipboard"

execute "true" "Custom shortcut: reset font scaling"
python3 ../files/bin/gnome_shortcut.py \
    "Reset UI scaling" \
    "bash -c 'gsettings set org.gnome.desktop.interface text-scaling-factor 1.0; gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48'" \
    "<Super>-"
execute "true" "Custom shortcut: 150% font scaling"
python3 ../files/bin/gnome_shortcut.py \
    "Set UI scaling 150%" \
    "bash -c 'gsettings set org.gnome.desktop.interface text-scaling-factor 1.5; gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 72'" \
    "<Super>+"