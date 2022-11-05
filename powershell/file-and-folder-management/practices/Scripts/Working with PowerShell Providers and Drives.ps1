# 1 Get List of PowerShell Providers
Get-PSProvider

# 2 Get List of Drives in PS Providers
Get-PSDrive -PSProvider Registry|ft -AutoSize
Get-PSDrive -PSProvider FileSystem

# 3 Create new Drive in Provider
New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
Dir HKU:

# 4 create additional drives that point to specific registry keys that you may need to access often
New-PSDrive -Name InstalledSoftware -PSProvider Registry -Root HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
Get-ItemProperty InstalledSoftware:\*|?{$_.publisher -like "*Microsoft*"}|Select displayname

# 5 Remove custom created PS Drive
Remove-PSDrive -Name InstalledSoftware

