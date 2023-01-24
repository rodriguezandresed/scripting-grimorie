Using tab allows us to autocomplete commands.

The `$PSVersionTable` allows us to see the version of powershell and the OS

We can use the `Update-Help` cmdlet to update the help text of the commands from the internet.

If the PC isn't connected to the internet, we can make a copy from one that does using `Save-Help` then update it using Update-Help -Source pointing to the file.

When using the Help command, we can wildcard the name to get more results:

example: `Help *event*`

We can use Help command to find Help topics related to cmdlets or use the 
Get-Command cmdlet which will actually find the commands.

On the Help text, parameters in brackets are optionals parameters (it has to be both the name and the value surrounded)

ex: `[-Path] <String[]> (these 2 are optionals) [-Stream <String[]>]…[-Filter <String>]`

Parameters values show their expected value covered in angle brackets <>, ex: -Filter <String> expects a String

When the value show for example: -Stream <String[] it means that the string can be an array, collection or a list.

We can separate lists using comma, but single items are always sepparated by quotations ''

ex: `Get-Item -Path '~', '~/Downloads' good`
    `Get-Item -Path '~, ~/Downloads' bad`
