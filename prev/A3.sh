#!/bin/bash

#Check if Running with root user

if [ "$USER" != "root" ]; then
      echo "Permission Denied"
      echo "Can only be run by root"
      exit
fi
#Function testing
log_file () {
#Function testing

#Script by Ben Cordeiro

echo "Initializing hardening within: $(pwd)"
# Some things work in echo lines like UID
echo "Your UID is $[UID]"


    ################LogFile setup #####################
echo -e "\nWould you like to store log file? (y/n)"

read store

if [ $store = y ]; then  #cant use -eq appprently for letters
	echo 'Where would you like to keep log file?'

read log_location

#Insert command to dump output of script to $log_location

#Insert command to dump output of script to $log_location

	echo -e "\nlog.txt File being created in: ${log_location}"

fi


    ############## Update & Upgrade ########################
echo -e "\nUpdate & Upgrade? (y/n)"

read yesno

if [ $yesno = y ]; then
        sudo apt-get update -y
        sudo apt-get upgrade -y
fi



    #################Rootkit###############
echo -e "\nRkHunter (Rootkit)? (y/n)"

read yesno

if [ $yesno = y ]; then
        echo 'Rootkit Detector Sequence Loading...'

          sudo apt-get install rkhunter -y
          sudo rkhunter --check
fi

   ##############chkrookit#############
 echp -e "/nchkrootkit (RootKit/Backdoor)? (y/n)"

 read yesno

if [ $yesno = y ]; then
		echo 'chkrootkit Detector Sequence Loading...'

		sudo apt-get install chkrootkit -y
		sudo chkrootkit
fi

     ##########Securing OpenSSH########
if [ 'dpkg --list | grep ssh-server' ]; then
        echo -e "\nLooks like you have OpenSSH server installed"
        echo 'Want to secure it? (y/n)'
fi

read yesno

if [ $yesno = y ]; then
	cp /etc/ssh/sshd_config .
	echo 'Copied Backup sshd_config.txt To Present Working Directory'
#Securing Process
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
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




}
#) | tee -a /home/anonymous/scripts/log.txt
#function end
#log_file tee ${log_location}/log.txt
#function execution
#Everytime log_file is written it will repeat commands in function.
log_file
echo -e '\nRemember BrowserSecrurity, Unwanted Applications or games...'
echo "Done"
