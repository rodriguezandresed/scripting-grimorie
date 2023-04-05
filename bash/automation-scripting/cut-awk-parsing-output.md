CUT:

Cut can be used to remove section from files

This cuts COLUMNS, so you would have something like:

For example: `cut -c 1 /etc/passwd` 
```bash
:
W
:
:
o
```

We can also specify ranges For example: `cut -c 4-7 /etc/passwd`, it would return from character 4 to 7

Or to specify when it begins with a certain character position We can also specify ranges For example: `cut -c 4- /etc/passwd`, it would return from character 4 to the end

Or to specify when it ends with a certain character For example: `cut -c -4 /etc/passwd`, it would return from the begining to 4

Or to specify the characters, they can be selected as `cut -c 1,3,5 /etc/passwd` 

STDIN can be used to pipe stuff into cut for example: `echo "hola" | cut -c 1`

We can separate fields using / and the `-e` option, for example: `echo -e one\two\three \ cut -f 1` and with cut we specify the field

We can specify what's the separator for the fields using `echo 'one,two,three' | cut -d ',' -f 1` 

Grep:

This pattern matches the begining of a line, it matches a position (all the lines that start with first)

We use the carrot sign (^) `grep '^first' people.csv`

Or $ sign to match the lines that finish with a pattern `grep 't$' people.csv`

Or match the ones that begin finish with `grep '^first,last$' people.csv`

the -v option for grep displays the lines that do not match the pattern

AWK:

By default, the separator (thing it filters) is blank space

This command can be used to use multiseparator (like DATA:) for example:

`awk -F 'DATA:' '{print $2}' people.dat`

`awk -F ':' '{print $1, $3}' /etc/passwd`

To specify the delimitator for the output we use the OFS parameter

`awk -F ':' -v OFS=',' '{print $1, $3}' /etc/passwd`

Or `awk -F ':' '{print "COL1: " $1 " COL3: " $3}' /etc/passwd`

Or specify the order of the fields `awk -F ':' '{print "UID: " $3 ";LOGIN: " $1} /etc/passwd`

We can use `$NF` to print the number of fields found, so to print the last field in a line:

`awk -F ':' '{print $NF}' /etc/passwd`

Or use mathematical expressions: `awk -F ':' '{print $(NF -1)}' /etc/passwd`

For unconsistent data separated in blank `awk 'print $1, $2}' FILENAME`

Example for scripting:

Looking for listening ports: `netstat -nutl` 

Filtering the headers: `netstat -nutl | grep -v '^Active' | grep -v '^Proto'` or `netstat -nutl | grep -Ev '^Active|^Proto'`

Filtering with the port numbers and for ipv4: `netstat -4nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' 

Or `netstat -4nutl | grep ':" | awk '{print $4}' | awk -F ':' '{print $NF}'


We could send it to a script as
Having the option to send -4 as an argument for ipv4

```bash
`netstat -nutl ${1} | grep ':" | awk '{print $4}' | awk -F ':' '{print $NF}'
```

Note: the -p parameter allows us to see what user has the port open