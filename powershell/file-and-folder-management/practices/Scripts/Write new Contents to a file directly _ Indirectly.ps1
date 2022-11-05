# Prepare Demo Enviroment
Set-Location "D:\PSTraining\PracticeGround" # Setting My Working Location
Get-ChildItem . -Recurse|? LinkType -eq 'SymbolicLink'|% { $_.Delete() }
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Create of 5 text files
1..5|% {New-Item -Path . -Name "$("file" + "$_").log" -ItemType "file"}  # Create of 5 log filesfiles
7..8|% {New-Item -Path . -Name "$("ReadOnlyfile" + "$_").txt" -ItemType "file"}|Set-ItemProperty -Name IsreadOnly -Value $True # Make 2 read Only files
Get-ChildItem .

# 1 Writing new Contents to a file
Get-Conten .\file5.txt
Set-Content -path .\file5.txt -Value "This is Just new Set Contents"    # Notice the output without -PassThru parameter

# 2 Writing new Contents to a file and showing added contents on console as well using -PassThru parameter
Set-Content -path .\file5.txt -Value "This is Just new Set Contents"
Set-Content -path .\file5.txt -Value "This is Just new Set Contents" -PassThru # Notice the output with -PassThru parameter
Get-Conten .\file5.txt

# 3 Creating new file and setting its contents
Get-Conten -Path .\file6.txt
Set-Content -Path .\file6.txt -Value "This is new value for new file"
Get-Conten -Path .\file6.txt

# 4 Writing new Contents to many files in bulk using -Filter parameter
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Conten -Path .\*.txt 
Set-Content .\* -filter *.txt -Value "This is bulk Set Content to All files using -Filter"
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Conten -Path .\*.txt

# 5 Writing new Contents to many files in bulk using -Include parameter
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Content -Path .\*.txt 
Set-Content .\* -Include *1.txt -Value "This is bulk Set Content to All files using -Include"
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Content -Path .\*.txt

# 6 Writing new Contents to many files in bulk using -exclude parameter
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Content -Path .\*.txt 
Set-Content .\* -Exclude *1.txt -Value "This is bulk Set Content to All files using -Exclude"
Get-ChildItem -Path .\*.txt # Notice the Length
Get-Content -Path .\*.txt

# 7 Getting Confirmation prompt before setting contents using -Confirm parameter
Set-Content .\file1.txt -Value "Contents without Confirm" -PassThru
Set-Content .\file1.txt -Value "Contents without Confirm" -PassThru -Confirm

# 8 Getting expected output before actually running command using -WhatIf parameter
Get-Content .\file1.txt
Set-Content .\file1.txt -Value "Contents without " -PassThru -WhatIf
Get-Content .\file1.txt

# 9 Write Content to Read Only file using -Force parameter
Get-ChildItem . -ReadOnly
Get-Content .\ReadOnlyfile7.txt
Set-Content .\ReadOnlyfile7.txt -Value "Content write to Read Only file"  # Trying to write content without -Force Parameter
Set-Content .\ReadOnlyfile7.txt -Value "Content write to Read Only file" -Force -PassThru # Trying to write content with -Force Parameter
Get-Content .\ReadOnlyfile7.txt