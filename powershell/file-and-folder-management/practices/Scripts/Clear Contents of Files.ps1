# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
gci . -Recurse|? LinkType -eq 'SymbolicLink'|% { $_.Delete() }
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..6|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file" -Value "This is file $_"}  # Create of 5 text files
7..8|% {New-Item -Path . -Name "$("file_ReadOnly" + "$_").txt" -ItemType "file" -Value "Read Only file"}|Set-ItemProperty -Name IsreadOnly -Value $True # read Only files

# 1 Clear Content of a file
Get-Content -Path .\file1.txt
Clear-Content -Path .\file1.txt
Get-Content -Path .\file1.txt

# 2 We can limit the coverage of wild carded path by using -Exclude and -Include parameter 
Get-Content -Path .\file4.txt
Clear-Content -Path .\* -Include *.txt -Exclude *4.txt,*6.txt,*7.txt,*8.txt
Get-Content -Path .\file4.txt

# 3 We can limit the coverage of wild carded path by using -Filter parameter
# Applies when retrieving the objects, rather than filtering the objects after they are retrieved
Get-Content -Path .\file6.txt
Clear-Content -Path .\* -Filter *6.txt
Get-Content -Path .\file6.txt

# 4 Use -Force to clear contents of Read Only file
Get-Content -Path .\file_ReadOnly7.txt
Clear-Content -Path .\file_ReadOnly7.txt
Clear-Content -Path .\file_ReadOnly7.txt -Force
Get-Content -Path .\file_ReadOnly7.txt