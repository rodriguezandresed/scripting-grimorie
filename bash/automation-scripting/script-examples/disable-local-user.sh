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

readonly ARCHIVE_DIR='/archive'

usage() {
	echo "Usage: ${0} [-dar] USER [USERN]..." >&2
	echo 'Manage an account'
	echo ' -d deletes the specified user'
	echo ' -a creates an archive of the user home directory and stores it in /archive'
	echo ' -r removes the home directory'
	exit 1
}


manage() {
	echo "Usage: ${0} [-dar] user" >&2
	echo 'Manage an account'
	echo ' -d deletes the specified user'
	echo ' -a creates an archive of the user home directory and stores it in /archive'
	echo ' -r removes the home directory'
	exit 1
}


while getopts vl:s OPTION
do
	case ${OPTION} in
	d) 
		DELETE_USER='true'
		;;
	r) 
		REMOVE_OPTION='-r'
		;;
	a) 
		ARCHIVE='true'
		;;
	?)
		usage
		;;
	esac
done

#Remove the options while leaving the remanining arguments.
#OPTIND are the number of options used at the time on the script.

shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
	usage
fi

# Processing the supplied usernames
for USERNAME in "${@}"
do
	echo "Processing user: ${USERNAME}"
	
	#Making sure the UID of the account is at least 1000
	USERID=$(id -u ${USERNAME})
	if [[ "${USERID}" -lt 1000 ]]
	then 
		echo "Refusing to delete the ${USERNAME} account"
		exit 1
	fi
	
	#Create an archive if requested to do so.
	if [[ "${ARCHIVE}" = 'true' ]]
	then
		# Make sure the ARCHIVE_DIR directory exists.
		if [[ ! -d "${ARCHIVE_DIR}" ]]
		then
			echo "Creating ${ARCHIVE_DIR} directory."
			mkdir -p ${ARCHIVE_DIR}
			if [[ "${?}" -ne 0 ]]
			then
				echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
				exit 1
			fi
		fi
	
	#Archive the user's home directory and move into the ARCHIVE_DIR
	HOME_DIR="/home/${USERNAME}"
	ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
	if [[ -d "${HOME_DIR}" ]]
	then
		echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
		tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
		if [[ "${?}" -ne 0 ]]
		then
			echo "Could not create ${ARCHIVE_FILE}." >&2
			exit 1
		fi
		else
			echo "${HOME_DIR} does not exists or is not a directory." >&2
			exit 1
		fi
	fi
	
	if [[ "${DELETE_USER}" = 'true' ]]
	then
		#Delete the user
		userdel ${REMOVE_OPTION} ${USERNAME}
		
		#Check to see if the userdel command succeeded.
		
		if [[ "${?} -ne 0 ]]
		then
			echo "The account ${USERNAME} was NOT deleted." >&2
			exit 1
		else
			echo "The account ${USERNAME} was deleted."
		fi
	else
		chage -E 0 {USERNAME}	
		if [[ "${?}" -ne 0 ]]
		then
			echo "The account ${USERNAME} was NOT disabled." >&2
			exit 1
		else
			echo "The account ${USERNAME} was disabled."
		fi
	fi
done

exit  0


