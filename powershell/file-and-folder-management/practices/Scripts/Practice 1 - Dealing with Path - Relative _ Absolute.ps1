# Prepare Demo Enviroment
Set-Location "D:\C2_EAFM_Resources\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this practice
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files

# 1 Open Current Directory in Windows Explorer using Relative Path
Start .

# 2 Open Parent Directory in Windows Explorer using Relative Path
Start ..

# 3 Resolve relative path of a file to Absolute path
Resolve-Path .\file1.txt

# Resolve relative path to Absolute path of files in bulk 
Resolve-Path .\file*.txt




