# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
New-Item .\Dir_Depth1\Dir_Depth2\Dir_Depth3\Dir_Depth4 -ItemType Directory # Creation of 4 Subdirectories, One Inside Another
tree
1..2|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 2 Text files in current working folder
1..2|% {New-Item -Path .\dir* -Name "$("file" + "$_").txt" -ItemType "file"}
1..2|% {New-Item -Path .\dir*\dir* -Name "$("file" + "$_").txt" -ItemType "file"}
1..2|% {New-Item -Path .\dir*\dir*\dir* -Name "$("file" + "$_").txt" -ItemType "file"}
1..2|% {New-Item -Path .\dir*\dir*\dir*\dir* -Name "$("file" + "$_").txt" -ItemType "file"}
1..2|% {New-Item -Path .\dir*\dir*\dir*\dir* -Name "$("file" + "$_").log" -ItemType "file"} # Creating 2 Log files in 4th level directory
(New-Item . -Name hidden1.txt -ItemType file).Attributes += 'Hidden' # Creating 1 hidden file in current Working directory

###################################################################################################################

# 1 Getting child items from a directory specified using -Path parameter
Get-ChildItem -Path .

# 2 Getting child item names in a specified path directory
Get-ChildItem -Path . -Name

# 3 Listing only log files using  -Filter parameter
Get-ChildItem -Path .\dir*\dir*\dir*\dir* -Recurse
Get-ChildItem -Path .\dir*\dir*\dir*\dir* -Recurse -Filter *.log

# 4 Listing Only Log files in Directory "Dir_Depth4", path defined using -LiteralPath paramter
Get-ChildItem -LiteralPath .\dir*\dir*\dir*\dir* -Recurse -Filter *.log    # Trying to use wild card path with -LeteralPath parameter
Get-ChildItem -LiteralPath ".\Dir_Depth1\Dir_Depth2\Dir_Depth3\Dir_Depth4" -Recurse -Filter *.log

# 5 Listing Only Files in Current folder using -File parameter
Get-ChildItem -Path . -Recurse -Name
Get-ChildItem -Path . -File -Recurse -Name

# 6 Listing Only directories in Current folder  using -Directory parameter
Get-ChildItem -Path . -Recurse -Name # Without -Directory parameter
Get-ChildItem -Path . -Directory -Recurse -Name   ############################# To get Only Names, we are using -Name paramter

# 7 Getting child items in the current directory and subdirectories using -Recurse parameter
Get-ChildItem -Path .             # Without -recurse parameter
Get-ChildItem -Path . -Recurse
Get-ChildItem -Path .\*.txt -Recurse

# 8 Getting Hidden and System files in the current directory and subdirectories using -Force parameter
Get-ChildItem -Path .
Get-ChildItem -Path . -force # list all the files including hidden files

# 9 Getting only Hidden, System or ReadOnly files specifically using -Hidden, -ReadOnly or -System parameter
Get-ChildItem -Path .
Get-ChildItem -Path . -Hidden 

# 10 we can Narrow down the coverage of path using -Include or -Exclude parameters
Get-ChildItem -Path . -file -Recurse -Name
Get-ChildItem -Path . -Include *.txt -file -Recurse -Name
Get-ChildItem -Path . -Exclude *.txt -file -Recurse -Name

# 11 Getting items upto a level of subfolders only using the -depth parameter
Get-ChildItem -Path . -Recurse
Get-ChildItem -Path . -Depth 2

# 12 Getting names of Items in a specified Path using -Name parameter
Get-ChildItem -Path . -Name

# 13 Geting non-system files (not directories)
Get-ChildItem . -Attributes !Directory  # Listng items which are not directory
Get-ChildItem . -Attributes !Directory+!System # Listng items which are not directory and not System files
Get-ChildItem . -Attributes hidden  # Listng items which hidden

# 14 Get any particular property only like fileversion of any file
Get-ChildItem C:\Windows\ADAM\adammsg.dll | fl *version*
(Get-ChildItem C:\Windows\ADAM\adammsg.dll).VersionInfo.fileversion



