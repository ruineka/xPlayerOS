# xPlayerOS
Pop OS 22.04 LTS OneXplayer Install Script

Welcome to the xPlayerOS script created for fun that is tested to be working on Pop OS 22.04 LTS.

Install instructions

`git clone https://github.com/ruineka/xplayeros.git`\
`cd xplayeros`\
`./xPlayerOS_Installer.sh deckui gamescope`\
The possible parameters for this script are `deckui` `gamescope` and `mangohud`

After rebooting open the terminal with `Super + T`\
\
type in `gamescope -e -f -- steam -gamepadui -steamos3 -steampal -steamdeck`


if you get a bad descriptor error attempt again, for some reason I have issues with this once in a while and with a little play it will eventually work.\
\
if you get a failed update install error I'm not entirely sure what the fix is because it seems to be random, but on a fresh install of Pop 22.04 running my script I rebooted and changed the owner and group to `nobody` and `nogroup` and when I launched steam using the gamescope command above it worked as expected. If anyone has any idea as to the cause of this let me know!\
\
For any error that comes up simply rerunning the `gamescope -e -f -- steam -gamepadui -steamos3 -steampal -steamdeck` command a few times seems to sort things out.

Known issues:\
The touchscreen is input is not flipped to match the display yet\
The SteamOSUI_Enable/Disable scripts need to be updated, I'll get to this later to make a cool transistion similar to how the Steam Deck does it.

What works:\
Switch to Desktop mode\
Steams keyboard with gamepad support, on the Intel OneXplayer (non mini) hold the left orange button for a second and then press X\
Playing games.
