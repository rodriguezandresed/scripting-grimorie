We can use many kinds of hosts collect inputs or display outs, such as the `host application` which is the PowerShell executable that we interact with, the `console host` that is the PowerShell running in the terminal application or the `integrated host` which is represented by the integrated console supplied by the extension in Visual Studio Code.

We can use the `Read-Host` cmdlet to prompt data from an user. 

Example: `Read-Host "Enter a computer name"`

The result can be appended to a variable such as:

`$computername = read-host "Enter a computer name"`

`Write-Host`writes directly into the host app's screen, it's able to use alternate foreground and background colors using the `-ForegroundColor` and `-BackgroundColor` parameters, we can check all the colors by typing `Get-Help -Command Write-Host`

For example: `Write-Host "COLORFUL!" -Foreground yellow -BackgroundColor mangenta COLORFUL!`

When we want to display messages we should use `Write-Verbose` instead.

There are preferences variables that we need to enable or disable to display or hide outputs from write cmdlets such as `$VerbosePreference="Continue" to enable `Write-Verbose` (shows yellow text with the label VERBOSE:), and `$VerbosePreference="SilentlyContinue", and for example for `Write-Debug` (shows yellow text with the label WARNING:) (`$DebugPreference`), for `Write-Warning` (shows yellow text with the label DEBUG:)(`$WarningPreference`), for `Write-Error` (`$ErrorActionPreference`) and `Write-Information` (`$InformationPreference`). Noting that each command sends an output to a different stream.

To pipe objects into the pipeline, we can use the `Write-Output` cmdlet, which then the pipeline will be the one displaying the output.

Remember that there's always an `Out-Host` at the end of a pipeline

Also remember that `Write-Host` will display messages no matter what, to the pipeline, and `Write-Output` if the output gets filtered or something, it wont be displayed.

For example:

```bash
write-output "Hello" | where-object { $_.length -gt 10 }
write-host "Hello" | where-object { $_.length -gt 10 }
```