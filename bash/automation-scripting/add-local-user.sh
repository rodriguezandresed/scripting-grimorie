#!/bin/bash

#Display the UID and username of the useescripting script
#Display if the user is the vagrant user or not.


#Display the uid

echo "Your UID is ${UID}"

#Display error message and exit script if not superuser

UID_TO_TEST_FOR='0'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then 
	echo "You are not the root user}"
	exit 1
else
read -p 'Enter the username to create: ' USER_NAME
# Ask for the real name.
read -p 'Enter your real name: ' COMMENT
# Ask for the password.
read -p 'Enter the password for the account: ' PASSWORD
# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}
# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# Force password change on first login.
passwd -e ${USER_NAME}
echo "The user was created with the username "${USER_NAME}" , the password "${PASSWORD}" in the host "${HOSTNAME}" "

fi

