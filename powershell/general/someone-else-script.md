Using as an example: the Get-AdExistence.ps1 script made by Brett Miller

```bash
<#
.Synopsis
Checks if computer account exists for computer names provided
.DESCRIPTION
Checks if computer account exists for computer names provided
.EXAMPLE
Get-ADExistence $computers
.EXAMPLE
Get-ADExistence "computer1","computer2"
#>
function Get-ADExistence{
[CmdletBinding()]
Param(
# single or array of machine names
[Parameter(Mandatory=$true,
ValueFromPipeline=$true,
ValueFromPipelineByPropertyName=$true,
HelpMessage="Enter one or multiple computer names")]
[String[]]$Computers
)
Begin{}
Process {
foreach ($computer in $computers) {
try {
$comp = get-adcomputer $computer -ErrorAction stop
$properties = @{computername = $computer
Enabled = $comp.enabled
InAD = 'Yes'}
}
catch {
$properties = @{computername = $computer
Enabled = 'Fat Chance'
InAD = 'No'}
}
finally {
$obj = New-Object -TypeName psobject -Property $properties
Write-Output $obj
}
} #End foreach
} #End Process
End{}
} #End Function
```

By following a line-by-line examination we see that:

1. The parameter computer is mandatory, and it's a string that allows an array.

2. Then it takes that variable and runs the `Get-AdComputer` to see if it belongs in an AD, and stores that information in a hash table (@{})

3. The script then takes that table and turns it into a custom ps object to print it to the screen.

Whenever using scripts from someone else, we should always check everyline, run in a VM if we're not really sure of what it will do. And remember the help command