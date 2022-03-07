#!/bin/bash
# Description: Install/uninstall gamepad UI from Steam Deck

cat<<-EOF
=============================================
Disable SteamOS on Boot
=============================================

EOF

OPTION=$1

sudo curl -o /usr/share/applications/steam.desktop https://pastebin.com/raw/VrA6n7Au
mkdir ~/.config/autostart
sudo cp /usr/share/applications/steam.desktop ~/.config/autostart/steam.desktop
zenity --error --text="Rebooting\!" --title="Alert\!"
reboot
echo "Done! relaunch steam for changes to take effect"
