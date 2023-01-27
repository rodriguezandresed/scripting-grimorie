The formatting for the output of cmdlets are stored in files with the `.format.ps1xml` format.

We can find them in the Modules folder. 

Note: for CentOS the folders for powershell are stored in `/ont/`

We can point to new templates using `Update-TypeData -Path /tmp/Uri.Types.ps1xml`

We also have a cmdlet called `Format-Table` or `ft`, it's parameters work like this:

`-Property` This parameter allows us to specify the name of the columns and specify which columns we want to see, it's positional so we don't actually need to type it, it also allows wildcards

Examples:

```bash

Get-Process | Format-Table -Property *

Get-Process | Format-Table -Property ID,Name,Responding

Get-Process | Format-Table * 
```

`-GroupBy` This parameter generates a new set of column headers each time the specified property value changes. (It shows for example 2 sets of output for `-GroupBy PowerState` would show Azure VM running and VM deallocated) 

`-Wrap` It makes it so that if PS has to truncate information in a column, it will end that column with elipses ( . . . ) to visually indicate that the information was suppressed.

When we want to format horizontally, we can use the cmdlet `Format-List` or `fl`. It also uses the 
`-Property` parameter same as `-Format-Table`

The cmdlet `Format-Wide` or `fw` allows the display of a wider, multicolumn list, it's only able to display the value of a single property so the `-Property` parameter will only accept one name and it can't accept wildcards.

We can use hashtables to display different column headers such as: 

`Get-AzStorageAccount | Format-Table @{name='Name';expression=
{$_.StorageAccountName}},Location,ResourceGroupName`

Or inputting mathematical expressions such as : 

`Get-Process | Format-Table Name, @{name='VM(MB)';expression={$_.VM / 1MB -as [int]}}`

Unlike `Select-Object`, whose hash tables can accept only a Name and Expression key
(although they’ll also accept N, L, and Label for Name, and will accept E for Expression),
the `Format-` commands can handle additional keys that are intended to control the
visual display. These additional keys are most useful with `Format-Table`:

`FormatString` specifies a formatting code, causing the data to be displayed
according to the specified format. This is mainly useful with numeric and date
data. 

`Width` specifies the desired column width.

`Alignment` specifies the desired column alignment, either Left or Right.

So we can recreate the previous example: 

```bash 
Get-Process |
Format-Table Name,
@{name='VM(MB)';expression={$_.VM};formatstring='F2';align='right'}
-AutoSize
```

We can see graphically outputs using the module for Graphical Tools:

Installed by `Install-Module Microsoft.PowerShell.GraphicalTools`

And we could see it Get-Processs | Out-GridView


ALLWAYS REMEMBER that the output of a formatted pipeline is going to Out-Default, so if you're exporting to a file, keep the format cmdlet before Out-File, otherwise format always goes last

For example:

`Get-History | Select-Object Id,Duration,CommandLine | ConvertTo-Html | Format-Table | Out-File history.html`

When formatting try to maintain the same kind of objects into the pipeline, if it contains two or more kind of objects, the output won't always be complete or useful.

For example: we could use `Get-Process ; Get-History` and it will run both commands indepentendly and push the 2 outputs into the pipeline
