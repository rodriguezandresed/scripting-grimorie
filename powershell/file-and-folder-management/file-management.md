We can use the New-Item or the alias ni command to create files, folders, registry entry, etc.

Entries depend on location/provider, as if registry -> registry key or file system  -> files, folders, etc

Example: 
`New-Item -Path -Name "file1.txt"`
`New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UIPI -Name Test_Key`

We can use the `-ItemType` parameter to define the type of Item so that It can be a File, Directory, SymbolicLink, Junction, HardLink

Example: `New-Item -Path . -Name "Test_File.txt" -ItemType "file"`

We can use the `-Confirm` parameter to give a confirmation prompt before running the cmdlet

The -Path parameter can be used to specify the path for the file, it can contain the name of the item and wildcards

Example: `New-Item -Path ".\NameinPath.txt"`

`-Name` is used to define the path name

Example: `New-Item -Name ".\PathInName.txt"`

We can use the `-Value` parameter to set the content of a newly created file

Example: `New-Item -Path . -Name "testfile2.txt" -ItemType "file" -value "This is a test"`

-Force parameter is used to create intermediate directories if it doesn't exist or to overwrite files


-------------------------------------------------

Listing Files and Directories

`Get-ChildItem` is used to get items and childitems in a specified path

`gci`, `dir` and `ls` are alias of `Get-ChildItem` 

the -Path parameter can be used to define the path from where to list items and supports wildcards

the `-LiteralPath` parameter can be used to define a path without accepting wildcards

`-Filter` can be used to apply a filter before fetching a result

Example: `gci -Path .\dir*\dir*\dir*\dir* -Recurse -Filter *.log`

The `-Include` and `-Excluse` is used to apply a filter after fetching a result so it's slower than filter

we can use the  `-File` or `-Directory` parameters to only list files or directories

-Force can be used to acces files that are hidden or system files

If we need to get to a certain depth of directories, for example, to see the items to see first 3 directories we can use:

(The first directory is represented as 0)

`Get-ChildItem -Path . -Depth 2` 


The mode column from data fetched means the attribute of the item
```bash
d -> directory
a -> archive
r -> read only
h -> hidden
s -> system
l -> link
```

the -Name parameter can be used to only fetch the name of items

The -Hidden -ReadOnly or -System parameters can be used to list only files that have these attributes

Example: `gci -path . -Hidden`

The `-Attributes` parameters can be used to list files and folders that have the specified attribute

Example: `gci . -Attributes Directory`
Example `gci . -Attributes hidden`

We can use logical operators such as 

! -> NOT
+ -> AND
, -> OR

Example: `gci . -Attributes !Directory + !System`


-----------------------------------------

Write content to files

Set-Content or the alias sc writes new contents or replaces existing content.

It can be also used to create new files if it doesn't exists already

IF CONTENT ALREADY EXISTS IN A FILE, IT WILL REPLACE THE CONTENT WITH THE NEW ONE!

Example: `Set-Content -path .\file5.txt -Value "This is new content"`

the `-PassThru` parameter returns the object on screen that represents the content (as there is no output by default)

the `-Path` parameter can be used to specify where the file is located

the `-Value` parameter can be use to define the content

the `-Filter` parameter can be used to qualify items for the Path parameter

Also `-Include` or -Exclude can be used

`-Confirm` can be used to give a prompt to confirmation

`-whatif` can be used  to see what will happen before excecuting the parameter

Example: `Set-Content .\file1.txt -Value "TEST CONTENT" -PassThru -WhatIf`

`-Force` can be used to bypass permissions or hidden files


-----------------------------------------------

Append content to files

Add-Content or the ac alias appends files to a specific file

It can create files if it doesn't already exist

`Add-Content -Path .\file2.txt -Value "This is Appended Content"`

The content that needs to be appended may be a command output, other file content or manually typed

Example: `ac -Path .\file4.txt -Value (Get-Date) -PassThru`

We can use the Parameters `-Path, -Value, -PassThru, -Filter, -Include, -Exclude, -Force`


---------------------

Use redirection to populate contents of file

The Out-File cmdlet sends command output to a text file, you can use it's parameters such as:

`-Force, -Width`  or `-NoClobber`

Example: `ping fakehost | Out-File .\outfile.txt`

We can use Tee-Object cmdlet to send command output to a text file and then sends it to the pipeline (next command)

example: `ping fakehost|Tee-Object .\teeout.txt`
example: `gci .|Tee-Object .\filelist_currentfolder.txt|Measure-Object`

We can also use redirection operators:

> sends specified stream to a file (overwriting)
>> appends specified stream to a file

if the file doesn't exists, it will create it!

example:" `ping fakehost > .\redirectionOperator.txt`

-------------------------------------

Remove contents of files

Clear-Content or the alias clc is used to remove contents of files 

We can use the parameters -Filter, -Include -Excluse, -Force

Example: `clc -Path .\file_readonly7.txt -Force`

--------------------------------------------------------------

Change properties of files

`Set-ItemProperty` or the alias sp can be used to set the value of the key properties of items like file or Registry key

the attributes can be IsReadOnly, Attributes, etc.

The parameters `-Path, -Name, -Value, -Confirm, -Force, -PassThru, -WhatIf`

Example: `Set-ItemProperty -Path .\file1.txt -Name IsReadOnly -Value $true`

Example: `Get-ChildItem -Path .\dir2\* -Force | %{$_.Attributes = "Archive"}`

---------------------------------

Remove Files & Directories

Remove-Item or the alias `ri, rm or rmdir` deletes one or more items

We can use the parameters `-Force, -Filter, -Include, -Exclude, -Confirm, -WhatIf`

Example: `Remove-Item -Path .\file1.txt`
Example: `Remove-Item HKLM:\SOFTWARE\Key_1`


To remove subfolders as well, we can use the -Recurse parameter

Example: `Remove-Item -Path .\* -Recurse`

To remove files with special characters we can use

`Get-ChildItem . |?{$_.name -like '*` [* '} | Remove-Item`

------------------------------------------------

Copy files and directories

Copy-Item or the alias copy, cp or cpi copies an item form one location to another

we can use the parameters `-Path, -Destination, -PassThru, -Force, -Include, -Exclude, -Filter, -WhatIf, -Confirm`

Example: `Copy-Item -Path .\file3.txt -Destination .\Dir2 -PassThru`

we can copy and rename a file with the same command

`cp -Path .\file3.txt -Destination .\Dir2\Copied_renamed_file.txt`  

The -Recurse parameter can be used to copy folders and subfolders as well


--------------------------------------

Move Files and directories

Move-Item or the alias mi or mv can be used to move files including it's properties, content and childitems to another location

We can use the parameters `-Path, -Destination, -WhatIf, -PassThru, -LiteralPath, -Confirm, -Filter, -Include, -Exclude, -Recurse, -Force`

`Move-Item -Path .\Dir1\file2.txt -Destination .\Dir2`


`Get-ChildItem -Path ".\Dir2\*.txt" -Recurse | Move-Item -Destination ".\Dir1" -PassThru`

-----------------------------------------------

Rename Files and Directories

Rename-Item or the alias ren or rni changes the name of a specifierd item, registry key, etc.

What will be renamed depends on the PS provider we are working with

When an item is renamed, it's containt remain as it is

We cannot rename and move an item at the same time using this command

So we can't specify a different path with -NewName

We can use the parameters -NewName, -PassThru, -Confirm, -WhatIf

example: `ren -Path ".\file1.txt" -NewName ".\Renamed_File.txt"`
example: `ren -Path ".\Dr1" -NewName ".\Dir4"`
