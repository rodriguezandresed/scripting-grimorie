#Prepare Demo Enviroment
# Set Working Location
# Create 5 Text file
1..3| % {Add-Content -Path ".\*.txt" -Value "This is line $_"} # Add 3 lines in each text File



# 11 Read Contents of a file
Get-Content .\file1.txt

# 12 Read Only 3 Lines of file
Get-Content -Path .\file1.txt -TotalCount 3


# 13 Read Only 4th line of file
(Get-Content -Path .\file1.txt -TotalCount 25)[4]

# 14 Read last 1 line of file
Get-Content .\file1.txt -Tail 1 

# 15 Reading contents of multiple files by including wild carded path, -Include and -Exclude Switches
Get-Content .\* -Include *.txt|Select-String -Pattern "1"
Get-Content .\* -Exclude *.log|Select-String -Pattern "1"

# 16 Read all contents of file and wait for more updated content using -Wait
Get-Content .\file1.txt -Wait
