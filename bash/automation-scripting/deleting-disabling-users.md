To delete account:

Users that belong to system accounts, have a low uid

While normal users have higher values

We can check these settings in `/etc/login.defs`

We can delete users as `sudo userdel -r USERNAME` the -r option deletes that user homedirectory

If we wanted to save the files of a user, we could use the `tar` command (it's like a .rar file!)

for example: `tar -cf FILENAME.tar DIRECTORYPATH/`

We can further compress it using gzip as `gzip file` and unzip using `gunzip file`

We can have a .tar.gz or .tgz file which is a compressed archive

Or create it as `tar -zcvf FILENAME.tar.gz DIRECTORYPATH/`

Note: !$ uses the previous command argument used to be used again

Be careful when extracting as tar overwrites!

To disable accounts:

We use `chage` for example: `sudo chage -E 0 username` to enable it again `sudo chage -E -1 woz`

Another way would be locking their password using `sudo passwd -l USERNAME` and unlocking their password with `sudo passwd -u USERNAME` but this doesn't prevent users from authenticating using SSH keys.

Another method is set the shell of that user to a nologin, we can check our current shells using `cat /etc/shells` and then `sudo usermod -s /sbin/nologin USERNAME` (still doesn't prevent ssh)

Example script:

```bash
#!/bin/bash

#This script deletes a user.

#Assume the first argument is the user to delete.
USER="${1}"

# Delete the user
userdel ${USER}

#Make sure the user got deleted
if [[ "${?}" -ne 0 ]]
then
	echo "The account ${USER} was NOT deleted." >&2
	exit 1
fi

# Tell the user the account was deleted.
echo "The account ${USER} was deleted."

exit 0


```

