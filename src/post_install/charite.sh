#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Charité configuration\n\n"

execute \
    "gsettings set org.gnome.system.proxy mode 'auto'" \
    "Setting proxy"

# Check if PC is laptop or desktop
# Laptops have battery, so this directory will exist
# In desktops, it shouldn't exist
if [ ! -d "/sys/class/power_supply" ]; then
    execute \
        "gsettings set org.gnome.system.proxy.http host 'proxy.charite.de'; \
        gsettings set org.gnome.system.proxy.http port 8080;" \
        "Setting proxy (force Charité address in Gnome config)"
    execute \
        "sudo echo 'http_proxy=http://proxy.charite.de:8080' >> /etc/environment" \
        "Setting proxy (force Charité address in /etc/environment)"
    execute \
        "./htpdate.sh" \
        "Patching Internet time sync with htpdate"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Adding T&S drives\n\n"

cat << EOF | sudo tee -a /etc/fstab
# //servername/sharename                      /media/windowsshare       cifs credentials=/home/UBUNTU_USERNAME/.smbcredentials 0 0
# //REPLACE.charite.de/home$/CHARITE_USERNAME /home/UBUNTU_USERNAME/mnt/charite_t cifs credentials=/home/UBUNTU_USERNAME/.smbcredentials 0 0
# //s-vfs58.charite.de/share$/AG-Volkamer/Daten /home/UBUNTU_USERNAME/mnt/charite_s cifs credentials=/home/UBUNTU_USERNAME/.smbcredentials 0 0
EOF
if [ ! -f "/sys/class/power_supply" ]; then
cat << EOF > ~/.smbcredentials
username=CHARITE_USERNAME
password=YOUR_CHARITEMAIL_PASSWORD
EOF
chmod 600 ~/.smbcredentials
if [ ! -d "$HOME/mnt/charite_s" ]; then
    mkdir -p ~/mnt/charite_{t,s}
fi
fi
print_in_purple "    T and S drive default configurations have been added."
print_in_purple "    Edit your credentials at this file: ~/.smbcredentials"
print_in_purple "    Then, uncomment and fill details to enable access: /etc/fstab"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Installing and patching VMWare Horizon\n\n"

execute "wget https://download3.vmware.com/software/view/viewclients/CART19FQ4/VMware-Horizon-Client-4.10.0-11053294.x64.bundle -O vmware.bundle" \
    "Downloading"
chmod +x vmware.bundle
execute "sudo ./vmware.bundle --console --required" \
    "Installing"
sudo cp /usr/share/applications/vmware-view.desktop /usr/share/applications/vmware-view-proxy.desktop
sudo sed -i 's/Exec=vmware-view/Exec=env http_proxy="" https_proxy="" vmware-view/;s/VMware Horizon Client/No-Proxy VMware Horizon Client/g' \
          /usr/share/applications/vmware-view-proxy.desktop
rm vmware.bundle

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Adding SSH pre-configuration (check ~/.ssh/config.d)\n\n"

cat << EOF > ~/.ssh/config.d/charite
Host bihlogin1
    Hostname med-login1.bihealth.org
    # User rodriguj_c

Host bihlogin
    Hostname med-login2.bihealth.org
    # User rodriguj_c

Host bihtransfer
    Hostname med-transfer1.bihealth.org
    # User rodriguj_c

Host bihtransfer2
    Hostname med-transfer2.bihealth.org
    # User rodriguj_c
EOF
