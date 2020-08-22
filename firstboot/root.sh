#!/bin/bash

bash -c "$(curl -sL https://github.com/leevanrell/raspberian-firstboot/raw/master/scripts/root.sh)"
echo "go" >> /var/run/firstboot.lock
