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

# Create directory for sshfs mount for QNAP NAS
mkdir -p ~/QNAPMyDocs

export qnap='192.168.0.99'

sshfs rstrom@$qnap: ~/QNAPMyDocs

pushd '/home/rstrom/QNAPMyDocs/My Documents/IRTools/Nmap/v7.92/'

cp ncat_7.92-2_amd64.deb ~/Downloads/
cp nmap_7.92-2_amd64.deb ~/Downloads/
cp nping_0.7.92-2_amd64.deb ~/Downloads/
cp zenmap_7.92-2_all.deb ~/Downloads/

popd

# Install Nmap
# Get this from the QNAP NAS

sudo dpkg -i ~/Downloads/ncat_7.92-2_amd64.deb
sudo dpkg -i ~/Downloads/nmap_7.92-2_amd64.deb
sudo dpkg -i ~/Downloads/nping_0.7.92-2_amd64.deb
sudo dpkg -i ~/Downloads/zenmap_7.92-2_all.deb


# Create a directory for mounting remote SMB shares
mkdir ~/SMBmount

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
# One Liner to Download the Latest Release from Github Repo.md
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -i appimage | grep -v arm \
| grep browser_download \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O ~/AppImages/ObsidianAppImage
chmod +x ~/AppImages/ObsidianAppImage
# Download the .desktop file
wget https://raw.githubusercontent.com/robertstrom/linuxbuild/main/obsidian.desktop -O ~/.local/share/applications/obsidian.desktop

# Install uGet
sudo apt install uget -y

# Install shutter
sudo add-apt-repository -y ppa:shutter/ppa
sudo apt update
sudo apt install shutter -y

# Install Brave Browser
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# Install Typora
# https://support.typora.io/Typora-on-Linux/
# or use
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
# install typora
sudo apt-get install typora -y

# Install 7zip
sudo add-apt-repository universe
sudo apt update
sudo apt install p7zip-full p7zip-rar -y

# Install Calibre
sudo apt install calibre -y

# Install gparted
sudo apt install gparted -y

#Install KeePassXC
sudo apt install keepassxc -y

# Install screen
sudo apt install screen -y

# Install pdftk
sudo apt install pdftk -y

# Install pandoc
suo apt install pandoc -y

# Install peek
# Simple animated GIF screen recorder with GUI
sudo apt install peek -y

# Install neofetch
sudo apt install neofetch -y

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

wget -O - https://raw.githubusercontent.com/robertstrom/kali-setup/main/kali-programs-to-install.sh | bash

