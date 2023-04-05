Note: we can find commands we don't have in our path using `locate`, for example: `locate userdel` (locate uses something like a database that feeds from our files once a day, we can force the update using `sudo updatedb`)

`sudo !!` -> most recent sudo command used

We can also search as `ls -ld /*bin` and search on those outputs, for example `ls -l /usr/bin/userdel`

system admin commands are usually found in usr/sbin while commands for all users are found in usr/bin

dev/null is also called bitbucket

Find searches recoursively `find /usr/sbin/ -name userdel`

To not see errors `find / -name userdel 2>/dev/null` 