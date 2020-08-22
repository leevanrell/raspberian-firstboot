#!/bin/bash

apt update -y && apt upgrade -y

#https://askubuntu.com/questions/868750/installing-gnome-desktop-lightdm-without-selecting
DEBIAN_FRONTEND=noninteractive apt install xinit xserver-xorg lxde-core lightdm git libxss1 libnss3 unclutter chromium-browser
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
echo "set shared/default-x-display-manager lightdm" | debconf-communicate

#change hostname
NEW_NAME="Mirror"
echo $NEW_NAME > /etc/hostname
sed -i "s/raspberrypi/$NEW_NAME/g" /etc/hosts
hostname $NEW_NAME

#TODO: desktop-> desktop-autologin https://github.com/MichMich/MagicMirror/wiki/jessie-lite-installation-guide

#setup screen
echo "@xset s off" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@xset -dpms" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@xset s noblank" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@chromium-browser --kiosk http://192.168.1.13:8081" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@unclutter -idle 0" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "lcd_rotate=2" >> /boot/config.txt
echo "display_splash=1" >> /boot/config.txt