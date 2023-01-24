Powershell uses the following terminologies:

Object: This is what we’ve been calling a table row. It represents a single thing, such as a single process or a single storage account.

Property: This is what we called a table column. It represents one piece of information about an object, such as a process name, a process ID, or a VM’s running status.

Method: This is what we called an action. A method is related to a single object and makes that object do something—for example, killing a process or starting a VM.

Collection: This is the entire set of objects, or what we’ve been calling a table.

When we wish to learn more about an object we use the Get-Member command.

For example if we wanted to stop a process:

`Get-Process -Name Code | Stop-Process`

or

`Stop-Process -Name Code`

Or if we want to list processes with the highest CPU use

`Get-Process | Sort-Object -Property CPU`

`Get-Process | Sort-Object CPU, ID -desc`

and export it:

`Get-Process | Select-Object -Property Name,ID,CPU,PM | ConvertTo-Html | Out-File test.html`

Note: SelectObject is used to choose the properties (or columns) you want to see, and it
can also select an arbitrary subset of output rows (using -First and -Last).
Where-Object removes, or filters, objects out of the pipeline based on criteria
you specify.

Tips:

Remember that the PowerShell help files don’t contain information on objects’
properties. You’ll need to pipe the objects to gm (Get-Member) to see a list of
properties.

Remember that you can add gm to the end of any pipeline that typically produces
results. A command line such as Get-Process -Name Code | Stop-Process doesn’t
usually produce results, so tacking | gm onto the end won’t produce anything
either.

Pay attention to neat typing. Put a space on either side of every pipeline
character, because your command lines should read as `Get-Process | gm` and
not `Get-Process|gm`. That spacebar key is extra large for a reason—use it.

Remember that the pipeline can contain various types of objects at each step.
Think about what type of object is in the pipeline, and focus on what the next
command will do to that type of object
