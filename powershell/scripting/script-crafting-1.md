Example of script building:

```bash
function Get-MachineInfo {
Param(
[string[]]$ComputerName,
[string]$LogFailuresToPath,
[string]$Protocol = "wsman",
[switch]$ProtocolFallback
)}
```

When we use the [switch] type, it means that it will contain $True if the command is run with the parameter or $False if not.

Continuin the script: 

```bash
foreach ($computer in $computername) {
# Establish session protocol
if ($protocol -eq 'Dcom') {
$option = New-CimSessionOption -Protocol Dcom
} else {
$option = New-CimSessionOption -Protocol Wsman
}
$session = New-CimSession -ComputerName $computer -SessionOption $option
# Query data
$os = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession
? $session
# Close session
$session | Remove-CimSession
# Output data
$os | Select-Object -Prop @{n='ComputerName';e={$computer}},
Version,ServicePackMajorVersion
} #foreach
} #function
```bash

It's a good practice to add comments to the closing brackets to know what they do.

When we have our script done, we should save it on the path located in `$env:psmodulepath`, for us to save our scripts, we need to save them inside a folder which will have the same name as the script (for example, ScriptPC.psm1 and folder ScriptPC) for PowerShell to recognize it as a Module.

When we make changes to our scripts that we've already imported, we won't see those changes because the scripts are loaded into the memory, thus, they aren't ran from disk, so if we make any changes we need to either:

Close the current PowerShell window and open another one and unload the script using `Remove-Module SCRIPTNAME` and reload the module.

Or try to manually force the reimport using `Import-Module ScriptingMOL -force`

When we specify params of a script we can validate if the user used those parameters by checking the `$PSBoundParameters` keys from the `$PSBoundParameters` hashtable, for example:

`IF ($PSBoundParameters.ContainsKey('ComputerName')){do something} else {something else}`