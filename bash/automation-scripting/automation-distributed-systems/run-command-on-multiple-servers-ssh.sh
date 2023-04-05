#!/bin/bash

#This script pings a list of servers and reports their status

SERVER_FILE='/vagrant/servers'

usage() {
	echo "Usage: ${0} [-nsv] [-f FILE] COMMAND" >&2
	echo 'Executes COMMAND as a single command on every server.' >&2
	echo " -f SERVER_FILE use SERVER_FILE for the list of servers. Default ${SERVER_FILE}." >&2
	echo ' -n Dry run mode. Display the COMMAND that would have been executed' >&2
	echo ' -s Execute the COMMAND using sudo on the remote server' >&2
	echo ' -v Verbose mode. Displays the server name before executing COMMAND' >&2
	exit 1
}

log() {
	local MESSAGE="${@}"
if [[ "${VERBOSE}" = 'true' ]]
then
	echo "${MESSAGE}"
fi
}

#Display error message and exit script if  superuser

UID_TO_TEST_FOR='0'
if [[ "${UID}" -eq "${UID_TO_TEST_FOR}" ]]
then 
	echo "Do not execute this script as the root user! Use the -s option instead"  >&2
	usage
fi

#Parse the options

while getopts f:nsv OPTION
do
	case ${OPTION} in
	f) 
		SERVER_FILE="${OPTARG}"
		;;
	n) 
		DRY_RUN='true'
		;;
	s) 
		SUPER_USER='sudo'
		;;
	v) 
		VERBOSE='true'
		log 'Verbose mode on.'
		;;
	?)
		usage
		;;
	esac
done

#Remove the options while leaving the remanining arguments.
#OPTIND are the number of options used at the time on the script.

shift "$(( OPTIND - 1 ))"

#If the user doesn't supply at least one argument, send them help.
if [[ "${#}" -lt 1 ]]
then
	usage
fi

#Anything left on the command line is treated as the command to be executed.
COMMAND="${@}"

if [[ ! -e "${SERVER_FILE}" ]]
then
	echo "Cannot open ${SERVER_FILE}." >&2
	exit 1
fi

#Expected exit status
EXIT_STATUS='0'

for SERVER in $(cat ${SERVER_FILE})
do
	log "Running SSH on ${SERVER}"
	SSH_COMMAND="ssh -o ConnectTimeout=2 ${SERVER} {SUPER_USER} ${COMMAND}"
	#If it's a dry run, don't execute anything, just echo it.
	if [[ "${DRY_RUN}" = 'true' ]]
	then
		echo "DRY RUN: ${SSH_COMMAND}"
	else
		${SSH_COMMAND}
		SSH_EXIT_STATUS="${?}"
		
		#Test the SSH_COMMAND status and report to the user.
		if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]
			then 
				EXIT_STATUS="${SSH_EXIT_STATUS}"
				echo "Execution on ${SERVER} failed." >&2
		fi
	fi

done

exit ${EXIT_STATUS}

