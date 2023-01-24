Most versions of Powershell can be manually updated via the Windows Management Framework

Powershell Core is the only one currently getting feature updates

powershell.exe -> powershell

pwsh.exe / pwsh -> PowerShell Core (Windows, MacOS and Linux)

MAKE SURE THAT DURING THE INSTALATION THE ENV PATH GETS DEFINED!

---------------------------------

The command `PSVersionTable` allows us to see the current version of powershell

---------------------------------

The PowerShell ISE (Integrated Scripting Environment)

It's an interpreter for Windows PowerShell (we can compile scripts here), it's built in windows 7 and onwards

IntelliSense -> display possible values for the cmdlets

F8 -> RUN ONLY SELECTION

F5 -> RUN ENTIRE CODE

-------------------

On visual studio code, you can use a command to make it look like ISE by searching on the command bar

It's also recommended to install the powershell extension

---------

Help Systems

Get-Help we can also use the alias help or manually

Parameters: Full, Detailed, Examples, Online, Parameter, ShowWindow

It's used to discover commands and know how to use commands.

Example: `Get-Help *service*`

Example: `Get-Help *service*  -Category Cmdlet`

Example: `Get-Help Get-Service -Parameter *`

We can update documentation for commands by typing the command: Update-Help

************

Get-Command allows us to search for commands we don't know


Example: `Get-Command *service* -CommandType Cdmlet`

Example: `Get-Command -Name get-service`
