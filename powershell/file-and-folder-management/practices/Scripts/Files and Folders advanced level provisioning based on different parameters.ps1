# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo

###################################################################################

# 1 Creation of Test file in a specified Path using -Path parameter
New-Item -Path . -Name "testfile1.txt" -ItemType "file"

# 2 Creation of  new Test Directory in Current Directory by using -ItemType parameter
New-Item -Path . -Name "Test_Dir" -ItemType "directory"

# 3 Create Test file by defining name of file in Path only
New-Item -Path ".\NameInPath.txt"

# 4 Create Test file by defining Path in -Name parameter's Value Only
New-Item -Name ".\PathInName.txt"

# 5 Create Test file with some content using -Value parameter
New-Item -Path . -Name "testfile2.txt" -ItemType "file" -Value "This is a text string"

# 6 Create File by confirming first using -Confirm parameter
New-Item -Path . -Name "WithoutConfirmation.txt"     ## Try without -Confirm parameter
New-Item -Path . -Name "WithConfirmation.txt" -Confirm ## Try with -Confirm parameter

# 7 Create Item using -Force parameter when Directories in Path does not exist
New-Item -Path .\forceTest -Name "Forcefile.txt" -ItemType "file" ## Try to create File when path directories does not exist
New-Item -Path .\forceTestDir -Name "Forcefile.txt" -ItemType "file" -Force ### Try to create File when path directories does not exist using -Force Switch

# 8 Overwrite existing file using -Force parameter
New-Item -Path . -Name "testfile2.txt" -ItemType "file"
New-Item -Path . -Name "testfile2.txt" -ItemType "file" -Force

# 9 Create multiple files by defining name and path separately for each file
New-Item -Path ".\test.txt", ".\test.log" -ItemType "file"
Get-ChildItem -Path .\* -Recurse

# 10 Creating N number of files and Directories using other core capabilities of Powershell like foreach statement
1..2|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 2 Text files using foreach (%)
1..2|% {New-Item -Path . -Name "$("Dir" + "$_")" -ItemType "Directory"} # Creation of 2 Subdirectories
1..2|% {New-Item -Path .\Dir* -Name "$("file" + "$_").txt" -ItemType "file"} # Creation of 2 txt files in each Subdirectory
1..2|% {New-Item -Path .\Dir* -Name "$("file" + "$_").log" -ItemType "file"} # Creation of 2 log files in each Subdirectory

# 11 Create multiple files using * (Wild Card) in Path
gci . -Directory
New-Item -Path .\dir* -Name "temp1.txt" -ItemType File | Select-Object FullName

# 12 Create link/Shortcut
New-Item -Path .\link4 -Target ".\testfile1.txt" -ItemType SymbolicLink

# 13 Differenciate file, Directory and Link
Get-ChildItem .
