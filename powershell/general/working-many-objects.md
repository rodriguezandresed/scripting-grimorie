One way of working with multiple cmdlets is using batch (piping multiple cmdlets)

For example: `Get-Service BITS, Spooler | Set-Service -startuptype Automatic`

The downside of this approach is that it doesn't indicates that it has done its job.

We could use the `-PassThru` parameter so it would display what it did at the end.


Example:

Assuming we have intel network adapters the Common Information Model (CIM) class (Since WMI doesn't work with PowerShell 7) is `Win32_NetworkAdapterConfiguration`. This class represents the configurations bound to a network adapter. Assuming we wanted to enable DHCP we could check the CIM class by:

`Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | -Filter "description like '%intel%'" | Format-List`

Then we would need to check if the object has a method capable of enabling DHCP.

Using: `(Get-CimClass Win32_NetworkAdapterConfiguration).CimClassMethods`

We would see the `EnableDHCP` method.

Sadly, piping the object to the method wouldn't work, we ONLY piupe to cmdlets.

What we do is use the cmdlet `Invoke-CimMethod` that accepts a batch of CIM objects (such as the Win32_NetworkAdapterConfiguration)

`Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -filter "description like '%intel%'" | Invoke-CimMethod -MethodName EnableDHCP`

Note: method name isn't case sensitive, `Invoke-CimMethod` only accepts one kind of WMI object at a time, (we can send multiple of the same type)

The output of an `Invoke-CimMethod` returns a value and the computer where it ran on (if blank it's localhost), we then could search for that ReturnValue to see what it means.

If we can get to something using  `Get-CIMInstance` we should use `Invoke-CimMethods`

We can use the `ForEach-Object` to excecute cmdlets from a piped array, for example:

`Get-Content -Path vaultsToCreate.txt | ForEach-Object { New-AzKeyVaultResourceGroupName manning -Location 'UK South' -Name $_ }`

We can speed up the process of ForEach using the parameter `-Parallel`

We could measure the running time of a script using `Measure-Command { the script we want to time}`

For example:

`Measure-Command {Get-Content -Path vaultsToCreate.txt | ForEach-Object -Process {Write-Output $_ Start-Sleep 1 }}`

This lasted 5 seconds, now using `-Parallel` instead of `-Process`

`Measure-Command {Get-Content -Path vaultsToCreate.txt | ForEach-Object -Parallel { Write-Output $_
 Start-Sleep 1 }}`

It only took one second.

By default, `-Parallel` with `ForEach` will only run 5 script blocks in parallel (throttle limit) and it can be adjusted using the  `-ThrottleLimit` parameter

For example:

`Measure-Command { Get-Content -Path vaultsToCreate.txt | ForEach-Object -ThrottleLimit 10 -Process {
Write-Output $_ Start-Sleep 1}}

Note: remember to pipe objects to `Get-Member` to reveal methods

$_ represents the current object in the pipeline.

Excecuting a method: `Get-ChildItem *deleteme* | foreach {$_.Delete()}`