# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..2|% {New-Item -Path . -Name "$("Dir" + "$_")" -ItemType "Directory"} # Create 2 folder "Dir1" and "Dir2" in current Directory
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"} # Create 5 txt files in Current Folder
1..2|% {New-Item -Path .\dir* -Name "$("file" + "$_").txt" -ItemType "file"}  # Create 2 Text files in both Subdirectory i.e "Dir1" and "Dir2"
7..8|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}|Set-ItemProperty -Name IsreadOnly -Value $true # Create 2 Read only Files

# 1 Copy a file to the specified directory using -Destination and -PassThru paraameter
gci .
gci .\Dir2
Copy-Item -Path .\file3.txt -Destination .\Dir2 -PassThru
gci .
gci .\Dir2

# 2 Copy a file to the specified directory and rename the file
gci .
gci .\Dir2
Copy-Item -Path .\file3.txt -Destination .\Dir2\Copied_renamed_file.txt -PassThru
gci .
gci .\Dir2

# 3 Confirm parameter prompts us for confirmation before running the cmdlet
gci .
gci .\Dir2
Copy-Item -Path .\file4.txt -Destination .\Dir2 -Confirm
gci .
gci .\Dir2

# 4 Copy directory and its contents to a an existing directory using -Recurse parameter
gci . -Recurse
Copy-Item -Path .\Dir1 -Destination .\dir2 -Recurse # Copying "Dir1" and its contents to "Dir2"
gci . -Recurse

# 5 Overwrite ReadOnly files using Copy Operation with -Force parameter
Get-ChildItem -Path .,.\Dir1 -ReadOnly # List ReadOnly files in current Directory "." and Subdirectory "Dir1"
Copy-Item -Path .\file7.txt -Destination .\Dir1 # Copy a readOnly file "File7.txt" from current Directory to Subdirectory "Dir1"
Get-ChildItem -Path .,.\Dir1 -ReadOnly # List ReadOnly files in current Directory "." and Subdirectory "Dir1", after copy operation
Copy-Item -Path .\file7.txt -Destination .\Dir1 # Try to overwrite a readOnly file "File7.txt" using copy option without -Force Switch
Copy-Item -Path .\file7.txt -Destination .\Dir1 -Force # Try to overwrite a readOnly file "File7.txt" using copy operation with -Force Switch
Get-ChildItem -Path .,.\Dir1 -ReadOnly # List ReadOnly files in current Directory "." and Subdirectory "Dir1"

# 6 Use -Include and -Exclude parameter to limit the coverage of wild carded path
gci .\Dir1, .\Dir2
Copy-Item -Path .\Dir1\* -Destination .\Dir2 -Include *.txt -Exclude *1.txt -PassThru
gci .\Dir1, .\Dir2

# 7 See command output before executing it using -whatif parameter
Copy-Item -Path .\Dir2\* -Destination .\Dir1 -filter *file.txt -PassThru -WhatIf
gci .\Dir1, .\Dir2

# 8 Use -Filter parameter to limit the coverage of wild carded path
gci .\Dir1, .\Dir2
Copy-Item -Path .\Dir2\* -Destination .\Dir1 -filter *file.txt -PassThru
gci .\Dir1, .\Dir2



