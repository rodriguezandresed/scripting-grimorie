When we add the [CmdletBinding()] to our Params block, our function will now support more parameters, like:

`-Verbose`: Enables the output of Write-Verbose in your function, overriding
the global $VerbosePreference variable.

`-Debug`: Enables the use of Write-Debug in your function.

`-ErrorAction`: Modifies your function’s behavior in the event of an error, and
overrides the global $ErrorActionPreference variable.

`-ErrorVariable`: Lets you specify a variable name in which PowerShell will
capture any errors your function generates.

`-InformationAction`: Overrides the global $InformationPreference variable,
and enables Write-Information output. 

`-InformationVariable`: Specifies a variable in which output from WriteInformation will be captured.

`-OutVariable`: Specifies a variable in which PowerShell will place copies of your function’s output, while also sending copies into the main pipeline. 

`-PipelineVariable`: Specifies a variable, in which PowerShell will store a copy of the current pipeline element. We’ll cover this more in our chapter on troubleshooting

Taking as example the script:

```bash
function Get-MachineInfo {
[CmdletBinding()]
Param(
[Parameter(ValueFromPipeline=$True)]
[string[]]$ComputerName,
[string]$LogFailuresToPath,
[string]$Protocol = "Wsman",
[switch]$ProtocolFallback
)
BEGIN {}
PROCESS {
foreach ($computer in $computername) {
# Establish session protocol
if ($protocol -eq 'Dcom') {
$option = New-CimSessionOption -Protocol Dcom
} else {
$option = New-CimSessionOption -Protocol Wsman
}
# Connect session
$session = New-CimSession -ComputerName $computer `
-SessionOption $option
# Query data
$os = Get-CimInstance -ClassName Win32_OperatingSystem `
-CimSession $session
# Close session
$session | Remove-CimSession
# Output data
$os | Select-Object -Prop @{n='ComputerName';e={$computer}},
Version,ServicePackMajorVersion
} #foreach
} #PROCESS
END {
#intentionally empty
}
} #function
```

The `ValueFromPipeline` parameter decorator, allows inputs from the pipeline to be used as parameter inputs. This can be enabled only for one parameter per data type (string, etc.)

By using script blocks, now we can allow our function to be ran in pipeline mode, for example:

`Get-MachineInfo -ComputerName One, Two, Three` would run the function in non-pipeline mode, ignoring the script block tags (but not the commands on it).

Now if it was ran like `"One", "Two", "Three" | Get-MachineInfo`, the function would take the three element array and execute the BEGIN block for each command in the pipeline, then the PROCESS and END block

We can add parameter validation by using `ValidateSet` as: 


```bash
[CmdletBinding()]
Param(
[Parameter(ValueFromPipeline=$True,
Mandatory=$True)]
[string[]]$ComputerName,
[string]$LogFailuresToPath,
[ValidateSet('Wsman','Dcom')]
[string]$Protocol = "Wsman",
[switch]$ProtocolFallback
)
```

This will now disallow any values that aren't in the list, and even tab complete those values for users. We can look up other validation methods using `about_functions_advanced_parameters`

We can also add aliases to parameters to make it easier for users to type our function:

```bash
[CmdletBinding()]
Param(
[Parameter(ValueFromPipeline=$True,
Mandatory=$True)]
[Alias('CN','MachineName','Name')]
[string[]]$ComputerName,
[string]$LogFailuresToPath,
[ValidateSet('Wsman','Dcom')]
[string]$Protocol = "Wsman",
[switch]$ProtocolFallback
)
```


We can also add ways to simulate what would happen if we executed our function using `-Confirm` and `-WhatIf`, by adding `SupportsShouldProcess` to `CmdletBinding`

```bash
Function Set-Something {
[CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
Param(
)
} #function
```

The ConfirmImpact makes it so it can compare its value to the `$ConfirmPreference` variable, so that if the specified setting is equal or greater than the content of the `$ConfirmPreference` variable, then the -Confirm parameter is automatically added.

