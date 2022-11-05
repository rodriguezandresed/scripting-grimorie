# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..2|% {New-Item -Path . -Name "$("Dir" + "$_")" -ItemType "Directory"} # Create 2 folder "Dir1" and "Dir2" in current Directory
1..8|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"} # Create 8 txt files in Current Folder
9..10|% {New-Item -Path . -Name "$("ReadOnlyfile" + "$_").txt" -ItemType "file"}|%{$_.attributes = "Hidden","ReadOnly"} # Create 2 Read Only txt Files
1..2|% {New-Item -Path .\dir* -Name "$("file" + "$_").txt" -ItemType "file"}  # Create 2 Text files in both Subdirectory i.e "Dir1" and "Dir2"

# 1 Renaming a file
Get-ChildItem . # Getting content of current folder
Rename-Item -Path ".\file1.txt" -NewName ".\Renamed_File1.txt" # Renaming a file in current folder
Get-ChildItem .  # Getting content of current folder

# 2 Renaming a file, -PassThru parameter returns an object on screen, which we are working
Get-ChildItem . # Getting content of current folder
Rename-Item -Path ".\file2.txt" -NewName ".\Renamed_File2.txt" # Renaming without -PassThru
Rename-Item -Path ".\file3.txt" -NewName ".\Renamed_File3.txt" -PassThru # Renaming a file with -PassThru
Get-ChildItem .  # Getting content of current folder

# 3 Renaming a file, -WhatIf parameter shows what would happen if the cmdlet runs without running it actually
Get-ChildItem . # Getting content of current folder
Rename-Item -Path ".\file4.txt" -NewName ".\Renamed_File4.txt" -WhatIf # Renaming with -WhatIf parameter
Rename-Item -Path ".\file4.txt" -NewName ".\Renamed_File4.txt" # Renaming without -WhatIf parameter
Get-ChildItem .  # Getting content of current folder

# 4 Renaming a file, -WhatIf parameter shows what would happen if the cmdlet runs without running it actually
Get-ChildItem . # Getting content of current folder
Rename-Item -Path ".\file5.txt" -NewName ".\Renamed_File5.txt"  # Renaming without -Confirm parameter
Rename-Item -Path ".\file6.txt" -NewName ".\Renamed_File6.txt" # Renaming with -Confirm parameter
Get-ChildItem .  # Getting content of current folder

# 5 Renaming a Directory, Its contents remain same even after Directory itseld is renamed.
Get-ChildItem . -Directory
Get-ChildItem .\dir1
Rename-Item -Path ".\Dir1" -NewName ".\Dir4" -PassThru
Get-ChildItem . -Directory
Get-ChildItem .\dir4

# 6 Renaming extensions of multiple files recursively in one action  by piping file names in rename-item cmdlet, # -replace operator
Get-ChildItem . -Recurse -File
Get-ChildItem .\*.txt -Recurse | Rename-Item -NewName {$_.Name -replace '.txt','.log'}
Get-ChildItem . -Recurse

