# King of the Hill Automated Scripts

<p align="center">
  <img src="koth.png" alt="koth">
</p>

### This repository contains a collection of automated scripts created for the King of the Hill (KOTH) machines on TryHackMe. These scripts are designed for fun and to assist with gameplay on the KOTH machines. The scripts aim to automate certain tasks.

## Disclaimer

### Using these automated scripts in public games may result in bans from the TryHackMe platform..

**Use these scripts at your own risk.**

### I am not liable for any repercussions arising from the utilization of these automated scripts.

## King of the Hill Machines

The scripts in this repository are specifically tailored for the following nine King of the Hill machines on TryHackMe:

1. [Food](https://github.com/H3X-007/KOTH-v2/tree/main/Food)
2. [Fortune](https://github.com/H3X-007/KOTH-v2/tree/main/Fortune)
3. [Panda](https://github.com/H3X-007/KOTH-v2/tree/main/Panda)
4. [Production](https://github.com/H3X-007/KOTH-v2/tree/main/Production)
5. [Lion](https://github.com/H3X-007/KOTH-v2/tree/main/Lion)
6. [Hackers](https://github.com/H3X-007/KOTH-v2/tree/main/Hackers)
7. [Hogwarts](https://github.com/H3X-007/KOTH-v2/tree/main/Hogwarts)
8. [Shrek](https://github.com/H3X-007/KOTH-v2/tree/main/Shrek)
9. [Tyler](https://github.com/H3X-007/KOTH-v2/tree/main/Tyler)

**Note:** If you cannot find the machine credentials or `id_rsa` file, you will need to manually obtain the necessary credentials for the specific machine you are playing then run the automated script.

## Usage

1. Clone the repository:
    
       git clone https://github.com/H3X-007/KOTH-v2.git

2. Change to the KOTH-Scripts directory:
       
       cd KOTH-v2

3. Enable execution privileges for Run-Me-Only1Time :
    
       chmod +x Run-Me-Only1Time.sh
   
4. Run Run-Me-Only1Time:

       ./Run-Me-Only1Time.sh

5. Run Requirements :
    
       sudo ./Requirements.sh 

6. Change to the machine directory :
       
       cd MACHINE-NAME

7. Run the script :
 
       ./Machine-NAME.sh

### Please ensure to set the correct permissions for the `id_rsa` files by using `chmod 600 id_rsa`, and grant execution permission to the scripts using `chmod +x`.

   
#### Before using the automated scripts, make sure to run the `Requirements` script provided in this repository and keep it runing until the koth game ends. 

**Note:** If you are playing on a machine that is not included in the provided list, you can still use the KOTH script by executing the following command on the koth machine:

    ./koth.sh "YOUR VPN IP HERE" "YOUR TRYHACKME USERNAME HERE"

## Contributing

This project encourages collaboration and contributions from other players who enjoy playing King of the Hill on TryHackMe. If you have additional automated scripts for other KOTH machines or if you would like to further develop the existing scripts, your contributions are highly appreciated!

### Happy hacking !
