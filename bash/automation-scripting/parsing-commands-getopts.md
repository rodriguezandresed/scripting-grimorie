Getopts allows us to create options for our script, as long as it has stuff to parse, it will exit a 0 value.
Note: when we want an option to have an argument for it, we need to follow it with a :, in the example `l:`, these arguments get stored into ${OPTARG}


Arithmic expansion `NUM=$(( 1 + 2 ))` so that the variable will use the result as its value (it doesn't round, it ignores the decimal part)
or `DICEA='3'` `DICEB='6'` TOTAL=$(( DICEA + DICEB))
INCREMENT/DECREMETN (( TOTAL++ )) / (( TOTAL-- )) (( TOTAL += 5 ))

if we need to use floating numbers, we can use basic calculator (bc), which can be installed with `sudo yum install -y bc`

it would be used as ` echo '6 / 4' | bc -l`

Or we could also use `awk 'BEGIN {print 6/4}' 

Or `let NUM='2 + 3'

Or `expr 1 + 1` or `NUM=${expr 2 + 3}`



For example:

```bash
#!/bin/bash

#This script generates a random password.
#This user can set the password length with -l and add a special character with -s.
#Verbose mode can be enabled with -v.

usage() {
	echo "Usage: ${0} [-vs][-l LENGTH]" >&2
	echo 'Generate a random password.'
	echo ' -l LENGTH Specify the password length'
	echo ' -s Append a special character to the password'
	echo ' -v Increase verbosity.'
	exit 1
}

log() {
	local MESSAGE="${@}"
if [[ "${VERBOSE}" = 'true' ]]
then
	echo "${MESSAGE}"
fi

}

#Set a default password length
LENGTH=48

while getopts vl:s OPTION
do
	case ${OPTION} in
	v) 
		VERBOSE='true'
		log 'Verbose mode on.'
		;;
	l)
		LENGTH="${OPTARG}"
	s) 
		USE_SPECIAL_CHARACTER='true'
		;;
	?)
		usage
		;;
	esac
done

echo "Number of args: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

#Inspect OPTIND
echo "OPTIND: ${OPTIND}"

#Remove the options while leaving the remanining arguments.
#OPTIND are the number of options used at the time on the script.

shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
	usage
fi

log 'Generating a password'

PASSWORD=$(date +%s%N${RANDOM}{RANDOM} | sha256sum | head -c{LENGTH})

# Append a special character if requested to do so.

if [[ "USE_SPECIAL_CHARACTER}" = 'true' ]]
then
	log 'Selecting a random special character.'
	SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w | shuf | head -c1)
	PASSWORD = "${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done'
log 'Here is the password:'

#Display the password.
echo "${PASSWORD}"

exit 0

```
