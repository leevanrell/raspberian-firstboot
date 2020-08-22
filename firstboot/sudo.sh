#!/bin/bash

#bash -c "$(curl -sL https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/root.sh)"

apt update -y && apt upgrade -y

wget -O /home/pi/display.py https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/display.py
chmod +x /home/pi/display.py

crontab -l > mcron 
echo "0 6 * * * /home/pi/display.py turnon" >> mcron
echo "0 21 * * * /home/pi/display.py turnoff" >> mcron
crontab mcron 
rm mcron 


#https://askubuntu.com/questions/868750/installing-gnome-desktop-lightdm-without-selecting
DEBIAN_FRONTEND=noninteractive apt install -y xinit xserver-xorg lxde-core lightdm git libxss1 libnss3 unclutter chromium-browser
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
echo "set shared/default-x-display-manager lightdm" | debconf-communicate

#change hostname
NEW_NAME="Mirror"
echo $NEW_NAME > /etc/hostname
sed -i "s/raspberrypi/$NEW_NAME/g" /etc/hosts
hostname $NEW_NAME

#TODO: desktop-> desktop-autologin https://github.com/MichMich/MagicMirror/wiki/jessie-lite-installation-guide

#setup screen
echo "" > /etc/xdg/lxsession/LXDE/autostart
echo "@xset s off" >> /etc/xdg/lxsession/LXDE/autostart
echo "@xset -dpms" >> /etc/xdg/lxsession/LXDE/autostart
echo "@xset s noblank" >> /etc/xdg/lxsession/LXDE/autostart
echo "@chromium-browser --kiosk http://192.168.1.13:8081" >> /etc/xdg/lxsession/LXDE/autostart
echo "@unclutter -idle 0" >> /etc/xdg/lxsession/LXDE/autostart
echo "lcd_rotate=2" >> /boot/config.txt
echo "display_splash=1" >> /boot/config.txt

#mmpm setup
sudo apt install nginx-full -y
pip3 install --upgrade --no-cache-dir mmpm


echo "go" >> /var/run/firstboot.lock
