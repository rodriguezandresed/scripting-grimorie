Adding hostnames to `/etc/hosts` using `tee -a` (Transforms STDIN to STDOUT)

```bash
echo '10.9.8.11 server01' | sudo tee -a /etc/hosts
echo '10.9.8.12 server02' | sudo tee -a /etc/hosts
```

To change our own hostname, we can edit `/etc/hosts` on the loopback address and on `/etc/hostname/` then `sudo reboot`

Note: that for example: `sudo echo test >> /etc/hosts` wouldn't work because while we ran sudo echo, the redirection `>>` wasn't done by sudo, it's done with your own user

Create a ssh key!
`ssh-keygen`
Puts the public key on the remote system:
`ssh-copy-id SERVERNAME` 

We could loop ssh into servers as:

Note: SSH exits with 255 error if an SSH error happened or if the commands passed, it will start with that command's exit code status

```bash
for N in 1 2
do
	ssh server0${N} hostname
done
```

or while having a file that contains the hostname or IP of the servers

```bash
for SERVER in $(cat FILENAME)
do
	ssh ${SERVER} hostname
	ssh ${SERVER} uptime
done
```

Whenever we're typing commands on ssh, we need to close them in quotes or doublequotes if we're using variable names. for example:

`ssh server01 'hostname ; hostname' 

or:

```bash
CMD1='hostname'
CMD2='uptime'
ssh server01 "${CMD1} ; ${CMD2}"
```

If we run ssh as sudo, it will also try to run commands as root, so we will need to type the password for the root user

`sudo ssh server01 id` 

Instead we could run the commands as sudo:

`ssh server01 sudo id`
