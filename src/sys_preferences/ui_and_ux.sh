#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"

execute "gsettings set org.gnome.libgnomekbd.keyboard layouts \"[ 'es', 'de', 'us' ]\"" \
    "Set keyboard languages"

execute "gsettings set org.gnome.desktop.interface monospace-font-name 'FuraCode Nerd Font Mono 12'" \
    "Change typography"
execute "dconf load /org/gnome/terminal/ < gnome_terminal_settings_backup.ini" \
    "Restore custom terminal settings"

execute "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM" \
    "Taskbar: move to bottom"
execute "gsettings set org.gnome.shell.extensions.dash-to-dock autohide true" \
    "Taskbar: autohide"
execute "gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'cycle-windows'" \
    "Taskbar: cycle windows on click"
execute "gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false" \
    "Taskbar: unfix"
execute "gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48" \
    "Taskbar: icon size"
execute "gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor 1" \
    "Taskbar: preferred monitor"
