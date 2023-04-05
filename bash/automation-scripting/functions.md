We create a function by starting with curly braces, such as:


```bash
#!/bin/bash

log() {
	echo 'You called the log function'
}

log
```

or:

```bash
#!/bin/bash

function log {
	echo 'You called the log function'
}

log
```

--------

Note: local makes a variable local only to that function (doesn't exist outside the function)

readonly makes a variable a constant, (read only, it can't be changed inside or outside the function)

```bash
#!/bin/bash

log() {
	#This function sends a message to syslog and to standard output if VERBOSE is true.
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	echo "${MESSAGE}"
	logger -t my-tag "{MESSAGE}"
}

backup_file(){
#This function creates a function of a file. Returns non-zero status on error.

	local FILE="${1}"
	
	# Make sure the file exists.
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}.${date +%F-%N)"
		log "Backing up ${FILE} to ${BACKUP_FILE}."
		
	#The exit status of the function will be the exit status of the cp
	cp -p ${FILE} ${BACKUP_FILE}
	else
		#The file doesn't exists, so return a non-zero exit status.
		return 1
	fi
	}
readonly VERBOSE='true'
log 'This is fun!' 
backup_file '/etc/passwd'

#Make a decision based on the exit status of the function.

if [[ "${?}" -eq '0' ]]
then 
	log 'File backup succeeded!'
else
	log 'File backup failed!'
	exit 1
fi
```

Note: messages stored by logger are located at `/var/log/messages`

We can tag our logging messages as `logger -t my-tag 'hello world'`

Note: By default files in /tmp/ are cleaned up after 10 days, and those in /var/tmp after 30 days.

return -> exits a function

exit -> exits a script