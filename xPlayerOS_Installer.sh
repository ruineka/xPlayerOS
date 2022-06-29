#!/bin/bash
# Description: Pop OS 22.04 helper script for the OneXPlayer devices

cat<<-EOF
=============================================
Pop OS 22.04 OneXplayer helper script for the Steam Deck experience!
=============================================

EOF


#We need to get the dependencies to build the projects
sudo apt install libx11-dev libwayland-dev libxkbcommon-dev cmake meson libxdamage-dev libxrender-dev libxtst-dev libvulkan-dev libxcb-xinput-dev libxcb-composite0-dev libxcb-icccm4-dev libxcb-res0-dev libxcb-util-dev libxcomposite-dev libxxf86vm-dev libxres-dev libdrm-dev wayland-protocols libcap-dev libsdl2-dev libgbm-dev libpixman-1-dev libinput-dev libseat-dev seatd libsystemd-dev glslang-tools software-properties-common steam

#A workaround to a custom header being necessary to build the gamescope with proper touch inputs
sudo cp ~/xplayeros/custom_headers/drm_mode.h /usr/include/libdrm

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

echo "Getting binaries from the Steamdeck Repo"
cd ~/xplayeros/rootfs

curl -o lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.1/os/x86_64/lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz

tar -xf lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz usr/ 

curl -o mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.1/os/x86_64/mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz

tar -xf mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz usr/ 

sudo apt install mangohud
#cleaning up
rm mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz
rm lib32-mangohud-0.6.6.1.r113.g316914d-1-x86_64.pkg.tar.xz


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
git clone -b dirty-fix-test https://github.com/ruineka/gamescope-onexplayer.git
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
git clone -b gamescope-onexplayer-touchscreenfix https://github.com/ruineka/gamescope-onexplayer.git
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
sudo chmod 777 /usr/bin/desktop-handler

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

#adding desktop files

cp ~/xplayeros/Switch\ To\ Gamemode.desktop ~/Desktop
gio set ~/Desktop/Switch\ To\ Gamemode.desktop metadata::trusted true
chmod a+x ~/Desktop/Switch\ To\ Gamemode.desktop

cp ~/xplayeros/Launch\ DeckUI.desktop ~/Desktop
gio set ~/Desktop/Launch\ DeckUI.desktop metadata::trusted true
chmod a+x ~/Desktop/Launch\ DeckUI.desktop

echo "
==================================================
Wayland has been enabled you can now select this 
as an option at the login screen.
=================================================="

#lets enable wayland!
sudo cp ~/xplayeros/rootfs/etc/gdm3/custom.conf /etc/gdm3

echo "
==================================================
We are now adding SteamOS session for a pure 
GamepadUI experience without the desktop
=================================================="

#lets enable steamos session
sudo cp ~/xplayeros/gamescope.desktop /usr/share/xsessions/

#fixing network permissions issue for Steam

sudo cp ~/xplayeros/rootfs/etc/polkit-1/localauthority/50-local.d/10-network-manager.pkla /etc/polkit-1/localauthority/50-local.d

#Installing Gamepad
echo "
==================================================
Installing the Gamepad Udev
=================================================="
echo "Installing Gamepad Udev..." ; sleep 1
sudo cp ~/xplayeros/rootfs/etc/udev/rules.d/99-oxpgamepad.rules /etc/udev/rules.d/

echo "
==================================================
Adding HandyHGCCS
=================================================="

git clone -b debian https://github.com/ruineka/HandyGCCS.git
cd HandyGCCS
sudo apt -y install python3
sudo apt -y install pip
pip install evdev
echo "Enabling controller functionality. NEXT users will need to configure the Home button in steam."
sudo cp -v handycon.py /usr/local/bin/
sudo cp -v handycon.service /etc/systemd/system/
sudo cp -v 60-handycon.rules /etc/udev/rules.d/
sudo udevadm control -R
sudo systemctl enable handycon && systemctl start handycon
echo "Installation complete. You should now have additional controller functionality."


echo "Done!"

zenity --info \
--text="We have finished, we need to reboot"
reboot


