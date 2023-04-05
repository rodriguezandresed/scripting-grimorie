Sort:

We can use sort to sort alphabetically

Example: `sort /etc/passwd` or reversed `sort -r /etc/passwd`

To sort numerically we use the `-n` option

Note: `du` command shows the disk usage.

So we could see the highest usage using: `sudo du -h /var | sort -nh`

The -h option allows us to see the output in human readable numbers

The -u option allows us to see unique values

Uniq:

The `uniq` command also works to remove non-unique values but the input has to be sorted

-c option counts the times a line was repeated

We could for example:

`netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c`

Or reading times a log appeared for a certain program on syslog 

`sudo cat /var/log/messages | awk '{print $5}'` | sort | uniq -c | sort -n

The `wc` command or word count, can count words, bytes, files, etc.

the columns are: lines words characters

-w -> words ; -c -> characters ; -l -> lines


We can also sort based on a field for example:

`cat /etc/passwd | sort -t ':' -k 3 -n -r`