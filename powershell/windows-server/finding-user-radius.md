1. Identifying the cmdlet parameters

`(Get-Command Get-WinEvent).parameters` OR `Get-Help Get-WinEvent -Parameter * | Select-Object Name, Required

2. Filtering the Message:

Get-WinEvent -ProviderName Microsoft-Windows-Security-Auditing | Where-Object {$_.Message -like "USERNAME OR IP TO SEARCH"} | Select-Object TimeCreated, Message -first 3 | Format-Table -wrap 