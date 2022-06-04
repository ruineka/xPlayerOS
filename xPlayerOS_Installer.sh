#!/bin/bash
# Description: Pop OS 22.04 helper script for the OneXPlayer devices

cat<<-EOF
=============================================
Pop OS 22.04 OneXplayer helper script for the Steam Deck experience!
=============================================

EOF


#We need to get the dependencies to build the projects
sudo apt install libx11-dev libwayland-dev libxkbcommon-dev cmake meson libxdamage-dev libxrender-dev libxtst-dev libvulkan-dev libxcb-xinput-dev libxcb-composite0-dev libxcb-icccm4-dev libxcb-res0-dev libxcb-util-dev libxcomposite-dev libxxf86vm-dev libxres-dev libdrm-dev wayland-protocols libcap-dev libsdl2-dev libgbm-dev libpixman-1-dev libinput-dev libseat-dev seatd libsystemd-dev glslang-tools software-properties-common steam

### Mangohud
echo "
==================================================
Do you want to install Mangohud/Mangoapp? (y/n)
=================================================="

OPTION=
read -p "" OPTION

if [[ ${OPTION} == "y" ]]; then

echo "Installing Mangohud..." ; sleep 1
sudo add-apt-repository ppa:flexiondotorg/mangohud
sudo apt-get update
sudo apt install mangohud

echo "Getting binaries from the Steamdeck Repo"
cd ~/xplayeros/rootfs

curl -o lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.1/os/x86_64/lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz

tar -xf lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz usr/ 

curl -o mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.1/os/x86_64/mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz

tar -xf mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz usr/ 

#cleaning up
rm mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz
rm lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz



echo "
================================================
Installing mangohud files from Steam Deck repo
================================================"

sudo cp ~/xplayeros/rootfs/usr /usr
fi

echo "
=========================================================================
Do you want to install gamescope for AMD or Intel? (amd/intel)
========================================================================="
read -p "" OPTION

if [[ ${OPTION} == "amd" ]]; then

echo "
=================================================================
Installing gamescope-onexplayer for AMD
================================================================="

cd ~/
git clone -b gamescope-onexplayer https://github.com/ruineka/gamescope-onexplayer.git
cd gamescope-onexplayer
meson build/
ninja -C build/
sudo meson install -C build/ --skip-subprojects
sudo cp /usr/local/bin/gamescope /usr/bin/
cd ..

#Intel currently needs a older version of Gamescope because the git is broken for it.
fi
if [[ ${OPTION} == "intel" ]]; then
	
echo "
=================================================================
Installing gamescope for Intel using gamescope-onexplayer-intel
================================================================="

cd ~/
git clone -b gamescope-onexplayer-intel https://github.com/ruineka/gamescope-onexplayer.git
cd gamescope-onexplayer
meson build/
ninja -C build/
sudo meson install -C build/ --skip-subprojects
sudo cp /usr/local/bin/gamescope /usr/bin/
cd ..

fi
	
#Installing core files for SteamOS 3
echo "
================================================================================
We are now installing the core files necessary for the SteamOS functionality
================================================================================"

sudo rsync -r ~/xplayeros/rootfs/ /

sudo chmod 777 /usr/bin/jupiter-biosupdate
sudo chmod 777 /usr/bin/steamos-update
sudo chmod 777 /usr/bin/steamos-session-select

#Steam needs sudo permissions for some tasks
sudo cp ~/xplayeros/rootfs/etc/sudoers.d/brightness_control /etc/sudoers.d
sudo cp ~/xplayeros/rootfs/etc/sudoers.d/jupiter-biosupdate /etc/sudoers.d
sudo cp ~/xplayeros/rootfs/etc/sudoers.d/steamos-update /etc/sudoers.d

#Experimental SD card support
sudo cp ~/xplayeros/rootfs/etc/systemd/system/sdcard-mount@.service /etc/systemd/system
sudo mkdir /usr/lib/hwsupport
sudo cp ~/xplayeros/rootfs/usr/lib/hwsupport/format-sdcard.sh /usr/lib/hwsupport
sudo cp ~/xplayeros/rootfs/usr/lib/hwsupport/sdcard-mount.sh /usr/lib/hwsupport


#lets grab that beta file causing issues for Steam UI
cp ~/xplayeros/beta ~/.steam/steam/package/beta 



echo "
==================================================
Wayland has been enabled you can now select this 
as an option at the login screen.
=================================================="
#lets enable wayland!
sudo cp ~/xplayeros/rootfs/etc/gdm3/custom.conf /etc/gdm3

#Installing Gamepad
echo "
==================================================
Installing the Gamepad Udev
=================================================="
echo "Installing Gamepad Udev..." ; sleep 1
cp ~/xplayeros/rootfs/etc/udev/rules.d/00-oxpgamepad.rules /etc/udev/rules.d/
sudo curl -o /etc/udev/rules.d/99-oxpgamepad.rules https://pastebin.com/raw/WuB44000

echo "Done!"

zenity --info \
--text="We have finished, we need to reboot"
reboot


