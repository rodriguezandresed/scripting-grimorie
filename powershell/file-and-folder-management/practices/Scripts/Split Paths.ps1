# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files


# 1 Split a path to get Parent part Only using -Parent parameter
Split-Path -Path D:\PSTraining\PracticeGround\File1.txt -Parent

# 2 Get the qualifier/Drive of a path
Split-Path -Path "HKCU:\Software\Microsoft" -Qualifier

# 3 Get the qualifier/Drive of a path using -Qualifier parameter
Split-Path -Path D:\PSTraining\PracticeGround\File1.txt -Qualifier

# 4 Get the path without the qualifier using -NoQualifier parameter
Split-Path -Path D:\PSTraining\PracticeGround\File1.txt -NoQualifier

# 5 Using -Leaf switch, we can get topmost file/folder name in mentioned path
Split-Path -Path D:\PSTraining\PracticeGround\File1.txt -Leaf

# 6 Display Leaf (Right most file/folder of the path) name
Split-Path -Path ".\*.txt" -Leaf -Resolve

# 7 Use -LiterPath parameter to specify exactly same path as typed
Split-Path -LiteralPath .\file1.txt -Resolve

# 8 Get the parent container
Split-Path -Path .\file1.txt -Resolve

# 9 Determines whether a path is absolute
Split-Path -Path .\file1.txt -IsAbsolute
Split-Path -Path D:\PSTraining\PracticeGround\File1.txt -IsAbsolute 

