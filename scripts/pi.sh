#!/bin/bash

while [ -f /var/run/firstboot.lock ]; do
  sleep 5
done
sudo bash -c "$(curl -sL https://raw.githubusercontent.com/leevanrell/MagicMirror_scripts/master/raspberry.sh)"
