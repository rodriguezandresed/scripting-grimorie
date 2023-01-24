

Depending on the capabilities of the providers they support different parameters:

`ShouldProcess` allows the use of `-WhatIf` and `-Confirm`

Filter allows the support of `-Filter` parameter

Credentials allows the specification of alternate credentials when connecting to data stores, we use the -Credential parameter for it.

For PowerShell files and folders do not exist, they're all items.

A ChildItem is a referal to items contained within an item. 

To set current directory (such as cd) we can use Set-Location -Path

The * wildcard stands in for zero or more characters, whereas the ? wildcard stands in
for any single character

`Get-ChildItem env:*` allows us to see all env variables
