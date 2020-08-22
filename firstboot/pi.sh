#!/bin/bash

while [ -f /var/run/firstboot.lock ]; do
  sleep 5

wget -O /home/pi/display.py https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/display.py
chmod 777 /home/pi/display.py

crontab -l > mcron 
echo "0 6 * * * /home/pi/scrip.py turnon" >> mcron
echo "0 21 * * * /home/pi/scrip.py turnoff" >> mcron
crontab mcron 
rm mcron 





  
# done
# sudo bash -c "$(curl -sL  https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/raspberry.sh)"
