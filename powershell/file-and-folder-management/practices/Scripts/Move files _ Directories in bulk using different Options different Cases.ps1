# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location, Create this folder, Incase not exist Already
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
New-Item -path ".\dir1\file1.txt",".\dir1\file2.txt" -ItemType file -Force # Create folder "Dir1" in  current Directory and file1.txt, file2.txt in "Dir1"
New-Item -path ".\dir2\file3.txt",".\dir2\file4.txt" -ItemType file -Force  # Create folder "Dir2" in  current Directory and file3.txt, file4.txt in "Dir1"
New-Item -path ".\dir1\dir3\file5.txt",".\dir1\dir3\file6.txt" -ItemType file -Force # Create folder "Dir3" in  Dir1 and file5.txt, file6.txt in "Dir3"
New-Item -path ".\dir2\dir4\file7.txt",".\dir2\dir4\file8.txt" -ItemType file -Force # Create folder "Dir4" in  Dir2 and file7.txt, file8.txt in "Dir3"
Ni .\Dir8\forcefile1.txt -Value "Dir8 Content" -Force; Ni .\Dir9\forcefile1.txt -Value "Dir9_Content" -Force
tree . ###################################################################################### Getting Folder Structure
gci . -Recurse ## Getting Contents of recently created Demo Enviroment

# 1 Move a file from directory to another using -Path and -Destination
Get-ChildItem -Path .\dir1, .\dir2
Move-Item -Path .\Dir1\file2.txt -Destination .\Dir2
Get-ChildItem -Path .\dir1, .\dir2

# 2 We can move and rename an item in same action
Get-ChildItem -Path .\dir1, .\dir2
Move-Item -Path .\Dir2\file2.txt -Destination .\Dir2\Renamed_Moved_file2.txt -PassThru
Get-ChildItem -Path .\dir1, .\dir2

# 3 -Confirm parameter prompts you for confirmation before running the cmdlet
Get-ChildItem -Path .\dir1, .\dir2
Move-Item -Path .\Dir2\file2.txt -Destination .\Dir1 -Confirm
Get-ChildItem -Path .\dir1, .\dir2

# 4 Move a file to another directory and rename it, Use -WhatIf parameter to know output before actually executing command
Get-ChildItem .\dir*\*.txt
Move-Item -Path .\Dir1\file1.txt -Destination .\Dir2\Moved_file1.txt -PassThru -WhatIf
Move-Item -Path .\Dir1\file1.txt -Destination .\Dir2\Moved_file1.txt -PassThru
Get-ChildItem .\dir*\*.txt

# 5 Move a directory and its contents to another directory
# Use -PassThru parameter to see what contents haave been moved
# User -Literal
gci .\dir1\dir3,.\dir2\dir4
Move-Item -LiteralPath .\dir1\dir3 -Destination .\dir2\dir4 -PassThru
gci .\dir1\dir3,.\dir2\dir4

# 6 Using -Filter parameter to Move all files of a specified extension from the Current directory to another directory
gci .\dir1,.\dir2
Move-Item -Path .\dir2\*.* -Filter *.txt -Destination .\dir1 -PassThru
gci .\dir1,.\dir2

# 7 Using -Include or/and -Exclude paramter to limit the coveerage of wild carded path
gci .\dir1,.\dir2
Move-Item -Path ".\dir1\*.*" -Include *.txt -Exclude *2* -Destination .\dir2 -PassThru
gci .\dir1,.\dir2

# 8 Move all the text files from the current directory and all subdirectories, using -Recurse parameter
gci .\dir1,.\dir2 -Recurse
Get-ChildItem -Path ".\Dir2\*.txt" -Recurse | Move-Item -Destination ".\Dir1" -PassThru
gci .\dir1,.\dir2 -Recurse

# 9 Move items forcefully using -Force parameter, even if they already exist in destination
Get-ChildItem -Path .\dir8, .\Dir9
Get-content -Path .\dir8\forcefile1.txt, .\Dir9\forcefile1.txt
Move-Item -Path .\Dir8\forcefile1.txt -Destination .\Dir9
Move-Item -Path .\Dir8\forcefile1.txt -Destination .\Dir9 -Force
gc .\dir9\forcefile1.txt
