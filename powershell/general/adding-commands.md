We can add repositories by using the Register-PSRepository url cmdlet.

Then the Find-Module, Install-Module, Get-Module, Remove-Module and the Update-Module to manage these modules.



We can use the PSModule-Path to specifiy where we would make PS expect modules to live. 

tO add your own prefix to any module when you import a module you can use:
`Import-Module ModuleName -Prefix MyPrefix`  and it will change `Get-OriginalCmdLet` to `Get-MyPrefixOriginalCommand`