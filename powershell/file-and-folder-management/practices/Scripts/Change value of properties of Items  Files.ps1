# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location
gci . -Recurse|? LinkType -eq 'SymbolicLink'|% { $_.Delete() }
Remove-Item -Path .\* -Recurse -Force  # Emtying Current folder for this Demo
1..2|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 2 Text test files
1..2|% {New-Item -Path . -Name "$("Dir" + "$_")" -ItemType "Directory"} # Create 2 folder "Dir1" and "Dir2" in current Directory
1..2|% {New-Item -Path .\Dir* -Name "$("file" + "$_").txt" -ItemType "file"} # Creation of 2 txt files in each Subdirectory

# 1 Set Property of a file to make it read Only
Get-ChildItem .  ##################################### Getting Contents of my Working Directory
Get-Content -Path .\file1.txt  ########################################################################## getting Contenets of File
Get-ChildItem -Path .\file1.txt ############################### Checking attributes Value Before Making File Ready Only
Add-Content -Path .\file1.txt -Value "My Test Contents"  ############ Adding Contents to file before make Read Only
gc -Path .\file1.txt ############################################## Reading Contenets of File
Set-ItemProperty -Path .\file1.txt -Name IsReadOnly -Value $true ####################### Changeing Property Value to Make file Read Only
Get-ChildItem -Path .\file1.txt ############################### Checking attributes Value After Changing it
Add-Content -Path .\file1.txt -Value "My Test Contents"  ###################  Trying to add Contents after making file Read Only
Set-ItemProperty -Path .\file1.txt -Name IsReadOnly -Value $false ######### Making file Writable again

# 2  Change Proptery Value using Pipeline in bulk
Get-ChildItem -Path .\dir1\*
Get-ChildItem -Path .\dir1\*|Set-ItemProperty -Name isreadonly -Value $true
Get-ChildItem -Path .\dir1\*

# 3 Setting Bulk attributes on Bulk files
Get-ChildItem -Path .\dir2\*
Get-ChildItem -Path .\dir2\*|%{$_.Attributes = "Hidden","ReadOnly","Archive"}
Get-ChildItem -Path .\dir2\*
Get-ChildItem -Path .\dir2\* -Force # After Setting Hidden Attribute, Make sure to use -Force to list files.

# 4 Setting attribute of files in current folder, Including Subfolders in one action
Get-ChildItem -Path .\* -Recurse -File -Force
Get-ChildItem -Path .\* -Recurse -File -Force | %{$_.Attributes = "Archive"}
Get-ChildItem -Path .\* -Recurse -File

# 5 Using -Confirm parameter to supply confirmation prompt before action
Get-ChildItem -Path .\file2.txt
Get-ChildItem -Path .\file2.txt|Set-ItemProperty -Name IsReadOnly -Value $True
Get-ChildItem -Path .\file2.txt|Set-ItemProperty -Name IsReadOnly -Value $True -Confirm
Get-ChildItem -Path .\file2.txt

