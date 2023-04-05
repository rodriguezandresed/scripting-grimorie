#!/bin/bash

#Display the UID and username of the useescripting script
#Display if the user is the vagrant user or not.


#Display the uid

echo "Your UID is ${UID}"

#Display error message and exit script if not superuser

UID_TO_TEST_FOR='0'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then 
	echo "You are not the root user}"  >&2
	exit 1
fi

if [[ "${#}" -lt 1 ]]
then 
	echo "Usage: ${0} USER_NAME [COMMENTS]..." >&2
	echo 'Create an account on the local system with the name of USER_NAME and a comment field of COMMENT' 2> std.err
	exit 1
fi


#Ask for username:
USER_NAME="${1}"
# Ask for the real name.
shift
COMMENT="${@}"
# Ask for the password.
PASS_PART1=$(date +%s%N{RANDOM}${RANDOM} | sha256sum | head -c48)
PASS_PART2=$(echo '!@#$%^&*()_-=+' | fold -w1 | shuf | head -c1)
PASSWORD=${PASS_PART1}${PASS_PART2}
# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

#Check if the useradd command succeded

if [[  "${?}" -ne 0 ]]
then
	echo 'The account could not be created.' >&2
	exit 1
fi

# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

#Check if the passwd command succeded

if [[  "${?}" -ne 0 ]]
then
	echo 'The password could not be set.' >&2
	exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME} &> /dev/null
echo "The user was created with the username "${USER_NAME}" , the password "${PASSWORD}" in the host "${HOSTNAME}" and comments "${COMMENT}" "
