#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

if [[ $(id -u) -ne 0 ]]; then
    echo -e "${RED}Insufficient privileges. Please run this script as the root user or with sudo.${RESET}" >&2
    exit 1
else
    echo -e "${GREEN}You have root privileges. Continuing with the script...${RESET}"
fi

sudo python3 -m http.server 80

