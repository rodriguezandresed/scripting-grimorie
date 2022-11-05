# Prepare Demo Enviroment
Set-Location "D:\OneDrive - Hitachi Group\Documents\PSTraining\PracticeGround" # Setting My Working Location
Remove-Item .\* -Recurse -Force  # Emtying Current folder for this Demo
1..5|% {New-Item -Path . -Name "$("file" + "$_").txt" -ItemType "file"}  # Creation of 5 Text test files

# 1 Combine a path with a child path
Join-Path -Path "path" -ChildPath "childpath"

# 2 Combine paths that already contain directory separators
Join-Path -Path "path\" -ChildPath "\childpath"

# 3 Display files and folders by joining a path with a child path
Join-Path "C:\win*" "System*" -Resolve

# 4 Use Join-Path with the PowerShell registry provider
Join-Path -Path "HKLM:\System" -ChildPath *ControlSet* -Resolve

# 5 Combine multiple path roots with a child path
Join-Path -Path C:, D: -ChildPath NewFolder
