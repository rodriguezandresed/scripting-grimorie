Absolute Path:

Specific location of a file or directory from the root directory/drive

Example: `C:\Windows\Drivers\abc.ini`


Relative Path: 

Depends on the current directory

Example: `.\My_File.txt`

PS converts the relative paths into absolute paths in the background

------------------------------------------------------

You can use the Resolve-Path command to convert relative path into absolute path


Example: `Resolve-Path .\file1.txt`

We can use wild carded paths to get path of files in bulk!

Example: `Resolve-Path .\file*`

--------------------------------
```bash
.  -> Current Directory

.. -> Parent Directory 

\ -> Root Directory

~ -> Home Directory
```
-------------------------

Joining Paths

Using the command Join-Path combines a path and a child path into a new path

the switch -Resolve may be used to resolve joined paths

Example: `Join-Path "C:\win*"  "System*"  -Resolve`


It can be used to join registry paths too:

Example: `Join-Path -Path "HKLM:\System" -ChildPath *ControlSet* -Resolve`


Multiple paths may be joined wtih a single path

Example: `Join-Path -Path C:, D: -ChildPath NewFolder`


-------------------------------


Split Paths

Returns a specified part of a path

By default the parent path is returned

Example: `Split-Path -Path D:\PSTraining\PracticeGround\File1.txt`

the parameters -Path specifies the path to be split
*
`-LiteralPath is the same as -Path but it doesn't accept wildcards`

Example: `Split-Path -Path ".\*.txt" -Leaf -Resolve`
Example: `-LiteralPath .\file1.txt -Resolve`

`-NoQualifier` is used to get the path without the qualifier 

`-Leaf` is used to get the topmost file/foldername in mentioned path


`-parent` is used to get only the parent container of the item, it's a default parameter so it can be omited

`-IsAbsolute` allows us to see if a path is relatve or absolute, returns True or False boolean

-----------------------------------------------------

Test & Convert paths

This command tells whether all elements of a path exists, the path syntax is valid or if the path leads to a leaf, container or terminal element

It returns a boolean

Example: `Test-Path -Path .\file1.txt`

-Path specifies the path to be tested

-LiteralPath is the same as -Path but it doesn't accept wildcards

-Include -Exclude and -Filter parameters allows us to limit the scope of the path to tested

-Filter appllies a filter before fetching results so it's faster than the others

Example: `Test-Path -Path .\* -Exclude *.txt`

-isValid parameter can be used to test if the syntax of the path (so that there aren't any errors)

Example: `Test-Path -Path ./file6.txt -IsValid`

-NewerThan or -OlderThan switch is used to specify a time filter

Example: `Test-Path -Path .\file1.txt -NewerThan "July 16, 2030"`
Example: `Test-Path -Path .\file1.txt -OlderThan "July 16, 2000"`

-PathType parameter is used to know wether the final element in the path is a particular type or not, the type can be:

Container: directory or registry Key
Leaf: files
Any: Leaf or Container

Example: `Test-Path -Path .\* -PathType Container`
Example: `Test-Path -Path .\new* -PathType Leaf`


**************************************

Convert-Path is used to convert a path from a PowerShell path to a PowerShell Provider path

Example: `Convert-Path ~`

---------------------------------------------------

PowerShell Providers

All data sources are Data Stores such as:

File System, registry, functions, environment, variables

Get-PSPDrive lists all drive for all PS providers by default

-PSProvider parameter is used to specifiy provider for which we need to list drives

Example: `Get-PSPDrive -PSProvider Registry`
Example: `Get-PSPDrive -PSProvider FileSystem`

*******************

We can use the `New-PSDrive` to create new custom PSDrive

Example: `New-PSDrive -Name InstalledSoftware -PSProvider Registry -Root HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall`

----------------------------

Dealing with working directory

PowerShell assumes that the  items that we're working with are in the current location or directory

Example: `Get-ChildItem`
Example: `Get-ChildItem -Path c:`

Get-Location tells the current working location also the alias pwd and gl work

We can set the current working location using:

`Set-Location`  also the alias sl, cd and chdir work 

`Set-Location -Path D:\PSTraining\PracticeGround`  



`Push-Location` is used to save the current location path for later use also the alias pushd can be used

`Pop-Location` is used to get back to the saved push location. The alias popd also works.








 
