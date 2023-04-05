We can add repositories by using the Register-PSRepository url cmdlet.

Then the Find-Module, Install-Module, Get-Module, Remove-Module and the Update-Module to manage these modules.

We can use the PSModule-Path to specifiy where we would make PS expect modules to live. 

tO add your own prefix to any module when you import a module you can use:
`Import-Module ModuleName -Prefix MyPrefix`  and it will change `Get-OriginalCmdLet` to `Get-MyPrefixOriginalCommand`

To get modules from the internet:

The PowerShellGet module allows installing modules from http://PowerShellGallery.com. 

Run `Register-PSRepository` to add the URL of a repository. http://PowerShellGallery.com is usually set up by default, but it’s even possible to set up your own “gallery” internally for private use, and you’d use RegisterPSRepository to point to it.

Use `Find-Module` to find modules in repositories. You can use wildcards (*) in names, specify tags, and have many other choices for narrowing the search results.

Use `Install-Module` to download and install a module after you’ve found it.

Use `Update-Module` to make sure your local copy of a module is the latest version, and if it isn’t, download and install the latest.
PowerShellGet includes several other commands (http://PowerShellGallery.com  links to the documentation), but these are the ones you’ll start out using. For example, try installing the Azure PowerShell module, or Jeff Hicks’s PSScriptTools module from the PowerShell Gallery.


Examples:

`find-module * activedirectory * | Select Version,Name,Author,Description,PublishedDate` 

`find-module -tag ad,activedirectory`

Remember Get-Command 