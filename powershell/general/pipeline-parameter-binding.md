Method A (ByValue):

Pipelining input by value: with this method PS looks at the type of object producided by the command A and then tries to see whether any parameter of Command B can accept that type of object from the pipeline. 

We can determine this by ourselves by seeing the members of the output of command A then seeing the help of Command B to see if it accepts any type of data from the pipeline ByValue.

Example: 

Being `Command A | Command B`

`Get-Content.\modules.txt | Get-Command`

`Get-Content.\modules.txt | Get-Member` would allows us to see at the start of the output that its TypeName is a System.String

Then using `Get-Help | Get-Command -Full` that the parameter -Name, -Noun, etc allows String as an input value.

Example: `Get-ChildItem -File | Stop-Process -WhatIf`

Using `Get-ChildItem | Get-Member` shows that the TypeName is a System.IO.FileInfo

Since `Stop-Process` doesn't accepts `FileInfo` objects the ByValue Method doesn't work .


Method B (ByPropertyName):

This time we take the piped `Get-Member` output of Command A and compare the syntax for Command B and then we try to find a property whose name corresponds to a parameter of Command B.

Taking previous example:

`Get-ChildItem -File | Stop-Process` would work if the names used were actual processes.

Another example:

Creating the file aliastes.txt:

```bash
Name,Value
d,Get-ChildItem
sel,Select-Object
go,Invoke-Command```


`Import-Csv aliases.txt | Get-Member` and we compare it to the syntax for `New-Alias`

We see that we have 2 matches, we can further check if they allow pipelined output by:

`Get-Help New-Alias -Parameter Name`

And since both parameters allow it, the pipeline would work.

The result is three new aliases, named `d`, `sel`, and `go`, which point to the commands
`Get-ChildItem`, `Select-Object`, and `Invoke-Command`, respectively.

Another example would be a badly formatted csv file supposed to be used with New-Aduser

```bash
login, dept, city, title
TylerL,IT,Seattle,IT Engineer
JamesP, IT,Chattanooga, CTO
RobinL,Custodial,Denver,Janitor
```

If we tried to import this file we would get an error because it's missing parameters, so we can:

```bash
import-csv .\newusers.csv |  select-object -property *,
 @{name='samAccountName';expression={$_.login}},
 @{label='Name';expression={$_.login}},
 @{n='Department';e={$_.Dept}}
```

We use `Select-Object` and its -Property parameter. We start by specifying the
property *, which means “all of the existing properties.” Notice that the * is followed by a comma, which means we’re continuing the list of properties.

We then create a hash table, which is the construct starting with `@{` and ending
with `}`. Hash tables consist of one or more key-value pairs, and `Select-Object`
has been programmed to look for specific keys, which we’ll provide to it.

The first key that `Select-Object` wants can be Name, N, Label, or L, and the
value for that key is the name of the property we want to create. In the first hash
table, we specify `samAccountName`; in the second, `Name`; and in the third,
`Department`. These correspond to the parameter names of New-ADUser.

The second key that `Select-Object` needs can be either Expression or E. The
value for this key is a script block, contained within curly brackets `{}`. Within that
script block, you use the special `$_ placeholder` to refer to the existing piped-in
object (the original row of data from the CSV file) followed by a period. The
placeholder `$_` lets you access one property of the piped-in object, or one column of the CSV file. This specifies the contents for the new properties.

Another example would be the output of `Get-Content modules.txt | Get-Command` since the output of command A can't be piped because the string object produced doesn't match the one that the `-Module` parameter uses and instead they go to the -Name parameter

In those cases we use parentheses.

`Get-Command -Module (Get-Content modules.txt)

Powershell interprets parentheses as "do this first" then the result of the parentheses are fed into the `-Module` parameter

Checking the help for `Get-Command` -> `Get-Help Get-Command -Parameter module`

Another example retrieving the value from a single property would be using Azure:

`New-AzResourceGroup -Name name -Location location`

`Get-AzResourceGroup | Get-Member`

Since this command outputs objects of ResourceGroupName we need to extract them, so using `Select-Object` with the `-ExpandProperty` parameter it takes that property, extract its values and returns those values as the output of `Select-Object`

So: ```bash New-AzStorageAccount -ResourceGroupName (Get-AzResourceGroup -Location westus2 | Select-Object -First 1 -ExpandProperty ResourceGroupName) -Name downloads -SkuName Standard_LRS -Location westus2 ```

With `Select-Object -Property`, you’re deciding what boxes you want, but you still have
boxes. With `Select-Object -ExpandProperty`, you’re extracting the contents of the
box and getting rid of the box entirely. You’re left with the contents.


