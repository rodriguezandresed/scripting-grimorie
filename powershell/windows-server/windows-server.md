General Content:

A Domain Controller is a server where Active Directory is installed.

A domain tree is a collection of one or more domains that share a common namespace. Example: `fx.movie.edu` and `movie.edu`

A forest is the collection of one or more domain trees

All domains within a forest, regardless of which domain tree they're part of, are trusted by each other.

The functional level of a domain is the version of the functionality that is actually being used in the forest or domain.

OU (ORGANIZATIONAL UNITS): They can separate resources so we can manage them better (think of departments) and we can have subdepartments or subcategories.

Note: on VIEW -> Advanced Options we can enable more options and properties of our objects.

.\username to log as local user without having to type the name of the pc!

The higher the Precedence number for profiles, the more priority it will have over other profiles.

DC = Domain Component

Scripting:

Creating a new user using PS:

```bash
New-ADUser -name 'Michael Jordan' -SamAccountName jordan.michael -UserPrincipalName jordan.michael@mybusiness.local -Path "OU=Users,OU=Administration,DC=mybusiness,DC=local" -AccountPassword (ConvertTo-SecureString -AsPlainText 'Password123' -force) -Enabled $true -ChangePasswordAtLogon $true
```

We get the Path from the properties of an object where we want it to be.

From a CSV file:

```bash
Import-Csv -Path C:\UserAd.csv | ForEach-Object {New-ADUser -name $_.name -DisplayName $_.name -SamAccountName $_.sam -UserPrincipalName $_.email -Path $_.ou -AccountPassword (ConvertTo-SecureString -AsPlainText 'Senha123' -force) -Enabled $true -ChangePasswordAtLogon $true}
``` 

We can create hidden sharing paths adding a $ to the name of the shared folder


GPOs:

Active and Inactive GPOs are stored in the Group Policy Objects Container

On GPOs reinforcing it, forces it to be applied, we can specify to which users it won't apply on the security tab.

We can use `gpresult /r` to see the GPOs applied to an user.

We can use `gpresult /scope computer /v` to see the ones applied to the computer.

We can use WMI (Windows Management Instrument Filters) to ensure each GPO associated to a group can be applied to the correct version of windows, and they use SQL language to filter, for example:


```bash
64-bit
select * from Win32_OperatingSystem WHERE OSArchitecture = "64-bit" AND ProductType="1"

32-bit
select * from Win32_OperatingSystem WHERE OSArchitecture = "32-bit" AND ProductType="1"

Windows 10 
select Version from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1"


Windows 7, 8 and 8.1 
select Version from Win32_OperatingSystem WHERE Version like "6.%" AND ProductType=”1″ AND OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like "6.%" AND ProductType=”1″ AND NOT OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like "6.%" AND ProductType=”1″

Windows 8.1
select Version from Win32_OperatingSystem WHERE Version like “6.3%” AND ProductType=”1″ AND OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like “6.3%” AND ProductType=”1″ AND NOT OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like “6.3%” AND ProductType=”1″

Windows 8
select Version from Win32_OperatingSystem WHERE Version like "6.2%” AND ProductType=”1″ AND OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType=”1″ AND NOT OSArchitecture = “64-bit”
select Version from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType=”1″

Windows 7
select Version from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1" AND OSArchitecture = "64-bit"
select Version from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"
select Version from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1"

```

There's a program called PDQ Deploy that can be used to deploy MSI that aren't prepared to be used on the AD.

Example script to download M365

```bash
path-to-32bit\setup.exe /download configuration-Office365-x86.xml

path-to-64bit\setup.exe /download configuration-Office365-x64.xml
```


Example script to install M365

```bash
\\server1\Files$\32-BIT\setup.exe /configure \\server1\Files$\32-BIT\configuration-Office365-x86.xml


\\server1\Files$\64-BIT\setup.exe /configure \\server1\Files$\64-BIT\configuration-Office365-x64.xml
```

There's a setting in the security container that's called `User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode` that allows the scripts to run without administrative prompts. And we also disable `User Account Control: Admin Approval Mode for the Built-in Administrator account` so that it doesn't need an admin user to be logged on.

We can also use `AppLocker` (Located in Policies\Windows Settings\Security Settings\Application Control Policies) to limit users to not install apps on personal directories, on its properties we can configure it to enforce rules, then we create new executable rules to manage the instalations.

We also need to enable on Security Settings\System Services the `Application Identity Properties` to make it able to identify the name/publisher/version of the apps to block.

We can also disable Task Manager access on User\Policies\Administrative Templates\System\Ctrl+Alt+Del Options

Note: scritps and WMI filters applied to a restored GPO won't be linked and/or restored, they need to be set up again.

To manage our servers remotely, we can install `Windows Admin Center` and `Remote Server Administration Tools`

We can make a centralized update server for Windows Updates using `Windows Server Update Services`

The `File Server Resource Manager` can be used to manage the silve server, for example, create quotas of usage on the file server, prohibit file extentions or find for duplicate files.

We can use DFS to ease the access to shared folders and we can enable Replication to save backups!