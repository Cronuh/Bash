#!/bin/bash

USERNAME=$1
PASSWORD=$2
file=credentials.txt

#add useraccount with name passed in as first parameter
sudo useradd $USERNAME

#check if lenght of password that was passed in is 0, if so generate random  one
if [ -z $PASSWORD ];
then
 PASSWORD=$(openssl rand -base64 32)
fi

#set random password for user account that was created and only send successful
#message if chpasswd exits successfuly
echo "$USERNAME:$PASSWORD" | sudo chpasswd && echo "Account for $USERNAME has been created"

#checks if file with credentials exists, if so - delete, then gets new  ones
#and puts them into newly created file
if [ -f $file ];
then
 rm $file && echo "Old file was removed."
fi
touch credentials.txt
echo "Welcome to our company! Here are your login credentials." >> credentials.txt
echo "Username: $USERNAME" >> credentials.txt
echo "Password: $PASSWORD" >> credentials.txt

#send abovementioned file via email
mail -A /home/ubuntu/Scripting/credentials.txt -s "Your new credentials!" UtrashIknowFPS@protonmail.com < /dev/null
