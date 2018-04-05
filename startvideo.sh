#!/bin/bash

# DESCRIPTION
# Loads and eternally plays a series of videos from ~/video/ and/or a usb-drive mounted mnt/usbdisk/ folder, on a Raspberry Pi.

# CREDITS
# Bash script by Tim Schwartz, http://www.timschwartz.org/raspberry-pi-video-looper/ 2013
# Comments, clean up, improvements by Derek DeMoss, for Dark Horse Comics, Inc. 2015
# Added USB support, full path, support files with spaces in names, support more file formats - Tim Schwartz, 2016
# Dynamic use of pi or dietpi default user path depending on platform, edits, simplification because it just wasn't working with a lot of files; now it does. - Alex Hall 2017

# USAGE
# Obtain and install this script via instructions given in rollYourOwn.sh and README.md at: http://s.earthbound.io/piVidSetup


# CODE
# Detect whether main pi user path is pi or dietpi
if [ -d /home/pi ]; then piDir=/home/pi; fi
if [ -d /home/dietpi ]; then piDir=/home/dietpi; fi
# If no such path was detected (if that variable is empty or nonexistent), warn user and abort script.
if [ -z ${piDir+x} ]; then echo no directory \/home\/pi or \/home\/dietpi found\; aborting script.; exit; fi

LOCAL_FILES=$piDir/video # The local folder containing videos to play
USB_FILES=/mnt/usbdisk # Variable for usb mount point
FILE_FORMATS='.mov|.mp4|.mpg'

IFS=$'\n' # Don't split up by spaces, only new lines in for loop
while true
do
	# Step through local files:
	for vidFile in `ls $LOCAL_FILES | grep -E $FILE_FORMATS`
	do
				# echo loading local video file to play\: $LOCAL_FILES/$vidFile
		# Play file:
		echo omxplayer -r -o hdmi $LOCAL_FILES/$vidFile
	done
	# Step through USB files:
	for vidFile in `ls $USB_FILES | grep -E $FILE_FORMATS`
	do
				# echo loading file to play from USB storage\: $USB_FILES/$vidFile
		# Play file:
		omxplayer -r -o hdmi $USB_FILES/$vidFile
	done
done