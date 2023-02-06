Jobs are an extension point for PowerShell.

A process job is a command that runs in another PowerShell process in the background.

To launch one of these jobs we use the `Start-Job` command, a `-ScriptBlock` parameter, let us specify the command to run. PowerShell names these jobs as default names like (Job1, Job2, etc.) or we can specify it using `-Name`, and we can also instead of specifying an entire script block, we can use the `-FilePath`parameter to have the job execute an entire script file full of commands.

Example: `Start-Job -scriptblock { gci } `

The command also has a `-WorkingDirectory` parameter that allows us to change where the job starts on the filesystem. By default they always start on the home directory.

Example: `Start-Job -scriptblock {gci} -WorkingDirectory /tmp`



We can also create Thread jobs, that instead of running in a different PowerShell process, it runs in another thread in the same process.

Example:  `Start-Threadjob -ScriptBlock { gci }`

Usually we run thread jobs for short-term scripts or commands that we want to run fast, otherwise we use process jobs for long-running scripts.

We can check for uses with Jobs by `gmc cmdlet -Syntax` for example, with the `-AsJob` we can get multiple kinds of outputs.

The `Get-Job` cmdlet retrieves every currently defined job by the system and its status`

We can retrieve a specific job using `Get-Job`, for example: `Get-Job -id 1 | format-list`

Note on retrieivng Jobs:

We can use the `Recieve-Job` to retrieve the results from a job but:

- We need to specify the name or ID of the job.

- If we recieve the output from a parent job, we will also ge their childs.

- Once we retrieve a job it will DELETE it from memory, so we need to use the `-keep` parameter so it keeps a copy of the results.

- The job results are deserialized objects.


If a job has too many child jobs to list, we can list them differently as:

`get-job -id 1 | select-object -expand childjobs`

To manage jobs, we can:

`Remove-Job` to delete a job, and any output cached from memory.

`Stop-Job` to terminate stuck jobs (we can still recieve results generated up to that point).

`Wait-Job` to make jobs that are running or to start a job and we want the script to continue only when we job is done. (Forces PS to stop and wait until the job is done)

If `HasMoreData` is false, there were no outputs for that job.

We can get error messages of jobs using `Recieve-Job`

Example of jobs:

Getting all text files from the filesystem

`Start-ThreadJob { gci / -recurse -filter '*.txt'}

Or Remotely: `Invoke-Command -scriptblock {gci / recurse -filter *.txt} -computername (get-content computers.txt) -as job