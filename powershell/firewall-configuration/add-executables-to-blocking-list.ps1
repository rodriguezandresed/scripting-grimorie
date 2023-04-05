Get-ChildItem *.exe -Name | ForEach-Object {New-NetFirewallRule -Program $_ -Action Block -DisplayName $_ -Description $_ -Direction Outbound}




