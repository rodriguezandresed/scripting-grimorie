# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files
1..5|% {New-Item -Path . -Name "$("file" + "$_").log" -ItemType "file"}  # Creation of 5 log test filesfiles
1..5|% {New-Item -Path . -Name "$("file" + "[]" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files with Special Character in name
1..5|% {New-Item -Path . -Name "$("Dir" + "$_")" -ItemType "Directory"} # Creation of 5 Subdirectories
1..5|% {New-Item -Path .\Dir* -Name "$("file" + "$_").txt" -ItemType "file"} # Creation of 5 txt files in each Subdirectory
1..5|% {New-Item -Path .\Dir* -Name "$("file" + "$_").log" -ItemType "file"} # Creation of 5 txt files in each Subdirectory
get-childItem .\dir5\*.txt -Recurse -file -force|%{$_.attributes = "ReadOnly","Hidden"} # Making files readonly and hidden in folder "Dir5" 

# 1 Remove a file from current folder
Get-Item .\*1.txt
Remove-Item -Path .\file1.txt
Get-Item .\*1.txt

# 2 Remove all files from Specified Directory
Get-ChildItem -Path .\dir1\*.* ################################################################## Get List of All files in folder "Dir1"
Remove-Item -Path .\dir1\*.*   ############# Remove all files in folder "Dir1"
Get-ChildItem -Path .\dir1\*.* ############################################################### Get List of All files in folder "Dir1"

# 3 Remove some files from Specified Direcotry using -Include and -Exclude parameter
get-ChildItem -Path .\dir2\*.* -Include *.log -File ####### Getting All log files in folder "Dir2"
Remove-Item -Path .\dir2\*.* -Include *.log -Exclude *1* ###############   # Removing files list in above Step
get-ChildItem -Path .\dir2\*.* -Include *.log -File ####### Getting All log files in folder "Dir2" after removing filtered files

# 4 Delete hidden, read Only files using -Force parameter
Get-ChildItem -Path .\Dir5\*.txt #################### Listing (without Force Option) Txt files (Which are hidden and read Only) in folder "Dir5" 
Get-ChildItem -Path .\Dir5\*.txt -force  ########## Listing (with Force Option) Txt files (Which are hidden and read Only) in folder "Dir5"
Get-ChildItem -Path .\Dir5\*.txt -force|Remove-Item ############### Trying to remove Hidden files without -force option
Get-ChildItem -Path .\Dir5\*.txt -force|Remove-Item -force 
Get-ChildItem -Path .\Dir5\*.txt -force ########## Listing (with Force Option) Txt files (Which are hidden and read Only) in folder "Dir5"

# 5 Remove some files from Specified Direcotry using -Filter parameter
get-ChildItem -Path .\dir3\*.* ####### Getting All log files in folder "Dir3"
Remove-Item -Path .\dir3\*.* -Filter *.log  ###############   # Removing log files in Dir3
get-ChildItem -Path .\dir3\*.* ####### Getting All log files in folder "Dir2" after removing filtered files

# 6 Remove files after agreeing with confirmation Prompt that we get using -Confirm parameter
Remove-Item -Path .\dir3\file1.txt
Remove-Item -Path .\dir3\file2.txt -Confirm

# 7 See command output before actually executing it using -whatif parameter
Remove-Item .\dir3\file3.txt -WhatIf
Get-ChildItem -Path .\dir3\file3.txt

# 8 Delete files with Special Characters
Get-ChildItem . |?{$_.name  -like '*`[*'}     ############### Listing files with Special character in name
Get-ChildItem . |?{$_.name  -like '*`[*'}|Remove-Item ####### Removing files with Special character in name
Get-ChildItem . |?{$_.name  -like '*`[*'} ############# Listing files with Special character in name

# 9 Delete files in subfolders as well using -Recurse parameter
Get-ChildItem -Path .  -Recurse -File      ############## Listing files in Current and Subfolders
Get-ChildItem -Path .  -Recurse -File | Remove-Item   ############## Removing files in Current and Subfolders
Tree .
Remove-Item -Path .\* -Recurse
Tree .
Get-ChildItem -Path .  -Recurse -File -Name   ############## Listing files in Current and Subfolders
