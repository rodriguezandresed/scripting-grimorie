Splatting: It's a technique where we construct a hash table whose keys are parameters name whose values are the corresponding parameter values.

For example: we take our parameters and put them in each line

```bash
$params = @{'ClassName'='Win32_OperatingSystem'
'ComputerName'='CLIENT1'}
```

Then for switch parameters we assign a value of True

```bash
$params = @{'ClassName'='Win32_OperatingSystem'
'ComputerName'='CLIENT1'
'Verbose' = $True}
```

Then we feed those values to the command by prefixing the variable name with @ instead of $

`Get-CimInstance @params`

So it would end up with a code that queries the information we need into variables:

```bash 
# Query data
$os_params = @{'ClassName'='Win32_OperatingSystem'
'CimSession'=$session}
$os = Get-CimInstance @os_params
$cs_params = @{'ClassName'='Win32_ComputerSystem'
'CimSession'=$session}
$cs = Get-CimInstance @cs_params
$sysdrive = $os.SystemDrive
$drive_params = @{'ClassName'='Win32_LogicalDisk'
'Filter'="DeviceId='$sysdrive'"
'CimSession'=$session}
$drive = Get-CimInstance @drive_params
$proc_params = @{'ClassName'='Win32_Processor'
'CimSession'=$session}
$proc = Get-CimInstance @proc_params |
Select-Object -first 1
```

To output data we can use props to output objects:

```bash
# Output data
$props = @{'ComputerName'=$computer
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
$obj = New-Object -TypeName PSObject -Property $props
Write-Output $obj
```

Another alternative could be creating custom objects using a type accelerator `[pscustomobject]`

```bash
[pscustomobject]@{
Name = 'Jason'
Department = 'IT'
Computername = 'LV-130'
Expires = (Get-Date).AddDays(90)
}
```

Another example: 

`[pscustomobject]@{Name='bits';computername='chi-hvr2'} | get-service`

We can add properties to our objects using  `Add-Member` such as: 

`[pscustomobject]@{Name='bits';computername='chi-hvr2'} | get-service`


