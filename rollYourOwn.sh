# DESCRIPTION
# WORK IN PROGRESS. Debugging on a live Pi . . .
# Transforms a new Raspbian OS (Raspberry Pi Operating System) install into a video kiosk that auto-plays videos from a thumb drive and/or /home/pi/video. Built from commands given at: https://github.com/earthbound19/videolooper-raspbian/blob/master/README.md

# USAGE
# Obtain this script via these commands:
# wget http://s.earthbound.io/piVidSetup
# mv piVidSetup rollYourOwn.sh
# chmod +x ./rollYourOwn.sh
# -- then invoke this script with:
# ./rollYourOwn.sh
# -- and follow the instructions in the comments at the end of the script.

# CODE
sudo apt-get update
sudo apt-get -y install omxplayer
sudo mkdir -p /mnt/usbdisk
sudo echo \"/dev/sda1		/mnt/usbdisk	vfat	ro,nofail	0	0\" | sudo tee -a /etc/fstab
mkdir /home/pi/video
cd /home/pi
wget https://raw.githubusercontent.com/earthbound19/videolooper-raspbian/master/startvideo.sh
chmod uga+rwx startvideo.sh
echo \"/home/pi/startvideo.sh\" | tee -a /home/pi/.bashrc

# AFTER RUNNING THIS SCRIPT, RUN:
# sudo raspi-config
# And select and configure thusly:
# Boot Options -> 
# Select option: B2 Console Autologin
# And:
# Expand Filesystem