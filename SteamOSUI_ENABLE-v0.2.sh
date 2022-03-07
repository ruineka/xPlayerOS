#!/bin/bash
# Description: Install/uninstall gamepad UI from Steam Deck

cat<<-EOF
=============================================
Enable SteamOS on Boot, add launch argument exclusive for fullscreen exclusive mode
=============================================

EOF

OPTION=$1

if [[ ${OPTION} == "exclusive" ]]; then
zenity --error --text="We are enabling exclusive steamos mode, desktop navigation may be impossible, user beware\!" --title="Alert\!"
sudo curl -o /usr/share/applications/steam.desktop https://pastebin.com/raw/YvCpVwUv
mkdir ~/.config/autostart
sudo cp /usr/share/applications/steam.desktop ~/.config/autostart/steam.desktop
else

sudo curl -o /usr/share/applications/steam.desktop https://pastebin.com/raw/qCkp304b
mkdir ~/.config/autostart
sudo cp /usr/share/applications/steam.desktop ~/.config/autostart/steam.desktop

fi

zenity --error --text="Rebooting\!" --title="Alert\!"
reboot
echo "Done! relaunch steam for changes to take effect"
