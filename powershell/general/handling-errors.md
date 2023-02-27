A variable called $Error exists that contains an array of all the error objects that have ocurred in the current session, where the most recent error is stored in $Error[0].

This is an automatic variable and we can read more about it in `get-help about_automatic_variables`

The `ErrorVariable` is another built-in variable that can be used to send errors to, so they can be used later if needed to write a log file.

Example: `New-PSSesion -ComputerName SRV01 -ErrorVariable a`

By default it will only store the most recent error unless we add a plus sign in front of it:

Example: `New-PSSesion -ComputerName SRV01 -ErrorVariable +a`

By default, PowerShell won't stop for an error, if it can keep executing cmdlets, it will finish all the pending jobs. These kind of errors are called nonterminating errors, we can change the behaviour of PowerShell by changing the `$ErrorActionPreference` variable, it has a default value of `Continue`

Its options are:

`Break` - Enter the debugger when an error occurs or when an exception is raised.

`Continue` (default) - Displays the error message and continues executing.

`Ignore` - Suppresses the error message and continues to execute the command. The Ignore value is intended for per-command use, not for use as a saved preference. Ignore isn’t a valid value for the $ErrorActionPreference variable.

`Inquire` - Displays the error message and asks you whether you want to continue.

`SilentlyContinue` - No effect. The error message isn’t displayed, and execution continues without interruption.

`Stop` - Displays the error message and stops executing. In addition to the error
generated, the Stop value generates an ActionPreferenceStopException object to the error stream.

`Suspend` - Automatically suspends a workflow job to allow for further investigation. After investigation, the workflow can be resumed. The Suspend value is intended for per-command use, not for use as a saved preference. Suspend isn’t a valid value for the $ErrorActionPreference variable.

Rather than changing this variable globally, we can specify a behaviour per command basis, such as:

`Get-Service -Name Foo, BITS, Nobody, WinRM -ErrorAction Inquire`

We can't handle exceptions unless PowerShell generates an exception, and most commands won't generate an exception unless we run them with the `Stop` error actionm we should always add `-EA Stop` to a command whenever we want to handle a problem.

Good practices:

Do NOT set the ErrorActionPreference globally, instead change it per command basis.

Do NOT silence errors unless you know what kind of errors may ocurr. (For example, silencing errors about files that do exist and you don't have permission to delete)

For example: adding error to a remote connection script:

```bash
$computer = 'Srv01','DC01','Web02'
Write-Verbose "Connecting to $computer"
$session = New-PSSession -ComputerName $computer -ErrorAction Stop
```

If we wanted to allow the error to occur on one of the devices: 

```bash
foreach ($computer in $computername) {
Write-Verbose "Connecting to $computer"
$session = New-PSSession -ComputerName $Computer -ErrorAction Stop
}
```

or 

```bash
$computer = 'Srv01','DC01','Web02'
$session = New-PSSession -ComputerName $Computer -ErrorVariable a
```

We can use the try/catch constructs to handle errors, if an exception occurs in the Try block, then all the subsequent code in the Try block will be skipped and the catch block will be executed instead.

Example:

```bash
try { blahfoo }
catch { Write-Warning “Warning: An error occurred." }
```

Whenever we're in front of something that doesn't have an `-ErrorAction` parameter, we can run a Try block as:

```bash
Try {
$ErrorActionPreference = "Stop"
# run something that doesn't have -ErrorAction
$ErrorActionPreference = "Continue"
} Catch {
# ...
}
```

We can also have multiple catch blocks as: 

```bash
Try {
# something here generates an exception
} Catch [Exception.Type.One] {
# deal with that exception here
} Catch [Exception.Type.Two] {
# deal with the other exception here
} Catch {
# deal with anything else here
} Finally {
# run something else
}
```

Note that the `Finally` block will always run after a try or catch, whether or not an exception occurs.

There's the Big Book of PowerShell Error Handling that can be used, made by PowerShell

If we wanted to get the uptime of computers:

```bash
Function Get-PCUpTime {
param (
[string[]]$ComputerName = 'localhost'
)
try {
foreach ($computer in $computerName) {
If ($computer -eq "localhost") {
Get-Uptime
}
Else { Invoke-command -ComputerName $computer -ScriptBlock
? { Get-Uptime } -ErrorAction Stop}
}
}
catch {
Write-Error "Cannot connect To $computer"
}
}
```


