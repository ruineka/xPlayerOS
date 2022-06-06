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
  The touchscreen input is not flipped to match the display yet. (There is a WIP build for Intel that is currently being installed with this script)\
  The OneXPlayer Intel Mini and AMD mini handhelds haven't been tested so issues are very possible. I don't have these handhelds to test against to make     fixes.\
  The inputs for the keyboard may be bugged\
  The cursor for Intel at least is corrupted, is AMD the same?


What works:\
Switch to Desktop mode\
Steams keyboard with gamepad support, on the Intel OneXplayer (non mini) hold the left orange button for a second and then press X\
Playing games.

Youtube video showing this working: https://www.youtube.com/watch?v=aRANWssBGsM

My goals:

Support for the gyro used in the mini devices\
TDP control for the AMD systems\
Fan control to adjust the speed/noise of the system\
Seemless desktop usage and Steam OS interface experience\
Consistant experience with non-steam applications and game integration

