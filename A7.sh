#!/bin/bash

#Script by Ben Cordeiro, Made for CWDHS Post Mortem
#Check if Running with root user

if [ "$USER" != "root" ]; then
      echo "Permission Denied"
      echo "Can only be run by root"
      exit
fi
    ### Welcome ###
echo "Initializing hardening within: $(pwd)"
# Some things work in echo lines like UID
echo "Your UID is $[UID]"

    ### Functions ###
find_type () {
find /home -name "*.$TYPE" 2>/dev/null
}

    ############## LogFile setup #################
LOG=y
    read -p 'Log this session? (ENTER for default)[Y/n] ' answer
    [ -n "$answer" ] && LOG=$answer
echo

if [ $LOG = y ]; then
    LOGFILENAME=session.log  #/home/anonymous/scripts/log.txt
    LOGPATH=$(pwd)

    read -p "Name of log file (ENTER for default)[${LOGFILENAME}]: " newname
    [ -n "$newname" ] && LOGFILENAME=$newname
echo

  ## COULD ASk FOR LOCATION AND VERIFY for / or just ask for full path to file
  ## comment to remove path input
    read -p "Location of log file (ENTER for default)[${LOGPATH}]: " newloc
    [ -n "$newloc" ] && LOGPATH=$newloc
echo

  LOGFULLPATH="${LOGPATH}/${LOGFILENAME}"

    echo -e "Log file Full path set: ${LOGFULLPATH}"
echo

  exec > >(tee $LOGFULLPATH) 2>&1
fi

    ############## Update & Upgrade ##############
U_U=y
    read -p "Update & Upgrade? (Y/n)" var_U
    [ -n "$var_U" ] && U_U=$var_U

if [ $U_U = y ]; then
        sudo apt-get update -y && sudo apt-get upgrade -y
        sudo apt-get install git
fi

    ############## Auto updates ##############
echo
A_U=y
    read -p "Install Unattended Updates (Y/n)" var_AU
    [ -n "$var_AU" ] && A_U=$var_AU

if [ $A_U = var_A+U ]; then
        sudo apt-get install unattended-upgrades apt-listchanges bsd-mailx
        sudo dpkg-reconfigure -plow unattended-upgrades
        systemctl status unattended-upgrades.service | grep active && echo 'Successfully Enabled Unattended-Upgrades'
fi
    ############# Root Kits ############ Make them verbose

#rkhunter
echo
RKKIT=y
    read -p  "RkHunter (Rootkit)? (Y/n)" var_rootkit
    [ -n "$var_rootkit" ] && RKKIT=$var_rootkit  # if var_rootkit>
if [ $RKKIT = y ]; then
        echo 'Rootkit Detector Sequence Loading...'

        sudo apt-get install rkhunter -y
        sudo rkhunter --check
fi
#echo -e "\nRkHunter (Rootkit)? (y/n)"
#read yesno
#if [ $yesno = y ]; then
#        echo 'Rootkit Detector Sequence Loading...'
#          sudo apt-get install rkhunter -y
#          sudo rkhunter --check
#fi

#chkrookit
echo
CHK=y 
    read -p "chkrootkit (Rootkit)? (Y/n)" var_chk
    [ -n "$var_chk" ] && CHK=$var_chk

if [ $CHK = y ]; then
		echo 'chkrootkit Detector Sequence Loading...'
		sudo apt-get install chkrootkit -y
		sudo chkrootkit
        echo 'CHK completed!'
fi

#Lynis
echo
LYN=y 
    read -p "Lynis Security Audit? (Y/n)" var_lyn
    [ -n "$var_lyn" ] && LYN=$var_lyn

if [ $LYN = y ]; then
        git clone https://github.com/CISOfy/lynis
        cd lynis
        sudo ./lynis audit system --verbose && echo 'Lynis Scan Completed!'
fi

    ####### Disable root login ++ Make an separate admin user.
# read -p 'Make amdin user and disable root login'

    ########## Uncomlicated firewall #########
echo
UFW=y
    read -p "Enable UFW? (Y/n) " var_ufw
    [ -n "$var_ufw" ] && UFW=$var_ufw

if [ $UFW = y ]; then
        sudo apt-get install ufw
        sudo ufw enable
        sudo ufw status
        echo 'ufw is up to date and enabled'
fi
        
    ########## Securing OpenSSH ##########
#FIX THIS if statement wont work need to use [ $? -eq 0 ] refer to line266
    if [ 'dpkg --list | grep ssh-server' ]; then

SSH=y

    echo -e "\nLooks like you have OpenSSH server installed"
    read -p 'Want to secure it? (Y/n)' var_ssh
    [ -n "$var_ssh" ] && SSH=$var_ssh

if [ $SSH = y ]; then
    cp /etc/ssh/sshd_config .
	echo 'Copied Backup sshd_config.txt To Present Working Directory'

    #Securing Process
        # sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
        # sed -i 's/ / /' /etc/ssh/sshd_config
# Temp fix I want to make it so it overides the whole config file
# if if script is run twice it will just dump it again causing config problems
        echo "X11Forwarding=no" >> /etc/ssh/sshd_config
        echo "Ciphers=aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config
        echo "PermitUserEnvironment=no" >> /etc/ssh/sshd_config
        echo "PermitEmptyPasswords=no" >> /etc/ssh/sshd_config
        echo "PermitRootLogin=no" >> /etc/ssh/sshd_config
        echo "HostbasedAuthentication=no" >> /etc/ssh/sshd_config
        echo "IgnoreRhosts=yes" >> /etc/ssh/sshd_config
        echo "MaxAuthTries=4" >> /etc/ssh/sshd_config
        echo "ClientAliveInterval=10" >> /etc/ssh/sshd_config
        echo "ClientAliveCountMax=0" >> /etc/ssh/sshd_config
        echo "AllowUsers=" >> /etc/ssh/sshd_config
        echo "AllowGroups=sshlogin" >> /etc/ssh/sshd_config
        echo "DenyUsers=root" >> /etc/ssh/sshd_config
        echo "DenyGroups=root" >> /etc/ssh/sshd_config
        echo "UsePAM=yes" >> /etc/ssh/sshd_config
        echo "Protocol=2" >> /etc/ssh/sshd_config
        echo "RhostsRSAAuthentication=no" >> /etc/ssh/sshd_config
        echo "RhostsAuthentication=no" >> /etc/ssh/sshd_config
        echo "LoginGraceTime=1m" >> /etc/ssh/sshd_config
        echo "SyslogFacility=AUTH" >> /etc/ssh/sshd_config
        echo "MaxStartups=5" >> /etc/ssh/sshd_config && echo ; echo 'Secured OpenSSH' || echo 'Failed to secure ssh! Please refer to log file.'
        echo "PASS_WARN_AGE=7" >> /etc/login.defs
        echo "PASS_MIN_DAYS=7" >> /etc/login.defs
        echo "PASS_MAX_DAYS=90" >> /etc/login.defs
        echo "PASS_MIN_LEN 8" >> /etc/login.defs
        
    fi
fi

    ######## Files by extensions #########
echo
YESNO=y
    read -p 'Search for files in home diretories? (Y/n)' var_yesno
    [ -n "$var_yesno" ] && YESNO=$var_yesno

if [ $YESNO = y ]; then

TYPE="mp3"
    find_type
TYPE="flv"
    find_type
TYPE="mov"
    find_type
TYPE="sh"
    find_type
TYPE="mp4"
    find_type
TYPE="avi"
    find_type
TYPE="mpg"
    find_type
TYPE="mpeg"
    find_type
TYPE="flac"
    find_type
TYPE="m4a"
    find_type
TYPE="ogg"
    find_type
TYPE="gif"
    find_type
TYPE="png"
    find_type
TYPE="jpg"
    find_type
TYPE="jpeg"
    find_type
TYPE="pptx"
    find_type
TYPE="pptx"
    find_type
TYPE="wav"
    find_type
TYPE="bat"
    find_type
TYPE="zip"
    find_type
TYPE="dat"
    find_type
TYPE="log"
    find_type
TYPE="xml"
    find_type
TYPE="pst"
    find_type
TYPE="py"
    find_type
TYPE="mkv"
    find_type
TYPE="tar.gz"
    find_type
fi

echo
YESNO=y
    read -p 'Also look for .txt files? (Y/n)' var_yesno
    [ -n "$var_yesno" ] && YESNO=$var_yesno

if [ $YESNO = y ]; then

TYPE="txt"
    find_type

fi
echo
    echo 'Succesffuly completed your search in Home!'

  ######## NOPASSWD in SUDOERS ##########
echo
sudo cat /etc/sudoers | grep -i NOPASSWD
if [ $? -eq 0 ]; then

echo 'NOPASS value in sudoers'

fi

## NetStat
netstat -ntlup
echo
   ######## Packs that may be dangerous ###

    echo 'Searching for possible dangerous packages'
echo
    sudo dpkg-query --list | grep -e "hacking" -e "hack" -e "crack" -e "fakeroot" -e "nmap" -e "trojan" -e "trojan" -e "john" -e "zenmap" -e "logkeys" -e "Nginx" -e "Hydra" -e "malware" -e "narc" -e "server" -e "VPN" -e "VPN" -e "open"

####### Suspiscious file family ######
echo
    echo 'Looking for files with no family trace'
    sudo find / \( -nouser -o -nogroup \)

####### purge/REMOVE stuff ######
#sudo apt-get purge nmap
#sudo apt-get purge zenmap
#sudo apt-get purge hydra*
#sudo apt-get purge john*
#sudo apt-get purge nikto*
#sudo apt-get purge netcat*

# fix for username not in sudoers file
# sudo su or sudo : type root passsword
# sudo apt-get install sudo
# adduser (username) sudo : adding usrname to sudo file
# sudo chmod  0440  /etc/sudoers : change perms

    echo -e '\nRemember/ToDo:

BrowserSecrurity
Unwanted Applications (games)
Turn off ipv6
Restrict Users to Use Old Passwords
Booting from external media
ps -aux
...
...'
echo
    read -p 'Hit Enter to exit'
