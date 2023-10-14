#!/bin/bash

# PKG LIST
PKG=("htop" "nvtop" "openvpn" "net-tools" "firefox-esr" "make" "vim" "neovim" "burpsuite" "nmap" "maltego" "metasploit-framework" "tor" "i2pd" "proxychains")




#ADD KALI REPO
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com ED444FF07D8D0BF6 
sudo apt-get update -y



# INSTALL BASE
for package in "${PKG[@]}"
do
    # Check if the package is already installed
    if dpkg -l | grep -q "$package"; then
        echo "$package is already installed."
    else
        # Install the package if it's not installed
        sudo apt-get install -y "$package"
        if [ $? -eq 0 ]; then
            echo "Successfully installed $package."
        else
            echo "Failed to install $package."
        fi
    fi
done









##UPGRADE AND FINISH
sudo apt-get update -y
sudo apt-get upgrade -y
