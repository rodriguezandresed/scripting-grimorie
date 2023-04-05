First we take our script for example `Test.psm1` and put it on the modules 
folder `/Documents/WindowsPowerShell/Modules` so the complete directory would be `/Documents/WindowsPowerShell/Modules/Test/Test.psm1`

And using this as the test script:

```bash
function Get-DiskInfo {
foreach ($domain in (Get-ADForest).domains) {
$hosts = Get-ADDomainController -filter * -server $domain |
Sort-Object -Prop hostname
ForEach ($host in $hosts) {
$cs = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $host
$props = @{'ComputerName' = $host
'DomainController' = $host
'Manufacturer' = $cs.manufacturer
'Model' = $cs.model
'TotalPhysicalMemory'=$cs.totalphysicalmemory / 1GB
}
$obj = New-Object -Type PSObject -Prop $props
$obj.psobject.typenames.insert(0,'Toolmaking.DiskInfo')
Write-Output $obj
} #foreach $host
} #foreach $domain
} #function
Export-ModuleMember -function Get-DiskInfo
```

On `cd $pshome` directory, we open the file named `dotnettypes.format` as this file contains most of the views for the core object types PS works with.

```bash
<?xml version="1.0" encoding="utf-8" ?>
<!-- *******************************************************************
These sample files contain formatting information used by the Windows
PowerShell engine. Do not edit or change the contents of this file
directly. Please see the Windows PowerShell documentation or type
Get-Help Update-FormatData for more information.
Copyright (c) Microsoft Corporation. All rights reserved.
THIS SAMPLE CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
OF ANY KIND,WHETHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR
PURPOSE. IF THIS CODE AND INFORMATION IS MODIFIED, THE ENTIRE RISK OF USE
OR RESULTS IN CONNECTION WITH THE USE OF THIS CODE AND INFORMATION
REMAINS WITH THE USER.
******************************************************************** -->
<Configuration>
<ViewDefinitions>
``` 

Here the first and last two lines are the most important for our own files.

So we would create a file named `TestViews.format.ps1xml` on our Test directory.

We would have:

```bash
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>
</ViewDefinitions>
</Configuration>
```

Then we would add as needed:

```bash
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>
<View>
<Name>DiskInfo</Name>
<ViewSelectedBy>
<TypeName>Toolmaking.DiskInfo</TypeName>
</ViewSelectedBy>
<TableControl>
<TableHeaders>
<TableColumnHeader>
<Label>Host</Label>
<Width>16</Width>
</TableColumnHeader>
<TableColumnHeader>
<Label>DC</Label>
<Width>16</Width>
</TableColumnHeader>
<TableColumnHeader>
<Label>Model</Label>
</TableColumnHeader>
<TableColumnHeader>
<Label>RAM</Label>
<Alignment>Right</Alignment>
</TableColumnHeader>
</TableHeaders>
<TableRowEntries>
<TableRowEntry>
<TableColumnItems>
<TableColumnItem>
<PropertyName>ComputerName</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>DomainController</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>Model</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>TotalPhysicalMemory</PropertyName>
</TableColumnItem>
</TableColumnItems>
</TableRowEntry>
</TableRowEntries>
</TableControl>
</View>
</ViewDefinitions>
</Configuration>
```

Note that the `<TableColumnHeader/>` closes and opens itself, it's declaring the number of columns it should have (by the number of times it makes an appearance and the number of the entries from the script) 

Then we would need to create the manifest to specify the format view as `new-modulemanifest -Path test.psd1 -RootModule test.psm1` 

And edit to point to our file:

```bash
# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @('./TestView.format.ps1xml')
```

Another example:

```bash
function Get-MachineInfo {
[CmdletBinding()]
Param(
[Parameter(ValueFromPipeline=$True,
Mandatory=$True)]
[Alias('CN','MachineName','Name')]
[string[]]$ComputerName,
[ValidateSet('Wsman','Dcom')]
[string]$Protocol = "Wsman"
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
# Close session
$session | Remove-CimSession
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
$obj.psobject.typenames.insert('Toolmaking.MachineInfo')
Write-Output $obj
} #foreach
} #PROCESS
END {}
} #function
```

And the view:

```bash
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>
<View>
<Name>MachineInfo</Name>
<ViewSelectedBy>
<TypeName>Toolmaking.MachineInfo</TypeName>
</ViewSelectedBy>
<TableControl>
<TableHeaders>
<TableColumnHeader>
<Label>ComputerName</Label>
</TableColumnHeader>
<TableColumnHeader>
<Label>OSVersion</Label>
</TableColumnHeader>
<TableColumnHeader>
<Label>Model</Label>
</TableColumnHeader>
<TableColumnHeader>
<Label>Cores</Label>
<Alignment>Right</Alignment>
</TableColumnHeader>
<TableColumnHeader>
<Label>RAM</Label>
<Alignment>Right</Alignment>
</TableColumnHeader>
</TableHeaders>
<TableRowEntries>
<TableRowEntry>
<TableColumnItems>
<TableColumnItem>
<PropertyName>ComputerName</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>OSVersion</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>Model</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>Cores</PropertyName>
</TableColumnItem>
<TableColumnItem>
<PropertyName>RAM</PropertyName>
</TableColumnItem>
</TableColumnItems>
</TableRowEntry>
</TableRowEntries>
</TableControl>
</View>
</ViewDefinitions>
</Configuration>
```