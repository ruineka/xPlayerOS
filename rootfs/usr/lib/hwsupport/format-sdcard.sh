#!/bin/bash

if [[ -e /dev/mmcblk0 ]]
then
   systemctl stop sdcard-mount@mmcblk0p1.service
   parted --script /dev/mmcblk0 mklabel gpt mkpart primary 0% 100%
   sync
   mkfs.ext4 -O casefold -F /dev/mmcblk0p1
   sync
   systemctl start sdcard-mount@mmcblk0p1.service
   exit 0
fi

exit 1
