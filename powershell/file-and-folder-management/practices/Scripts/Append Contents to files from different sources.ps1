# Prepare Demo Enviroment
# Copy this Code in PowerShell ISE (Integrated Scripting Enviroment)
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location Path, Create this folder in case not exist Already
gci . -Recurse|? LinkType -eq 'SymbolicLink'|% { $_.Delete() }
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Create of 5 text files
1..5|% {New-Item -Path . -Name "$("file" + "$_").log" -ItemType "file"}  # Create of 5 log filesfiles
7..8|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}|Set-ItemProperty -Name IsreadOnly -Value $True # Make 2 read Only files
Get-ChildItem .

# 1 Adding content to a file directly
1..3| % {Add-Content -Path ".\*.txt" -Value "This is line $_"} # Add 3 lines in each text File

# 2 Create File and copy contents from another file
Add-Content -Path .\file22.txt -Value (Get-Content -Path .\file2.txt)
Get-Content -Path .\file22.txt

# 3 Adding added contents to cosole as well using -Passthru parameter
Add-Content -Path .\file1.txt -Value "Send a copy to Console as well"
Add-Content -Path .\file1.txt -Value "Send a copy to Console as well" -PassThru
Get-Content -Path ".\file1.txt"

# 3 Adding Output of Command to file
Add-Content -Path .\file1.txt -Value (Get-Date) -PassThru  # Adding Output of Command to file

# 4 Copy contents of One file to another file using pipeline
Get-Content -Path .\file1.txt | Add-Content -path .\file3.txt

# 5 Forcefully add contents to a ReadOnly file
New-Item -Path .\IsReadOnlyTextFile.txt -ItemType File ################################## Create File
Set-ItemProperty -Path .\IsReadOnlyTextFile.txt -Name IsReadOnly -Value $true ############################# Make file read Only
Get-ChildItem -Path .\IsReadOnlyTextFile.txt ################################################# List file
Add-Content -Path .\IsReadOnlyTextFile.txt -Value 'Add value to read-only text file' ##################### Try to Add content Without Force
Add-Content -Path .\IsReadOnlyTextFile.txt -Value 'Add value to read-only text file' -Force  # Add contents to Read Only File Using Force Option
Get-Content -Path .\IsReadOnlyTextFile.txt ################################################## Read Content of File
Set-ItemProperty -Path .\IsReadOnlyTextFile.txt -Name IsReadOnly -Value $false ####################### Make file Readable and Wriable again

# 6 Use -Filter to narraow down wild carded path for content addition to multiple files
Add-Content -Path .\* -Filter *.txt -Value "This is filter Test" ########################## Use Filter to get required path

# 7 Use -Exclude to narrow down wild carded path specified path
Add-Content -Path ".\*.txt" -Exclude file1* -Value "This is file exclusion example"

# 8 Use -Include to narrow down wild carded path specified path
Add-Content -Path ".\*.txt" -include file1*.txt -Value "This is file Inclusion example" ############# Only include specified files from specified path