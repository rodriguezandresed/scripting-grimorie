As a starting point, we will use the script:

```bash
<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses CIM to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
Listing 20.1 Starting point: Get-DiskInventory.ps1250 CHAPTER 20 Improving your parameterized script
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -ComputerName SRV02 -drivetype 3
#>
param (
$computername = 'localhost',
$drivetype = 3
)
Get-CimInstance -class Win32_LogicalDisk -ComputerName $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Select-Object -property DeviceID,
@{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

We use `Select-Object` to allow formating of the output such as:

`.\Get-DiskInventory | Format Table` or `.\Get-DiskInventory | Export-CVS disks.csv`

We can turn our script into an advanced script by using the `[CmdletBinding()] at the end of the command-based help, so our script would end like:


```bash
<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
Listing 20.2 Making Get-DiskInventory.ps1 an advanced script
Notice the Select-Object as
opposed to Format-Table
we used in chapter 19.Making parameters mandatory 251
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -ComputerName SRV02 -drivetype 3
#>
[CmdletBinding()]
param (
$computername = 'localhost',
$drivetype = 3
)
Get-CimInstance -class Win32_LogicalDisk -ComputerName $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Select-Object -property DeviceID,
@{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

Now we could add more settings like, making a parameter mandatory using `[Parameter(Mandatory=$True)]`

And it would look like:

```bash
[CmdletBinding()]
param (
[Parameter(Mandatory=$True)]
[string]$computername,
[int]$drivetype = 3
)
Get-CimInstance -class Win32_LogicalDisk -ComputerName $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Select-Object -property DeviceID,
@{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
```

We could change the mandatory parameter to actually prompt a message `[Parameter(Mandatory=$True,HelpMessage="Enter a computer name to query")`

We can also add aliases to parameters, such as adding another name to computername, so instead of `-ComputerName`, we could also type `-host`

```bash
param (
[Parameter(Mandatory=$True)]
[Alias('host')]
[string]$computername,
[int]$drivetype = 3
)
```

We could run our script as  `.\Get-DiskInventory -host SRV02`

Note that these changes are only made to the computername parameter, if we wanted to add more settings to the drivetype parameter, we would need to add the lines on its section (between commas).

For example, if we wanted to add validation to the drivetype parameter, we would:

```bash
param (
[Parameter(Mandatory=$True)]
[Alias('hostname')]
[string]$computername,
[ValidateSet(2,3)]
[int]$drivetype = 3
)
```

So it would only accept the values 2 and 3, being 3 the default

We can see more validation techniques using `help about_functions_advanced_parameters`.

A final touch to our script would be adding verbose messages to let the user know what is happening:

```bash
<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Listing 20.6 Adding verbose output to Get-DiskInventory.ps1
We add [ValidateSet(2,3)] to the script to
tell PowerShell that only two values, 2
and 3, are accepted by our -drivetype
parameter and that 3 is the default.256 CHAPTER 20 Improving your parameterized script
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -ComputerName SRV02 -drivetype 3
#>
[CmdletBinding()]
param (
[Parameter(Mandatory=$True)]
[Alias('hostname')]
[string]$computername,
[ValidateSet(2,3)]
[int]$drivetype = 3
)
Write-Verbose "Connecting to $computername"
Write-Verbose "Looking for drive type $drivetype"
Get-CimInstance -class Win32_LogicalDisk -ComputerName $computername `
-filter "drivetype=$drivetype" |
Sort-Object -property DeviceID |
Select-Object -property DeviceID,
@{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
Write-Verbose "Finished running command"
```

Now, we would get the messages if we ran it as `.\Get-DiskInventory -ComputerName localhost -verbose`

Another example:

```bash
<#
.Synopsis
Get physical network adapters
.Description
Display all physical adapters from the Win32_NetworkAdapter class.
.Parameter Computername
The name of the computer to check.
.Example
PS C:\> c:\scripts\Get-PhysicalAdapters -computer SERVER01
#>
[cmdletbinding()]
Param (
[Parameter(Mandatory=$True,HelpMessage="Enter a computername to query")]
[alias('host')]
[string]$Computername
)
```






