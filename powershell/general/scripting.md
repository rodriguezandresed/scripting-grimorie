Taking as an example:

We write our commands so that each line ends in a pipe or a comma, so that PowerShell will interpret it as an one lined command.

```bash
Get-CimInstance -class Win32_LogicalDisk -computername localhost `
-filter "drivetype=3" | Sort-Object -property DeviceID |
Format-Table -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

```

We save our scripts as cmdlet style verb-noun names, for example, the previous example could be called `Get-DiskInventory.ps1`

We can further improve our script by starting to add variables, that way it becomes more useable by other users:

Note: remember we can break a line using a backtick (`)

```bash
$computername = 'localhost'
Get-CimInstance -class Win32_LogicalDisk `
-computername $computername `
-filter "drivetype=3" |
Sort-Object -property DeviceID |
Format-Table -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

Another example: 

```bash
$filePath = '/usr/bin/'
get-childitem -path $filepath | get-filehash |
Sort-Object hash | Select-Object -first 1
```

Note: ways we can break lines:

Complete command: 

`Get-Process | Sort-Object`

1st way (Using pipes):

```bash
Get-Process |
Sort-Object
```

2nd way (Using backtick)

```bash
Get-Process `
| Sort-Object
```

We can further edit our script by making the variables as input parameters using the `Param()` blocks around the variable declaration, that way, the script will run with the default variable value stated on the param block if no other value was defined.

```bash
param (
$computername = 'localhost'
)
Get-CimInstance -class Win32_LogicalDisk -computername $computername `
-filter "drivetype=3" |
Sort-Object -property DeviceID |
Format-Table -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

This way, now the parameter declared is positional, so the script can be run as:

```bash
.\Get-DiskInventory.ps1 SRV-02
.\Get-DiskInventory.ps1 -computername SRV02
.\Get-DiskInventory.ps1 -comp SRV02
```

Note that we need to specify the directory where the script is located in order to execute it.

We can define as many parameters as we need by separating them with commas.

For example:

```bash
param (
$computername = 'localhost',
$drivetype = 3
)
Get-CimInstance -class Win32_LogicalDisk -computername $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Format-Table -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

We could call the script as:

```bash
.\Get-DiskInventory.ps1 SRV1 3
.\Get-DiskInventory.ps1 -ComputerName SRV1 -drive 3
.\Get-DiskInventory.ps1 SRV1
.\Get-DiskInventory.ps1 -drive 3
```

We can comment our scripts using the `<# #>` block comment syntax and the command-based helps, using the .keywords, for a full list, we can run `help about_comment_based_help` . 

```bash
<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses CIM to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SRV02 -drivetype 3
#>
param (
$computername = 'localhost',
$drivetype = 3
)
Get-CimInstance -class Win32_LogicalDisk -computername $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Format-Table -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

Now we could use `Get-Help .\Get-DiskInventory.ps1` and we would ge the help for our script.

One thing to be aware of is scopes, it means that if we don't define our variables in the script, PowerShell will look in the global scope (out of the environment of our script) to get variables that may or may not be correct.