# xPlayerOS
Pop OS 22.04 OneXplayer helper script

Welcome to the xPlayerOS script created for fun that is tested to be working on Pop OS 22.04.

Install instructions

`git clone -b xplayeros-testing https://github.com/ruineka/xplayeros.git` \
`cd xplayeros` \
`./xPlayerOS_Installer.sh`

Troubleshooting

After rebooting open the terminal with `Super + T`\
\
type in `gamescope -e -f -- steam -gamepadui -steamos3 -steampal -steamdeck`


if you get a bad descriptor error attempt again, for some reason I have issues with this once in a while and with a little play it will eventually work.\
\
if you get a failed update install error I'm not entirely sure what the fix is because it seems to be random, but on a fresh install of Pop 22.04 running my script I rebooted and changed the owner and group of files `/usr/bin/steamos-update` and `/usr/bin/jupiter-biosupdate` to `nobody` and `nogroup` and when I launched steam using the gamescope command above it worked as expected. If anyone has any idea as to the cause of this let me know!

\
If you press A fast skipping through the configuration settings you'll be able to log in and skip the update failed message, this requires you to first login to steam once in the desktop mode.
\
For any error that comes up simply rerunning the `gamescope -e -f -- steam -gamepadui -steamos3 -steampal -steamdeck` command a few times seems to sort things out.

Known issues:\
  The touchscreen input is not flipped to match the display yet.\
  Initial setup is very buggy, but once you get it to work you'll be fine after.\
  The OneXPlayer Intel Mini and AMD mini handhelds haven't been tested so issues are very possible. I don't have these handhelds to test against to make     fixes.


What works:\
Switch to Desktop mode\
Steams keyboard with gamepad support, on the Intel OneXplayer (non mini) hold the left orange button for a second and then press X\
Playing games.

Youtube video showing this working: https://www.youtube.com/watch?v=aRANWssBGsM
