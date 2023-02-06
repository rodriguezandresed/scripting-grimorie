PowerShell uses a communication protocol called Web Services of Management (WSMan), it operates over HTTP (default) or HTTPS. Windows implementation of WSMan is called Windows Remote Management (disabled by default but can be enabled over GPO)

On the device that will connect to other devices:

`Install-Module -Name PSWSMan`

`sudo pwsh -Command 'Install-WSMan'

To Set Up SSH on Windows:

1. Install the OpenSSH client and Server:

```bash
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

2. Configure the SSH server:

```bash
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```

The Firewall rule should be already created, check by:

`Get-NetFirewallRule -Name *ssh*`

There should be a rule named OpenSSH-Server-In-TCP (and it should be enabled)

3. On the target machines we have to edit the sshd_config file located at `$env:ProgramData\ssh`

There we:

3.1. Verify that password authentication is enable by: `PasswordAuthentication yes`

3.2. Add the Subsystem for Powershell `Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo -NoProfile` or `Get-CimInstance Win32_Directory -Filter 'Name="C:\\Program Files"' | Select-Object EightDotThreeFileName`

3.3. (OPTIONAL) Enable Key authentication `PubkeyAuthentication yes`

4.Restart the OpenSSH Service `Restart-Service sshd`

5. Enable remoting Enable-PSRemoting 

Note: this enable listening ON ALL local IP addresses

This cmdlet starts the WinRM service, configure it to auto start, register PS as an endpoint and set up a firewall exception to permit WinRM traffic.

If we wanted to do it via GPO we could download the ADM template from (`www.microsoft.com/en-us/download`) and under Computer Configuration > Administrative Templates > Windows Components, near the bottom there should be the Remote Shell and Windows Remote Management

For macOS and Linux endpoints:

Installing the SSH server:

```bash
sudo apt install openssh-client
sudo apt install openssh-server
```

Enabling the Server:

`sudo systemsetup -setremotelogin on`

Enalbing PSRP over SSH:

`Install-Module EnableSSHRemoting`

`sudo pwsh -c Enable-SSHRemoting`

And restarting the OpenSSH service:

`sudo service sshd restart`

Powershell allows two types of connections, 1:1 and 1:many 

On Enter-PSSession 

-hostname is for SSH
-computername is for WinRM

Since PowerShell doesn't know what protocol we're trying to use, we have to tell it.

For example: 

`Enter-PSSession -HostName Ubuntu1 -Username tyler1`
`Enter-PSSession -ComputerName SRV2 -UserName contoso\tyler1`
`Enter-PSSession -ComputerName SRV2 -Credentials`

or the syntax:

`Enter-PSSession -HostName tyler1@Ubuntu1` (this will enter the domain if the username is in the domain)

To exit -> Exit-PSSession

In order to connect 1:N

We could use the `Invoke-Command` cmdlet such as:

`Invoke-Command -ComputerName SRV2, DC3, SRV4 -ScriptBlock { Get-Process pwsh } -UserName tyler1`

Everything between {} gets distributed to the remote computers.

Another example: `Invoke-Command -HostName SRV2, DC3, SRV4 -ScriptBlock { Get-Process pwsh |  Where-Object {$_.Parent.ProcessName -like '*term*'}} -Username

If we wanted to point to a file instead of the name of the hosts, we could:

`Invoke-Command -ScriptBlock { dir } -HostName (Get-Content webservers.txt) -UserName tylerl`

Difference between remote and local commands

1. Deserialized Objects, objects that come from remote commands, are not the same as if it was done locally. 

For example, `Get-Process` locally would bring a `System.Diagnostics.Process`, while done remotely it would bring a `Deserialized.System.Diagnostic.Process`, so it's only a read-only copy.

2. Local vs remote processing.

The result is serialized into an XML and that XML is recieved by the local device and deserializes it back into something that looks like an object but it's actually a log of an object.

A good use of remote processing would be : 

`Invoke-ScriptBlock -HostName SRV2,DC3,SRV4 -ScriptBlock { Get-Process pwsh -UserName tylerl | Where-Object {$_.Parent.ProcessName -like '*term*'}}` instead of 

`Invoke-ScriptBlock -HostName SRV2,DC3,SRV4 -ScriptBlock { Get-Process pwsh } -UserName tylerl | Where-Object {$_.Parent.ProcessName -like '*term*'}`

Because on the first command, we use the remote PCs to process their own results, instead of using our resources.

Another example:

`Invoke-ScriptBlock -ComputerName SRV2 -ScriptBlock { Get-Process -name pwsh } -UserName tylerl | Stop-Process`

and

`Invoke-ScriptBlock -ComputerName SRV2 -ScriptBlock { Get-Process -name pwsh } -UserName tylerl | Stop-Process }

The first version wouldn't work because it's trying to stop a log from a remote output, so the second version is the correct way of using the invocations.