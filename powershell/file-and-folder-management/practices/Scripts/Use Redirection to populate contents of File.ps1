# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location

# 1 Executing a simple command and seeing its output
Ping fakehost

# 2 Send Command Output/Stream to file using Out-File Cmdlet
Ping fakehost|Out-File .\outfile.txt

# 3 Send Command output/Stream to file and and also pipeline output to following command or Console
Ping fakehost|Tee-Object .\teeout.txt  # Send output to a file and also to console
gci .|Tee-Object .\filelist_CurrentFolder.txt|Measure-Object # Send output to a file and also to console

# 4 Send command output to a file using redirection Operator >
Ping fakehost > .\redirectionOperator.txt # Send Out to File
Get-Content .\redirectionOperator.txt # Check contents of File

# 5 Send command output to a file using redirection Operator >> and APPEND with existing content of file if any
Ping fakehost >> .\redirectionOperator.txt # Append Output to File
Get-Content .\redirectionOperator.txt # Check contents of File
 # Check contents of File