# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files


# 1 Test a path using -Path and -LiteralPath parameter
Test-Path -Path .\*file1.txt
Test-Path -LiteralPath .\*file1.txt
Test-Path -LiteralPath .\file1.txt

# 2 Test if Syntax is valid
Test-Path -Path ./file6.txt
Test-Path -Path ./file6.txt -IsValid

# 3 Check whether there exist any specifiedd type of files using -Exclude and -Include parameter
Test-Path -Path .\*.txt
Test-Path -Path .\*.log
Test-Path  -Path .\* -Exclude *.txt # txt file will be omitted from evaluation
Test-Path -Path .\* -Include *.txt

# 4 Check whether there exist any specifiedd type of files using -Filter parameter
Test-Path  -Path .\* -Filter *.txt
Test-Path  -Path .\* -Filter *.log

# 5 Check if path leads to File/Folder/RegistryKey or not
Test-Path -Path .\* -PathType Leaf
Test-Path -Path .\new* -PathType Container
Test-Path -Path .\* -PathType any

# 6 Check paths in the Registry
Test-Path -Path "HKLM:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell"

# 7 Test if a file is newer than a specified date
Get-ChildItem .\file1.txt|fl Name,creationtime
Test-Path -Path .\file1.txt -NewerThan "July 16, 2000"
Test-Path -Path .\file1.txt -NewerThan "July 16, 2030"
Test-Path -Path .\file1.txt -OlderThan "July 16, 2000"
Test-Path -Path .\file1.txt -OlderThan "July 16, 2030"

# 8 Convert the working directory to a standard file system path
Convert-Path .

# 9 Convert a provider path to a standard registry path
Convert-Path HKLM:\Software\Microsoft

# 10 Convert a path to a string
Convert-Path ~

