The PowerShell pipeline contains six channels:

1. Success (which is the one we're used to)

2. Error

3. Warning

4. Verbose

5. Debug 

6. Information

Each number is used for redirection purposes

We can set the preferences of the output of each channel by using for example:  `$WarningPreference`, `$ErrorPreference` and so on.

We could set these variables to `Continue` so it will display the output in whatever way we define, or `SilentlyContinue` will suppress the pipeline output.

Note: we can use the `pscustomobject` accelerator to instead of using `New-Object`, we make a hashtable using it.

```bash
$obj = [pscustomobject]@{'ComputerName'=$computer
'OSVersion'=$os.version
'SPVersion'=$os.servicepackmajorversion
'OSBuild'=$os.buildnumber
'Manufacturer'=$cs.manufacturer
'Model'=$cs.model
'Procs'=$cs.numberofprocessors
'Cores'=$cs.numberoflogicalprocessors
'RAM'=($cs.totalphysicalmemory / 1GB)
'Arch'=$proc.addresswidth
'SysDriveFreeSpace'=$drive.freespace}
Write-Output $obj
```

instead of 

```bash
# Output data
$props = @{'ComputerName'=$computer
'OSVersion'=$os.version
'SPVersion'=$os.servicepackmajorversion
'OSBuild'=$os.buildnumber
'Manufacturer'=$cs.manufacturer
'Model'=$cs.model116 CHAPTER 12 Objects: the best kind of output
'Procs'=$cs.numberofprocessors
'Cores'=$cs.numberoflogicalprocessors
'RAM'=($cs.totalphysicalmemory / 1GB)
'Arch'=$proc.addresswidth
'SysDriveFreeSpace'=$drive.freespace}
$obj = New-Object -TypeName PSObject -Property $props
```

We type verbose or warning messages as: `Write-Warning "Danger, Zone" or `Write-Verbose "this is a verbose"`, we should use verbose messages to say what our tool is doing

For example:

```bash
Write-Verbose "Execution Metadata:"
Write-Verbose "User = $($env:userdomain)\$($env:USERNAME)"
$id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$IsAdmin = [System.Security.Principal.WindowsPrincipal]::new($id).IsInRole(
? 'administrators')
Write-Verbose "Is Admin = $IsAdmin"
Write-Verbose "Computername = $env:COMPUTERNAME"
Write-Verbose "OS = $((Get-CimInstance Win32_Operatingsystem).Caption)"
Write-Verbose "Host = $($host.Name)"
Write-Verbose "PSVersion = $($PSVersionTable.PSVersion)"
Write-Verbose "Runtime = $(Get-Date)"
```

When this is executed, we’ll get potentially useful information:

```bash
VERBOSE: Execution Metadata:
VERBOSE: User = WIN81-ENT-01\Jeff
VERBOSE: Is Admin = False
VERBOSE: Computername = WIN81-ENT-01
VERBOSE: Perform operation 'Enumerate CimInstances' with following
parameters, ''namespaceName' = root\cimv2,'className' =
Win32_Operatingsystem'.
VERBOSE: Operation 'Enumerate CimInstances' complete.
VERBOSE: OS = Microsoft Windows 8.1 Enterprise
VERBOSE: Host = Windows PowerShell ISE Host
VERBOSE: PSVersion = 5.0.10586.117
VERBOSE: Runtime = 01/03/2017 15:05:50
```

Another trick is adding the block names to the verbose messages so we can know where the cmdlet is currently executing, for example:

```bash
Function TryMe {
[cmdletbinding()]
Param(
[string]$Computername
)
Begin {
Write-Verbose "[BEGIN ] Starting: $($MyInvocation.Mycommand)"
Write-Verbose "[BEGIN ] Initializing array"
$a = @()
} #begin
Process {
Write-Verbose "[PROCESS] Processing $Computername"
# code goes here
} #process
End {
Write-Verbose "[END ] Ending: $($MyInvocation.Mycommand)"
} #end
} #function
```

So we output would be:

```bash
tryme -Computername FOO -Verbose
VERBOSE: [BEGIN ] Starting: TryMe
VERBOSE: [BEGIN ] Initializing array
VERBOSE: [PROCESS] Processing FOO
VERBOSE: [END ] Ending: TryMe
```

We can further improve this by adding timestamps such as `Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN ] Starting:
? $($MyInvocation.Mycommand)"`

So it would output like `VERBOSE: [15:18:55.3840626 BEGIN ] Starting: TryMe`