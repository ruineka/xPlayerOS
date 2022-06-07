# xPlayerOS
Pop OS 22.04 OneXplayer helper script

Welcome to the xPlayerOS script created for fun that is tested to be working on Pop OS 22.04.

Install instructions

`git clone https://github.com/ruineka/xplayeros.git` \
`cd xplayeros` \
`./xPlayerOS_Installer.sh`

Open up Switch To Gamemode a total of 3 times to get it fully configured.

The first time you'll see the desktop update screen.\
The second you'll see the SteamOS update interface\
The third time it'll finish up and open the Deck UI


Known issues:\
  The touchscreen acts like a trackpad instead of a proper touch input\
  It appears as though all the OneXplayers are now usable, this needs further testing..expect issues.\
  The inputs for the keyboard may be bugged\
  The cursor for Intel at least is corrupted, is AMD the same?


What works:\
Switch to Desktop mode\
Steams keyboard with gamepad support, on the Intel OneXplayer (non mini) hold the left orange button for a second and then press X\
Playing games.

Youtube video showing this working: https://www.youtube.com/watch?v=aRANWssBGsM

Recommended Pop configurations:\
Disable automatic resume, screen lock, dim, and blank screen.\
Enable autologin\
Go to "Start up Applications" and add a new command to automatically boot steam: Command: `gamescope -e -f --xwayland-count 2 -- steam -gamepadui -steamos3 -steampal -steamdeck` \
Enjoy the handheld experience!

My goals:

Support for the gyro used in the mini devices\
TDP control for the AMD systems\
Fan control to adjust the speed/noise of the system\
Seemless desktop usage and Steam OS interface experience\
Consistant experience with non-steam applications and game integration

