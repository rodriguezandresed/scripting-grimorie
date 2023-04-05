One of sed uses is a find and replace: (NOTE THAT SED DOESN'T OVERWRITTES, ONLY DISPLAYS, IT IS CASE SENSITIVE)
s/ -> substitute

By default sed replaces the first match only

For example: `sed 's/PATTERNTOFIND/REPLACEMENTPATTERN/FLAG' FILETOUSE`

The default flag is blank and means that it's case sensitive, you can use the `i` flag for it to be case insensitive.

`sed 's/MY WIFE/sed/I' love.txt`

The `g` flag means that sed will replace all patterns matching or we can specify a number for the ocurrence

`sed 's/MY WIFE/sed/2' love.txt`

We can make sed create a backup of the file using for example: `sed -i.bak 's/my wife/sed/' love.txt`

We can use the `w` flag to only keep the lines that were replaced.

for example: `sed 's/love/like/gw FILETOCREATE.txt' love.txt`

We can make sed ignore a parameter for example when having to parse strings that contain `/` by using `\` which will make sed escape(ignore) that string:

for example: `echo '/home/jason' | sed 's/\/home\/json/\/export\/users\/jasonc/` 

so: echo '/home/jason' | sed 's/`\/`home`\/`json/`\/`export`\/`users`\/`jasonc/ the highlighted `\/` means that `/` was ignored.

Or we could just use another delimitator, for example(we could use # , ; and more): `echo '/home/jason' | sed 's#/home/jason#/export/users/jasonc#'

We can use the `d` flag to delete the line that matches the pattern, for example: `sed '/PATTERN/d' FILETOSEARCH.txt`

Sed can use the same `^` and `$` pattern search for the start and finish of a line

We can use multiple search patterns such as: `sed '/^#/d ; /^$/d; s/apache/httpd/' config`

or:  `sed -e '/^#/d' -e '/^$/d' -e 's/apache/httpd/' config`

Now if we had a file with sed commands on each line, we could do as `sed -f FILENAME.sed config`

Or specify a line: `sed '2s/apache/httpd/' config`

Or lines that contain a specific string `sed '/STRING/ s/apache/httpd/' config` 

Or specify a range to search in `sed '1,4 s/run/execute/' config`