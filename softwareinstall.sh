#!/bin/sh

# Command to execute this script from a terminal
# wget -O - https://raw.githubusercontent.com/robertstrom/linuxbuild/main/softwareinstall.sh | bash

scriptstarttime=$(date)

# For a VM install - setup shared folder
# See these articles
# https://kb.vmware.com/s/article/60262
# https://docs.vmware.com/en/VMware-Tools/11.2/rn/VMware-Tools-1125-Release-Notes.html#vmware-tools-issues-in-vmware-workstation-or-fusion-known
# Configure shared folder in VMware to point to the folder on the VMware host and leave shared folders enable
# Add this line to the /etc/fstab file
# .host:/    /mnt/hgfs        fuse.vmhgfs-fuse    defaults,allow_other    0    0
# Check if the system is a virtual machine, if so, add this entry to the /etc/fstab file so that shared folders are always available
ps_out=`ps -ef | grep vmtoolsd | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$1")
if [[ "$result" != "" ]];then
    sudo bash -c 'echo ".host:/    /mnt/hgfs        fuse.vmhgfs-fuse    defaults,allow_other    0    0" >> /etc/fstab'
else
    echo "Not Running"
fi

# Turn off LLMNR
activenic=$(nmcli device status | grep -E '\bconnected\b' | awk '{ print $1 }')
sudo resolvectl llmnr $activenic off
sudo sed -i 's/#LLMNR=no/LLMNR=no/' /etc/systemd/resolved.conf

# Add repositories
# Shutter
sudo add-apt-repository -y ppa:shutter/ppa
# Install Typora
# https://support.typora.io/Typora-on-Linux/
# or use
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
# Install OBS repository
sudo add-apt-repository ppa:obsproject/obs-studio
# Install Visual Studio Code repository
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb


# 5/18/2022 - Fix Shutter PPA to fall back to the Ubuntu focal PPA since there is no jammy PPA yet
sudo sed -i 's/jammy/focal/' /etc/apt/sources.list.d/shutter-ubuntu-ppa-jammy.list

sudo apt update && sudo apt upgrade -y
# sudo apt autoremove --purge

# Setup fuse group and add user to fuse group for sshfs use
sudo groupadd fuse
sudo usermod -a -G fuse rstrom

# create ~/AppImages directory
mkdir ~/AppImages
# Create directory for sshfs mount for QNAP NAS
mkdir ~/QNAPMyDocs
# sudo chown rstrom:rstrom ~/QNAPMyDocs
# Create a directory for mounting remote SMB shares
mkdir ~/SMBMount

flatpak uninstall com.giuspen.cherrytree -y

# Install Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

sleep 2

# AppImage update program
# https://github.com/AppImage/AppImageUpdate

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
## ~/AppImages/ObsidianAppImage --appimage-mount
# usr/share/icons/hicolor/512x512/apps/obsidian.png
obsidianpng=$(~/AppImages/ObsidianAppImage --appimage-offset)
sudo mount ~/AppImages/ObsidianAppImage  -o offset=188392 /mnt
cp /mnt/usr/share/icons/hicolor/512x512/apps/obsidian.png ~/AppImages/
sudo umount /mnt

# Peazip Install
# curl -s https://api.github.com/repos/peazip/PeaZip/releases/latest | grep deb
# Install the QT version
# Command to download the deb file
curl -s https://api.github.com/repos/peazip/PeaZip/releases/latest | grep deb | grep -i qt | grep browser_download | cut -d : -f 2,3 | tr -d \" | wget -qi - -O ~/Downloads/peazipQTLinux.deb
sudo dpkg -i ~/Downloads/peazipQTLinux.deb


sudo apt install -yy gpg gnupg2 gparted htop copyq csvkit exa squashfuse cherrytree pv geany terminator sshfs krusader kdiff3 krename \
software-properties-common apt-transport-https kompare xxdiff krename dolphin kde-spectacle flameshot remmina discord vlc vim \
rhythmbox p7zip-rar p7zip-full uget calibre keepassxc screen pdftk pandoc peek neofetch python3-pip ssh shutter brave-browser \
typora ffmpeg obs-studio code zsh thefuck libimage-exiftool-perl catfish doublecmd-common doublecmd-plugins cmatrix okular \
xclip sipcalc breeze-icon-theme deja-dup smbclient cifs-utils xsltproc powershell archivemount safecopy dcfldd dc3dd gnome-tweaks gnome-shell-extensions


# SSH Install
sudo systemctl enable ssh
# Generate ssh keys automatically
ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

export qnap='192.168.0.99'

ssh-copy-id rstrom@qnap

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
 
# Change shell to zsh
# sudo chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh rstrom

sudo dpkg --configure -a

# sudo apt install google-chrome-stable -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

sudo apt update && sudo apt upgrade -y


# Gnome settings
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/configuring-gnome-at-low-level_using-the-desktop-environment-in-rhel-8
# https://askubuntu.com/questions/971067/how-can-i-script-the-settings-made-by-gnome-tweak-tool
# Use the command below to monitor changes made in order to know what settings you need to change
# dconf watch /

gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:' 

gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false

gsettings set org.gnome.desktop.interface show-battery-percentage true

gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 35

gsettings set org.gnome.shell favorite-apps "['pop-cosmic-launcher.desktop', 'pop-cosmic-workspaces.desktop', 'pop-cosmic-applications.desktop', 'geany.desktop', 'firefox.desktop', 'brave-browser.desktop', 'google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.kde.dolphin.desktop', 'org.kde.krusader.desktop', 'org.gnome.Terminal.desktop', 'terminator.desktop', 'io.elementary.appcenter.desktop', 'gnome-control-center.desktop']"

sudo cp /usr/share/app-install/desktop/dolphin:org.kde.dolphin.desktop /usr/share/app-install/desktop/dolphin:org.kde.dolphin.desktop.sav
sudo bash -c 'echo "Icon=/home/rstrom/Pictures/dolphin_file_manager.png" >> /usr/share/app-install/desktop/dolphin:org.kde.dolphin.desktop'

# https://unix.stackexchange.com/questions/367866/how-to-choose-a-response-for-interactive-prompt-during-installation-from-a-shell
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt install wireshark -y
echo "tshark install-setuid boolean true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt install tshark -y

sudo apt autoremove --purge

scriptendtime=$(date)
echo " "
echo "The script started at $scriptstarttime"
echo " "
echo "The script completed at $scriptendtime"
echo " "
echo "The installation and configuration of this new Ubuntu build has completed"
echo "Happy Hacking!"
