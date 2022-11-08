<#
.SYNOPSIS
  This script adding L2TP over IPsec VPN located behind NAT.
.DESCRIPTION
  With this Powershell Script, the addition of an L2TP over IPsec VPN behind NAT can be automated.
.NOTES
  Inspiration from: T13nn3s
  #>
 
# Checks if powershell is in Administrator mode, if not powershell will fix it  


#The $MyInvocation automatic variable that contains an object with information about the current command, such as a script, function, or script block.

#You can use the information in the object, such as the path and file name of the script ($MyInvocation.mycommand.path) or the name of a function ($myinvocation.mycommand.name) to identify the current command.


if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {    
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"  
  Start-Process powershell -Verb runAs -ArgumentList $arguments  
  Break  
}  

#Adding registry key to allow VPN server behind NAT
$path1 = 'HKLM:\SYSTEM\CurrentControlSet\Services\PolicyAgent'
# Create new items with values
New-ItemProperty -Path $path1 -Name 'AssumeUDPEncapsulationContextOnSendRule' -Value '1' -PropertyType 'DWORD' –Force
# Get out of the Registry
Pop-Location

$VpnName = 'Your VPN Server Name here'
$server = 'domain or ip of vpn server'
$psk = 'pre-shared secret key here'

Add-VpnConnection -Name $VpnName -ServerAddress $server -TunnelType L2tp -AuthenticationMethod MSChapv2 -EncryptionLevel Optional -L2tpPsk $psk -AllUserConnection -UseWinLogonCredential $false -SplitTunneling -Force

$confirm = Read-Host -Prompt '... L2Tp over IPsec is added. System needs to be restarted before the VPN connection can work. Reboot system? Y/N ...'  
 
If (($confirm -eq "Y")) {
  Restart-Computer
}
else {
  $cp = Read-Host -Prompt "Ok. Closing Powershell? Y/N"
     
  if (($cp -eq "Y")) {
    ncpa.cpl
    Get-Process powershell | Stop-Process
  }
  else {
    ncpa.cpl
  }
} 