#!/bin/sh

sudo apt install copyq -y

sudo apt install csvkit -y

sudo apt update
sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code

## Install progress viewer
sudo apt install pv -y

# Install Geany IDE / Editor
sudo apt install geany -y

# Install Terminator
sudo apt install terminator -y

# Setup fuse group and add user to fuse group for sshfs use
sudo groupadd fuse
sudo usermod -a -G fuse rstrom

# Install sshfs
sudo apt install sshfs -y

sudo apt install krusader -y




wget -O - https://raw.githubusercontent.com/robertstrom/kali-setup/main/kali-programs-to-install.sh | bash

