#!/bin/sh

#Command to execute this script from a terminal
# wget -O - https://raw.githubusercontent.com/robertstrom/linuxbuild/main/softwareinstall.sh | bash

# create ~/AppImages directory
mkdir ~/AppImages

sudo apt install copyq -y

sleep 1

sudo apt install csvkit -y

sleep 1

sudo apt install exa -y

sleep 1

sudo apt install squashfuse -y

sleep 1

flatpak uninstall com.giuspen.cherrytree -y

sleep 1

sudo apt install cherrytree -y

sleep 1

# sudo apt install google-chrome-stable -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

sleep 1

# Install Visual Studio Code
sudo apt update
sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code -y

sleep 1

## Install progress viewer
sudo apt install pv -y

sleep 1

# Install Geany IDE / Editor
sudo apt install geany -y

sleep 1

# Install Terminator
sudo apt install terminator -y

sleep 1

# Setup fuse group and add user to fuse group for sshfs use
sudo groupadd fuse
sudo usermod -a -G fuse rstrom

# Install sshfs
sudo apt install sshfs -y

sleep 1

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

sleep 1

# Create a directory for mounting remote SMB shares
mkdir ~/SMBmount

sudo apt install krusader -y
sudo apt install kdiff3 -y
sudo apt install krename -y
sudo apt install kompare -y
sudo apt install xxdiff -y
sudo apt install krename -y

sleep 1

## Install Dolphin
sudo apt install dolphin -y

sleep 1

## Install Spectacle screenshot utility
sudo apt install kde-spectacle -y

sleep 1

## Install Flameshot
sudo apt install flameshot -y

sleep 1

## Updog web server
## https://github.com/sc0tfree/updog
pip3 install updog

sleep 1

# Install Remmina
sudo apt install remmina -y

sleep 1

# Install Discord
sudo apt install discord -y

sleep 1

# Install Slack
sudo apt install slack -y

sleep 1

# Install VLC
sudo apt install vlc -y

sleep 1

# Install VIM
sudo apt install vim -y

sleep 1

# Install Rhythmbox
sudo apt install rhythmbox -y

sleep 1

# Install OBS
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install ffmpeg obs-studio

sleep 1

# Install 7zip
sudo add-apt-repository universe
sudo apt update
sudo apt install p7zip-full p7zip-rar -y

sleep 1

# Install htop
sudo apt install htop -y

sleep 1

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
# wget https://raw.githubusercontent.com/robertstrom/linuxbuild/main/obsidian.desktop -O ~/.local/share/applications/obsidian.desktop
## ~/AppImages/ObsidianAppImage --appimage-mount
# usr/share/icons/hicolor/512x512/apps/obsidian.png
obsidianpng=$(~/AppImages/ObsidianAppImage --appimage-offset)
sudo mount ~/AppImages/ObsidianAppImage  -o offset=188392 /mnt
cp /mnt/usr/share/icons/hicolor/512x512/apps/obsidian.png ~/AppImages/
sudo umount /mnt

sleep 1

# Install uGet
sudo apt install uget -y

sleep 1

# Install shutter
sudo add-apt-repository -y ppa:shutter/ppa
sudo apt update
sudo apt install shutter -y

sleep 1

# Install Brave Browser
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

sleep 1

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

sleep 1

# Install Calibre
sudo apt install calibre -y

sleep 1

# Install gparted
sudo apt install gparted -y

sleep 1

#Install KeePassXC
sudo apt install keepassxc -y

sleep 1

# Install screen
sudo apt install screen -y

sleep 1

# Install pdftk
sudo apt install pdftk -y

sleep 1

# Install pandoc
sudo apt install pandoc -y

sleep 1

# Install peek
# Simple animated GIF screen recorder with GUI
sudo apt install peek -y

sleep 1

# Install neofetch
sudo apt install neofetch -y

sleep 1

# Install Wine
sudo dpkg --add-architecture i386 
sleep 1
sudo apt update
sleep 1
sudo apt install software-properties-common wget curl
sleep 1
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sleep 1
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'
sleep 1
sudo apt update
sudo apt install --install-recommends winehq-stable

sleep 1

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zsh_profile.sav
# Download custom .zshrc file from personal GitHub
wget https://raw.githubusercontent.com/robertstrom/oh-my-zsh/main/zshrc-file_dell_xps_15 -O ~/.zshrc

# Install exa-zsh plugin
 cd ~/.oh-my-zsh/custom/plugins
 git clone https://github.com/MohamedElashri/exa-zsh
 cd -


wget -O - https://raw.githubusercontent.com/robertstrom/kali-setup/main/kali-programs-to-install.sh | bash

