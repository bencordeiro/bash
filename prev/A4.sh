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
echo -e "\nUpdate & Upgrade? (y/n)"

read yesno

if [ $yesno = y ]; then
        sudo apt-get update -y
        sudo apt-get upgrade -y
fi

       ############# Root Kits ############
#rkhunter
echo -e "\nRkHunter (Rootkit)? (y/n)"

read yesno

if [ $yesno = y ]; then
        echo 'Rootkit Detector Sequence Loading...'

          sudo apt-get install rkhunter -y
          sudo rkhunter --check
fi

#chkrookit
 echo -e "\nchkrootkit (RootKit/Backdoor)? (y/n)"

 read yesno

if [ $yesno = y ]; then
		echo 'chkrootkit Detector Sequence Loading...'

		sudo apt-get install chkrootkit -y
		sudo chkrootkit
fi

     ###### Files by extension  #######

     ########## Uncomlicated firewall ######

     ##########Securing OpenSSH##########
if [ 'dpkg --list | grep ssh-server' ]; then
        echo -e "\nLooks like you have OpenSSH server installed"
        echo 'Want to secure it? (y/n)'
fi

read yesno

if [ $yesno = y ]; then
	cp /etc/ssh/sshd_config .
	echo 'Copied Backup sshd_config.txt To Present Working Directory'
#Securing Process
#	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
#	sed -i 's/ / /' /etc/ssh/sshd_config
	echo 'Succesfully secured SSH'
fi



#function end
}
#function execution #Everytime log_file is written it will repeat commands in function.
log_file
echo -e '\nRemember BrowserSecrurity, Unwanted Applications or games...'
echo "Done"
echo
read -p 'Hit Enter to exit'
