#!/bin/bash

#add useraccount with name passed in as first parameter
sudo useradd $1

#set password for user account that was just created with second parameter
#and only send successful message if chpasswd exits successfuly
echo "$1:$2" | sudo chpasswd && echo "Account for $1 has been created"
