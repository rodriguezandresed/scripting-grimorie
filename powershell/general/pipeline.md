PowerShell connects commands to each other by using a pipeline. The pipeline provides a way for one command to pass, or pipe, its output to another command,
allowing that second command to have something to work with. This can be seen
with the vertical bar | between two cmdlets


For example: exporting the output of a cmdlet to a csv file: `Get-Process | Export-CSV procs.CSV`

We can Import CSV files using `Import-CSV filename.CSV` to read it on powershell.

Example: eporting the thread information of a process (called nester property of a process object)

`get-process pwsh | select-object Threads`

or `(Get-Process -Name pwsh).threads\`

Then we could convert the output into JSON and THEN save the file

`Get-Content | ConvertTo-Json | Out-File procs.json`

then if we want to see the data back 

`Get-Content ./procs.json | ConvertFrom-Json`

We could also export the data to a flat file using Out-File

`Get-ChildItem | Select-Object Name | Out-File process.txt`


We can use the > character to pipeline too, so it's also compatible with shell

For example, `Dir > DirectoryList.txt would actually do Dir | Out-File DirectoryList.txt`

We could convert to html using:

`Get-Process -Id $PID | ConvertTo-Html | Out-File processes.html`

We could also pipeline to end processes for example:

`Get-Process -Name bash | Stop-Process -Confirm`

