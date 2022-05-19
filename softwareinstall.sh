#!/bin/sh

#Command to execute this script from a terminal
# wget -O - https://raw.githubusercontent.com/robertstrom/linuxbuild/main/softwareinstall.sh | bash

# Setup fuse group and add user to fuse group for sshfs use
sudo groupadd fuse
sudo usermod -a -G fuse rstrom

# create ~/AppImages directory
mkdir ~/AppImages
# Create directory for sshfs mount for QNAP NAS
mkdir -p ~/QNAPMyDocs
# Create a directory for mounting remote SMB shares
mkdir ~/SMBmount

flatpak uninstall com.giuspen.cherrytree -y


# Install Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

sleep 2

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

sleep 2

# Install shutter
sudo add-apt-repository -y ppa:shutter/ppa
sudo apt update
sudo apt install shutter -y

sleep 2

# Install Brave Browser
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

sleep 2

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

sleep 3

sudo apt install -yy gparted htop copyq csvkit exa squashfuse cherrytree pv geany terminator sshfs krusader kdiff3 krename \
kompare xxdiff krename dolphin kde-spectacle flameshot remmina discord slack-desktop vlc vim rhythmbox p7zip-rar p7zip-full uget calibre \
keepassxc screen pdftk pandoc peek neofetch python3-pip

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

## Updog web server
## https://github.com/sc0tfree/updog
pip3 install updog

# Install OBS
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install ffmpeg obs-studio

sleep 3


# Install Wine
# sudo dpkg --add-architecture i386 
# sleep 1
# sudo apt update
# sleep 1
# sudo apt install software-properties-common wget curl
# sleep 1
# wget -nc https://dl.winehq.org/wine-builds/winehq.key
# sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
# sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# sleep 1
# sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'
# sleep 1
# sudo apt update
# sudo apt install --install-recommends winehq-stable

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
 
 sleep 1

sudo dpkg --configure -a

# Install Visual Studio Code
# sudo apt update
sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code -y

# sudo apt install google-chrome-stable -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

sleep 1

sudo apt autoremove --purge


