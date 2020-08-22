#!/bin/bash

#set -e

sudo -v

#get dep
sudo apt install golang

# get buster image
BASE_DIR="$(pwd)"
FILE=buster-lite.iso
FILE_IMG=buster-lite.img
CUSTOM_IMG=custom-buster-lite.zip
if ! test -f "$FILE" || ! test -f "$FILE_IMG" ; then
    wget -O $FILE https://downloads.raspberrypi.org/raspbian_lite_latest
	unzip $FILE
	mv *.img $FILE_IMG
fi

#mount image to /mnt
if ! grep -qa /mnt /proc/mounts; then
	go build ./mount_offset_tool/main.go #-o ./mount_offset_tool/run
	mount="$(./main $FILE_IMG)"
	sudo bash -c "$mount"
fi

# set wireless config
read -p "SSID: " SSID
read -p "Password: " KEY
# SSID="TEST"
# KEY="TEST"

# add configs
sed -e "s/SSID/$SSID/g" -e "s/KEY/$KEY/g" ./firstboot/wpa_supplicant.conf > tmp && sudo mv tmp /mnt/boot/wpa_supplicant.conf
sudo cp ./firstboot/firstboot-pi.service /mnt/lib/systemd/system/firstboot-pi.service
sudo cp ./firstboot/firstboot-root.service /mnt/lib/systemd/system/firstboot-root.service
#cd /mnt/etc/systemd/system/multi-user.target.wants && sudo ln -s /lib/systemd/system/firstboot-pi.service . 
#cd /mnt/etc/systemd/system/multi-user.target.wants && sudo ln -s /lib/systemd/system/firstboot-root.service .
sudo ln -s /lib/systemd/system/firstboot-pi.service /mnt/etc/systemd/system/multi-user.target.wants
sudo ln -s /lib/systemd/system/firstboot-root.service /mnt/etc/systemd/system/multi-user.target.wants

#cd $BASE_DIR 
sudo cp ./scripts/pi.sh /mnt/boot/pi.sh
sudo cp ./scripts/root.sh /mnt/boot/root.sh 

#unmount
sudo umount /mnt # broke?

#zip  $CUSTOM_IMG ./$FILE_IMG