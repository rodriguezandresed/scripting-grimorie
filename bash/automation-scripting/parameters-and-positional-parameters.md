${0} -> Position parameter, they are variables that contain the content of the command. ${#} shows how many parameters were issued into the script.

0 -> name of script, 1-> 1st parameter being put into the script and so on..

Parameters are variables being used inside a script.

Argument is the data passed into the shell script or data that comes to the outside from the script.

Arguments enclosed in quotation marks count as 1 argument, so `command a b "c hello  d"` would count 3 arguments

Bash uses a hash table to save the location of scripts, if we have 2 scripts and delete the one that it's pointing (for example `type head`), it will try to load that script, to reset the hash table, we can type `has -r`

We can use basename to remove the directory from a path

For example: `basename /vagrant/luser-c1.sh` -> luser-c1.sh`

We can use dirname to remove the filename from the lsat item of a path

For example: `dirname /vagrant/luser-c1.sh`

```bash
while structure: [[ "${VARIABLE}" -conditional "${VALUE_TO_COMPARE" ]]
do
	stuff
done
```

if:

```bash
if [[ "${VARIABLE}" -conditional "${VALUE_TO_COMPARE" ]]
then
	stuff
fi

```

The `shift` command moves the # position parameters by -1 or whatever number we speficy off. It's usually used in scripts to go through parameters ( 2 turns to 1, 3 turns to 2 and so on...)