#!/bin/sh

# create ~/AppImages directory
mkdir ~/AppImages

sudo apt install copyq -y

sudo apt install csvkit -y

# Install Visual Studio Code
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
sudo apt install kdiff3 -y
sudo apt install krename -y
sudo apt install kompare -y
sudo apt install xxdiff -y
sudo apt install krename -y

## Install Dolphin
sudo apt install dolphin -y

## Install Spectacle screenshot utility
sudo apt install kde-spectacle -y

## Install Flameshot
sudo apt install flameshot -y

## Updog web server
## https://github.com/sc0tfree/updog
pip3 install updog

# Install Remmina
sudo apt install remmina -y

# Install Discord
sudo apt install discord -y

# Install Slack
sudo apt install slack -y

# Install VLC
sudo apt install vlc -y

# Install VIM
sudo apt install vim -y

# Install Rhythmbox
sudo apt install rhythmbox -y

# Install OBS
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install ffmpeg obs-studio

# Install htop
sudo apt install htop -y

# Install Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

# Install Obsidian
# Download the latest AppImage
curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -i appimage | grep -v arm \
| grep browser_download \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O ~/AppImages/ObsidianAppImage
chmod +x ~/AppImages/ObsidianAppImage
# Download the .desktop file
wget https://raw.githubusercontent.com/robertstrom/linuxbuild/main/obsidian.desktop -O ~/.local/share/applications/obsidian.desktop


wget -O - https://raw.githubusercontent.com/robertstrom/kali-setup/main/kali-programs-to-install.sh | bash

