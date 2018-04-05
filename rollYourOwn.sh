#!/bin/bash

# DESCRIPTION
# Transforms a new Raspbian OS (Raspberry Pi Operating System) install into a video kiosk that auto-plays videos from a thumb drive and/or /home/pi/video. Built from commands given at: https://github.com/earthbound19/videolooper-raspbian/blob/master/README.md

# USAGE
# Obtain and use this script via these commands:
# wget s.earthbound.io/piVidSetup
# chmod +x piVidSetup
# ./piVidSetup
# -- and follow the instructions in the comments at the end of the script.
# NOTE
# Here's a test video URL:
# http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4

# Save the current path to return to later as we will cd
pushd .

# Detect whether main pi user path is pi or dietpi
if [ -d /home/pi ]; then piDir=/home/pi; fi
if [ -d /home/dietpi ]; then piDir=/home/dietpi; fi

# CODE
sudo apt-get update
sudo apt-get -y install omxplayer
sudo mkdir -p /mnt/usbdisk
sudo echo "/dev/sda1	/mnt/usbdisk	vfat	ro,nofail	0	0" | sudo tee -a /etc/fstab
mkdir $piDir/video
cd $piDir
wget https://raw.githubusercontent.com/earthbound19/videolooper-raspbian/master/startvideo.sh
chmod uga+rwx startvideo.sh

echo DONE with first part of setup\. See CONTINUED INSTRUCTIONS section in the comments of this script for further instructions.

# CONTINUED INSTRUCTIONS
# EITHER OF THESE STARTUP OPTIONS on runs from cron, which makes keyboard commands to the running omxplayer (e.g. to terminate it) futile. The latter runs before even any login can be done. NOTE that the second will probably require a manual edit of /etc/rc.local to move the command before the return 0 line.
startFilePath=$piDir/.bashrc
# startFilePath="/etc/rc.local"
echo "" >> $startFilePath
echo "$piDir""/startvideo.sh" | tee -a $startFilePath
popd
# AFTER RUNNING THIS SCRIPT, RUN:
# sudo raspi-config (or for preffered dietpi: dietpi-config)
# And select and configure thusly:
# Boot Options -> 
# Select option: B2 Console Autologin
# And:
# Expand Filesystem
