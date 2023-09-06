#!/bin/bash

while getopts ":i:w:" opt; do
  case $opt in
    i) IP="$OPTARG" ;;
    w) WORDLIST="$OPTARG" ;;
  esac
done
if [ -z "$IP" ] || [ -z "$WORDLIST" ]; then
  echo "Usage: -i 'IP' -w 'wordlist'"
  exit 1
fi

rm -rf creds.txt 2>/dev/null
rm -rf file.zip 2>/dev/null

wget -qO - "$IP:3333" | base64 -d > file.zip
fcrackzip -v -u -D -p "$WORDLIST" file.zip
unzip file.zip
