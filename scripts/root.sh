#!/bin/bash

bash -c "$(curl -sL https://raw.githubusercontent.com/leevanrell/MagicMirror_scripts/master/root.sh)"
echo "go" >> /var/run/firstboot.lock
