#!/bin/bash

while [ -f /var/run/firstboot.lock ]; do
  sleep 5
done
sudo bash -c "$(curl -sL  https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/raspberry.sh)"
