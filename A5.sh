#!/bin/bash

#Check if Running with root user

if [ "$USER" != "root" ]; then
      echo "Permission Denied"
      echo "Can only be run by root"
      exit
fi

echo "Initializing hardening within: $(pwd)"
# Some things work in echo lines like UID
echo "Your UID is $[UID]"

#Function testing
log_file () {
#Function testing

#Script by Ben Cordeiro

    ################LogFile setup #####################
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
  ## Uncomment for path input
    read -p "Location of log file (ENTER for default)[${LOGPATH}]: " newloc
    [ -n "$newloc" ] && LOGPATH=$newloc
echo

  LOGFULLPATH="${LOGPATH}/${LOGFILENAME}"

    echo -e "Log file Full path set: ${LOGFULLPATH}"
echo

  exec > >(tee $LOGFULLPATH) 2>&1
fi

    ################ Update & Upgrade ########################
U_U=y
    read -p "Update & Upgrade? (Y/n)" var_U
    [ -n "$var_U" ] && U_U=$var_U

if [ $U_U = y ]; then
        sudo apt-get update -y && sudo apt-get upgrade -y
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
CHK=y 
echo 
    read -p "chkrootkit (Rootkit)? (Y/n)" var_chk
    [ -n "$var_chk" ] && CHK=$var_chk

if [ $CHK = y ]; then
		echo 'chkrootkit Detector Sequence Loading...'
		sudo apt-get install chkrootkit -y
		sudo chkrootkit
        echo 'CHK completed!'
fi

    ####### Disable root login ++ Make an separate admin user.
# read -p 'Make amdin user and disable root login'

   ####### Files by extension  #######
# read -p 'Show added extentions? (Y/n)'


     ########## Uncomlicated firewall ######
UFW=y
echo
    read -p "Enable UFW? (Y/n) " var_ufw
    [ -n "$var_ufw" ] && UFW=$var_ufw

if [ $UFW = y ]; then
        sudo apt-get install ufw
        sudo ufw enable
        sudo ufw status
        echo 'ufw is up to date and enabled'
fi
        
     ##########Securing OpenSSH##########
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
        echo 'Succesfully secured SSH'
    fi
fi

#fix for username not in sudoers file
#sudo su or sudo : type root passsword
#sudo apt-get install sudo
#adduser (username) sudo : adding usrname to sudo file
#sudo chmod  0440  /etc/sudoers : change perms

#function end
}
#function execution #Everytime log_file is written it will repeat commands in function.
log_file
    echo -e '\nRemember BrowserSecrurity, Unwanted Applications, Turn off ipv6, Restrict Users to Use Old Passwords booting from external media or games...'
    echo "Done"
echo
    read -p 'Hit Enter to exit'
    
