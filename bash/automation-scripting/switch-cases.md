Note:

The command-line arguments $1, $2, $3,...$9 are positional parameters, with $0 pointing to the actual command, program, shell script, or function and $1, $2, $3, ...$9 as the arguments to the command.

"$*" special parameter takes the entire list as one argument with spaces between and the "$@" special parameter takes the entire list and separates it into separate arguments.

Case Statements:

Examples using if statements:

```bash
if [[ "${1}" = 'start' ]]
then
	echo 'Starting.'
elif [[ "${1}" = 'stop' ]]
then
	echo 'Stopping.'
elif [[ "${1}" = 'status' ]]
then
	echo 'Status:'
else
	echo 'Supply a valid option.' >&2
	exit 1
fi

```

Using case statements:

Note: 
- We end the code block using ;;
- We can use an or for a pattern using the pipe

```bash
case "${1}" into

	start) 
		echo 'Starting.'
	;;
	stop)
		echo 'Stopping.'
		;;
	status|state|--status|--state)
		echo 'Status:'
		;;
	*)
		echo 'Supply a valid option' >&2
		exit 1
		;;
esac
```

it can also be re-written to:

```bash
case "${1}" into

	start) echo 'Starting.' ;;
	stop) echo 'Stopping.' ;;
	status|state|--status|--state) echo 'Status:' ;;
	*) echo 'Supply a valid option' >&2 ; exit 1 ;;
esac
```
