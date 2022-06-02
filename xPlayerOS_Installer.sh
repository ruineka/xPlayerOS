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


if [[ ${OPTION} != "deckui" ]]; then
zenity --error --text="We are running without the deckui argument, this means we are getting the gamepad driver only\!" --title="Alert\!"
fi

if [[ ${OPTION2} == "gamescope" ]]; then
zenity --error --text="Installing gamescope, touchscreen input will be upside down!" --title="Alert\!"
sudo apt update
git clone https://github.com/ruineka/xplayeros.git
sudo cp ~/xplayeros/jupiter-biosupdate /usr/bin
sudo chmod 777 /usr/bin/jupiter-biosupdate
sudo cp ~/xplayeros/steamos-update /usr/bin
sudo chmod 777 /usr/bin/steamos-update
sudo cp ~/xplayeros/steamos-session-select /usr/bin
sudo chmod 777 /usr/bin/steamos-session-select
sudo apt install libx11-dev libwayland-dev libxkbcommon-dev cmake meson libxdamage-dev libxrender-dev libxtst-dev libvulkan-dev libxcb-xinput-dev libxcb-composite0-dev libxcb-icccm4-dev libxcb-res0-dev libxcb-util-dev libxcomposite-dev libxxf86vm-dev libxres-dev libdrm-dev wayland-protocols libcap-dev libsdl2-dev libgbm-dev libpixman-1-dev libinput-dev libseat-dev seatd libsystemd-dev glslang-tools

git clone -b gamescope-onexplayer-intel https://github.com/ruineka/gamescope-onexplayer.git
cd gamescope-onexplayer
meson build/
ninja -C build/
sudo meson install -C build/ --skip-subprojects
sudo cp /usr/local/bin/gamescope /usr/bin/
cd ..

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

zenity --error --text="Login to steam and enable steamplay for all titles and close the client\!" --title="Alert\!"
steam
#lets grab that beta file causing issues for Steam UI
curl -o ~/.steam/steam/package/beta https://pastebin.com/raw/EZw2QxGf

#Installing Gamepad
sudo curl -o /etc/udev/rules.d/99-oxpgamepad.rules https://pastebin.com/raw/WuB44000

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
