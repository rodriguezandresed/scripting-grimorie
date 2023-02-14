Regex Syntax examples:

Certain characters, however, have special meaning within a regex, and they enable
you to detect patterns of variable text. Here are some examples:

`\w` matches “word characters,” which means letters, numbers, and underscores,
but no punctuation and no whitespace. The regex \won would match Don, Ron,
and ton, with the \w standing in for any single letter, number, or underscore.

`\W` matches the opposite of \w (so this is one example where PowerShell is sensitive to case), meaning it matches whitespace and punctuation—“nonword characters,” in the parlance.

`\d` matches any digit from 0 through 9 inclusive.

`\D` matches any nondigit.

`\s` matches any whitespace character, including a tab, space, or carriage return.

`\S` matches any nonwhitespace character.

`.` (a period) stands in for any single character.

`[abcde]` matches any character in that set. The regex c[aeiou]r would match
car and cur, but not caun or coir.

`[a-z]` matches one or more characters in that range. You can specify multiple
ranges as comma-separated lists, such as [a-f,m-z].

`[^abcde]` matches one or more characters that are not in that set, meaning the
regex d[^aeiou] would match dns but not don.

`?` follows another literal or special character and matches exactly one instance
of that character. So, the regex ca?r would match car but would not match
coir. It would also match ca because ? can also match zero instances of the preceding character.

`*` matches any number of instances of the preceding character. The regex ca*r
would match both cair and car. It would also match ca because * also matches
zero instances of the preceding character.

`+` matches one or more instances of the preceding character. You’ll see this used
a lot with parentheses, which create a sort of subexpression. For example, the regex (ca)+r would match cacacacar because it matches repeating instances of the ca subexpression.

`\` (backslash) is the regex escape character. Use it in front of a character that
normally has special meaning in the regex syntax, to make that character a literal. For example, the regex \. would match a literal period character, rather than allowing the period to stand in for any single character, as it normally does. To match a literal backslash, escape it with a backslash: \\.

`{2}` matches exactly that many instances of the preceding character. For example, \d{1} matches exactly one digit. Use {2,} to match two or more, and use {1,3} to match at least one, but no more than three.

`^` matches the beginning of the string. For example, the regex c.r would match
car as well as pteranocar. But the regex ^c.r would match car but would not
match pteranocar because the ^ makes the matching occur at the beginning of
the string. This is a different use of ^ than in the previous example, where it was
used with square brackets, [], to indicate a negative match.

`$` matches the end of the string. For example, the regex .icks would match
hicks and sticks (the match would technically be on ticks in that example),
and would also match Dickson. But the regex .icks$ would not match Dickson
because the $ indicates that the string should reach its end after the s.

Example of combinations:

`d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}` matches the pattern of an IPv4
address, although it’ll accept illegal data like 432.567.875.000, as well as legal
data like 192.169.15.12.

`\\\\\w+(\\\w+)+` matches a Universal Naming Convention (UNC) path. All
the backslashes make that regex hard to read—which is one reason it’s important to test and tweak your regular expressions before you rely on them in a production task.

`\w{1}\.\w+@company\.com` matches a specific type of email address: first initial,
a period, last name, and then @company.com. For example, sam.smith@company
.com would be a valid match. You do have to be a bit careful with these. For
example, Samuel.smith@company.com.org or Smith@company.com.net would
also be a valid match. The regex is fine with there being extra text before and
after the matched portion. That’s where the ^ and $ anchors come into play in
many situations

We can find more help about regex syntax by typing `help about_regular_expressions`

We can use regex in combination with the case sensitive comparisor operator `-Match`:

Example: 


```bash
"car" -match "c[aeiou]r"
True
"caaar" -match "c[aeiou]r"
False
"caaar" -match "c[aeiou]+r"
True
"cjinr" -match "c[aeiou]+r"
False
"cear" -match "c[aeiou]r"
False
```

For example: if we wanted to filter a weblog for errors we could: \

```bash
get-childitem -filter *.log -recurse |
select-string -pattern "\s40[0-9]\s" |
format-table Filename,LineNumber,Line -wrap
```

Example: if we wanted to seek Gecko-based browsers, for window users whose string looks like:

`(Windows+NT+10.0;+WOW64;+rv:11.0)+Gecko`

`get-childitem -filter *.log -recurse | Select-string -pattern "10\.0;[\w\W]+\+Gecko`

where: 

`10\.0;` This is 10.0. Notice that we escaped the period to make it a literal character rather than the single-character wildcard that a period normally indicates.

`[\w\W]+` This is one or more word or nonword characters (in other words,
anything).

`\+Gecko` This is a literal +, then Gecko.

Another example would be if we wanted to see all events with ID 4624 on IIS, related to all account ending in TM20$ to TM40$

It would end like: `get-eventlog -LogName security | where { $_.eventid -eq 4624 } |
select -ExpandProperty message | select-string -pattern "WIN[\W\w]+TM[234][0-9]\$`

If we wanted to show the entire event:

`get-eventlog -LogName security | where { $_.eventid -eq 4624 -and ? $_.message -match "WIN[\W\w]+TM[234][0-9]\$" }`

Examples: 

1. Matching all files that have a two-digit number as part of the name:

 `Get-ChildItem c:\windows | where {$_.name -match "\d{2}"}`
 `Get-ChildItem /usr | where {$_.name -match "\d{2}"}`

2. Show all modules installed from Microsoft, displaying name, version number, author and company name

	`Get-Module | Where {$_.name -match "Microsoft[\W\w]*"} | Select Name, Version, Author, Company`
	`Get-Module | where {$_.companyname -match "^Microsoft"} | Select Name, Version, Author, Company`
	
3. Display lines where a package was installed (linux) or windows update installed packages

    `Get-Content C:\Windows\WindowsUpdate.log | Select-string "[\w\W+]Installing Update"` For Windows
	`Get-Content ./apt/history.log | select-string "[\w\W+]Installing"

4. Display all listings of Get-DNSClientCache where the Data property is an IPv4 address

	`Get-DNSClientCache | where { $_.data -match "^\d{1,3}\."}`
	`Get-DNSClientCache | where { $._ data -match "^\d(1,3)\.\d(1,3)\.\d(1,3)\.\d(1,3)\"}`

5. List all the HOSTS file that contain IPV4 address

`gc /etc/hosts | where {$_ -match""^\d(1,3)\.\d(1,3)\.\d(1,3)\.\d(1,3)\"}


Websites to help with regex:

https://regexlib.com/

https://www.regextester.com/
