
(File Descriptor 1) We redirect Standard Output (STDOUT, (output from commands) to a file using `>` (overwrites) or `>>` (appends) 

For example: 
```bash
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}`
```

We can also use the file scriptor number, for example:

`echo "${UID}" 1> uid`

(File Descriptor 0) To redirect Standard Input (STDIN (inputs from users or pipeline output) we use `<` 

For example: `read LINE < ${FILE}

We can also use the file descriptor number to specify that input (note there are not spaces between the 0 and <)

For example: `read X 0< /etc/centos-release`

(File Descriptor 2) This is used for Standard Error, we specify standard error as `2> filenametosave` for example:

`head -n1 /etc/passwd /etc/hosts /fakefile > head.out 2> head.err`

We can send both STOUT and STERR as:

`head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1`

Note: & is used to indicate that what follows and precedes is a file descriptor and not a filename.

Or the newest sintax:

`head -n1 /etc/passwd /etc/hosts /fakefile &> head.both`

Or: `head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n`

We can append errors so that they don't go to other files as:

`echo 'error' 1>&2 | cat -n`

We can get rid of standard error or standard output by sending stuff to /dev/null 

For example: `head -n1 /etc/passwd /etc/hosts /fakefile &> /dev/null`
For STDOUT: `head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null`
For STDERR: `head -n1 /etc/passwd /etc/hosts /fakefile 2> /dev/null`