#!/bin/bash

USERNAME=$1
PASSWORD=$2

#add useraccount with name passed in as first parameter
sudo useradd $USERNAME

#set password for user account that was just created with second parameter
#and only send successful message if chpasswd exits successfuly
echo "$USERNAME:$PASSWORD" | sudo chpasswd && echo "Account for $1 has been created"
