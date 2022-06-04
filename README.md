# xPlayerOS
Pop OS 21.10 OneXplayer Install Script

Welcome to the xPlayerOS script created for fun that is tested to be working on Pop OS 21.10.

Install instructions

Place the 3 files in the archive to your desktop and open up the terminal. You may want to use a keyboard/mouse for this part.
Drag and drop the xPlayerOS_Installer-0.2.sh script to the terminal and add lines depending on what you want. It's important to run this from a fresh terminal not navigated to any folders.

Option 1: Add no arguments, this will only install the gamepad and patched Mesa and it's dependencies.

Option 2: Add deckui to the end of the line to install the Steam Deck UI

Option 3: add gamescope to install gamescope

Option 4: add mangohud to install mangohud

Example: '/home/ruineka/Desktop/xPlayerOS_Installer-0.2.sh' deckui gamescope mangohud

This line would install all three options.


The SteamOSUI_ENABLE-v0.2.sh script has an option "exclusive" to attempt to run SteamOS exclusively in gamescope, this causes touchscreen issues for me and I'm not able to interact with my desktop.
I recommend not using the exclusive argument unless you are a tinker who wants to help figure it out.

Notes: This script enabled Wayland which is disabled by default, to start the Wayland session log out and go to the gear on the bottom right of the screen. You should see Pop on Wayland, it's necessary to
get rid of screen tearing for me and Gnome with the current updates seems to lock up at random. If you use the Deck UI then this doesn't concern you and Wayland is the way to go.

By default you'll be on X11 which the only resolution available is 1600x2560, this is an odd bug that I've had to use xrandr to work around, but with the screen tearing I don't bother.

With Wayland you'll want to work around a display bug by going to 800x1280 (The display will be a small box in the corner, and touch navigation will be off so use your keyboard/mouse mode to click confirm and then switch to 900x1440 which will be displayed correctly for the best experience overall. Trying to go to 900x1440 before 800x1280 will result in it saying that the hardware isn't compatible or something.

I've read reports of some users with the OneXPlayer not having screen tearing with X11 so if this is the case I'll add xrandr commands to the install script if it is requested by the community.
