#!/bin/bash
# Description: Install/uninstall gamepad UI from Steam Deck

cat<<-EOF
=============================================
Transform your OneXPlayer into a Steam Deck! arguments deckui for Deck UI and gamescope to enable gamescope
=============================================

EOF

OPTION=$1
OPTION2=$2
OPTION3=$3

CLIENT_BETA_CONFIG="${HOME}/.steam/steam/package/beta"
DECK_VER="steampal_stable_9a24a2bf68596b860cb6710d9ea307a76c29a04d"
DECK_CONF="${HOME}/.config/environment.d/deckui.conf"
AMD=$(lspci -v | grep VGA | grep -E 'AMD|ATI')
INTEL=$(lspci -v | grep VGA | grep -E 'INTEL')

# Adjustable
RES_H="1080"
RES_W="1920"

if [[ ${OPTION} != "deckui" ]]; then
zenity --error --text="We are running without the deckui argument, this means we are getting drivers and patched mesa, but not the deck UI\!" --title="Alert\!"
fi

if [[ ${OPTION2} == "gamescope" ]]; then
zenity --error --text="Installing gamescope, this is known to cause touchscreen issues\!" --title="Alert\!"
sudo add-apt-repository ppa:samoilov-lex/gamescope
sudo apt-get update
sudo apt install gamescope
fi

if [[ ${OPTION3} == "mangohud" ]]; then
zenity --error --text="Installing Mangohud\!" --title="Alert\!"
sudo add-apt-repository ppa:flexiondotorg/mangohud
sudo apt-get update
sudo apt install mangohud
fi



#lets enable wayland!
sudo curl -o /etc/gdm3/custom.conf https://pastebin.com/raw/3JhvVX7i
#Some distros don't ship add-repository...so
sudo apt install software-properties-common

#lets get steam
sudo apt update
sudo apt install steam

zenity --error --text="Login to steam and close the client\!" --title="Alert\!"
steam
#lets grab that beta file causing issues for Steam UI
curl -o ~/.steam/steam/package/beta https://pastebin.com/raw/EZw2QxGf

#We are going to begin getting the dependencies to start building the OneXPlayer Steam Deck
sudo add-apt-repository ppa:savoury1/llvm-defaults-13
sudo apt-get update
sudo apt install llvm

# experiment with git version later git clone https://gitlab.freedesktop.org/mesa/mesa.git
curl -o mesa.tar.xz https://archive.mesa3d.org//mesa-21.3.6.tar.xz
tar -xf mesa.tar.xz
cd ~/mesa-21.3.6
curl -o gpufix.patch https://pastebin.com/raw/MBMusWre
patch -p1 < gpufix.patch
sudo apt-get build-dep mesa


#attempt to compile mesa
meson builddir/
ninja -C builddir/
sudo ninja -C builddir/ install
sudo cp ~/mesa-21.3.6/builddir/src/intel/vulkan/intel_icd.x86_64.json /usr/share/vulkan/icd.d

#Installing Gamepad
sudo git clone https://github.com/ruineka/xpad.git /usr/src/xpad-0.4
sudo dkms install -m xpad -v 0.4
sudo curl -o /etc/udev/rules.d/99-oxpgamepad.rules https://pastebin.com/raw/WuB44000
sudo udevadm control --reload-rules && udevadm trigger

if [[ -z ${OPTION} ]]; then
    echo "Script ran without using install argument, Steam Deck UI not installed"
    exit 1
fi

echo -e "${OPTION}ing the Steam Deck EXPERIENCE on your OneXPlayer \n"


if [[ ${CLIENT_BETA_CONFIG} ]]; then
    echo "Backing up existing ${CLIENT_BETA_CONFIG} to ${CLIENT_BETA_CONFIG}.old"
    sudo cp ${CLIENT_BETA_CONFIG} ${CLIENT_BETA_CONFIG}.orig
fi

# "publicbeta" is the original beta config if added previously
if [[ ${OPTION} == "deckui" ]]; then
    sudo bash -c "echo ${DECK_VER} > ${CLIENT_BETA_CONFIG}"
else
    if [[ -f ${CLIENT_BETA_CONFIG}.orig ]]; then
        sudo bash -c "echo publicbeta > ${CLIENT_BETA_CONFIG}"
    else
        rm -f ${CLIENT_BETA_CONFIG}
    fi
fi
zenity --error --text="Looks like we are done, we will now reboot\!" --title="Alert\!"
reboot
echo "Done!"
