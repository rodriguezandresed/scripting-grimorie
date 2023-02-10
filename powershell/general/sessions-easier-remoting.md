There's another way of remoting called "implicit remoting" which allows us to add proxy commands by importing a module from a remote machine into our remote session.

We can create sessions with `New-PSSession` cmdlet, which will create a connection between my PowerShell and the remote PowerShell. We specify the computer name or hostname (or names), and if necessary, an alternative username, port, etc. 

We use can use SSH as opposed to WinRM by using the `-hostname` parameter.

for example: 

`New-PSSession -hostname PC1 -UserName Andres`

To retrieve the sessions we can use `Get-PSSession`

We can store sessions using variables to be then used with the Invoke-Command

For example: `$iis_server = new-pssesion -hostname pc1, pc2, pc3 -username Admin`

We can remove sessions using `remove-pssesion`

To remove all sessions `Get-PSSession | Remove-PSSession`

We can also:

`$session1, $session2 = new-pssession -computer srv02, dc01`

We can enter those sessions by:

`Enter-PSSession -Session $session1`

If we forget the index number of our session, we can use:

`$session1 | gm`

We could also query for a session using:

`enter-pssesion -session ($sessions | where {$_.computername -eq 'SRV02' })`

or

`Enter-PSSession -session (get-pssession -computer 'SRV02')`

And a more elegant way of doing it: `Get-PSSession -ComputerName SRV02 | Enter-PSSession`

As it turns out, PowerShell stores session objects in its master list of sessions (which we can access using `Get-PSSession`)

Then we can invoke commands to our sessions, for example:

`Invoke-Command -command {Get-Process} -session $session01`

or

`Invoke-Command -Command {get-process bits} -session (Get-PSSession -ComputerName server1, server2, server3)`


Implicit Remoting:

```bash
$session = new-pssession -comp SRV02	
invoke-command -command { import-module activedirectory} -session $session
import-pssession -session $session -module activedirectory -prefix rem
```

What we;re doing is stablishing a connection with a host that has Active Directory modules installed, we then import it and it stays loaded on the remote host, then we import those commands to our device, then we add a prefix (rem) so we can keep track of the imported commands, so PowerShell creates a temporary module in our computer that represents the remote commands (like shortcuts that point to the remote machine)

Now we can run Active Directory module commands and even ask for help, for example:

The `New-ADUser` can be run as  `New-remADUser` which will remain available until we close the shell or close that session with the remote host.

They're actually run on the remote host and we get sent the results as deserealized objects.

We use `Disconnect-PSSession -Id X` to disconect sessions but leave a running copy of powershell running on the host.

You can then reconnect to disconected sessions using `Get-PSSession -computername Computer2 | Connect-PSSession` and you could then continue where you left.

To keep sessions managed, we can specifiy:

In WSMan:\localhost\Shell:

`IdleTimeout`

Specifies the amount of time a session can be idle before it’s
shut down automatically. The default is about 2,000 hours (expressed in seconds), or about 84 days.

`MaxConcurrentUsers` 

Specifies the number of users who can have a session open at once.

`MaxShellRunTime` 

Determines the maximum amount of time a session can
be open. The default is, for all practical purposes, infinite. Keep in mind that
IdleTimeout can override this if the shell is sitting idle, as opposed to running commands.

`MaxShellsPerUser` 
Sets a limit on the number of sessions a single user can have open at once. Multiply this by MaxConcurrentUsers to figure out the maximum possible number of sessions, for all users, on the computer.

In WSMan:\localhost\Service:

–` MaxConnections—Sets `the upper limit on incoming connections to the
entire remoting infrastructure. Even if you allow a larger number of shells
per user or a maximum number of users, MaxConnections is the absolute
limit on incoming connections



