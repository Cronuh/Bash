#!/bin/bash

USERNAME=$2
PASSWORD=$3
file=credentials.txt

addUser ()
{

 #add useraccount with name passed in as first parameter and create home dir
 sudo useradd -m $USERNAME

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

 #send abovementioned file via email and delete from system as we dont want to
 #store plain text creds on PCs
 mail -A credentials.txt -s "Your new credentials!" UtrashIknowFPS@protonmail.com < /dev/null && \
  echo "Mail has been sent." && \
  echo "Deleting file from the system." && \
  rm -rf credentials.txt

 #copy company rules to new users home dir
 sudo cp company_rules.txt "/home/$USERNAME/" && \
  echo "Company rules file was copied to home dir."
}

deleteUser ()
{
 sudo userdel $USERNAME && sudo rm -rf /home/$USERNAME && \
 echo "User $USERNAME has been deleted from the system."
}

if [ "$1" == "add"  ]
then
 addUser
elif [ "$1" == "delete" ]
then
 deleteUser
else
 echo "You must enter add or delete as first argument"
fi
