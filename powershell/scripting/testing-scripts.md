We can use Pester to automatically test our scripts (https://github.com/pester/Pester/wiki)

We do Integration tests and unit tests.

Integration tests the end state of our commands, for example, if we wrote a script to create a SQL Server database, then an integration test would run the command then check if the database existed. (Treats the code as a blackbox, only checks the output)

Unit tests are more granular and they make sure our code is running. It checks if every command runs correctly.

To run pester:

Taking as example the following function:

```bash
function Set-ComputerState {
[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,
ValueFromPipeline=$True,
ValueFromPipelineByPropertyName=$True)]
[string[]]$ComputerName,
[Parameter(Mandatory=$True)]
[ValidateSet('Restart','Shutdown')]
[string]$Action,
[switch]$Force
)
BEGIN {}
PROCESS {
ForEach ($comp in $ComputerName) {
$params = @{'Computername' = $comp}
# force?
if ($force) {
$params.Add('Force',$true)
}
# which action?
If ($Action -eq 'Restart') {
Write-Verbose "Restarting $comp (Force: $force)"
Restart-Computer @params
} else {
Write-Verbose "Stopping $comp (Force: $force)"
Stop-Computer @params
}
}
} #PROCESS
END {}
}
```

Then we create a new fixture (couple of blank files one for our cude and one for our tests with a .tests.ps1 extension)

```bash
Import-Module Pester
mkdir test-example
New-Fixture -Path test-example -Name Set-ComputerState
```

The test script should look like:

```bash
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"
Describe "Set-ComputerState" {
It "does something useful" {
$true | Should Be $false
}
}
```

Then we edit the first test as:

```bash
Describe "Set-ComputerState" {
It "accepts one computer name" {
Set-ComputerState –computername SERVER1 –Action restart |
Should Be $true
}
}
```

Then since we don't want our command to run we need to create Mocks so it replaces the command we want to run with a fake one.

We do so by making our `Set-ComputerState` command to output a 1.

```bash
Describe "Set-ComputerState" {
Mock Restart-Computer { return 1 }
Mock Stop-Computer { return 1 }
It "accepts one computer name" {
Set-ComputerState -computername SERVER1 -Action Restart |
Should Be 1
}
}
```
To start the test, we type `Invoke-Pester`

Adding more tests would look like, and we would use the `Assert-MockCalled` command that tests how many times the mock was called and we -Scope It parameter so that it only counts for that block:

```bash
Describe "Set-ComputerState" {
Mock Restart-Computer { return 1 }
Mock Stop-Computer { return 1 }
It "accepts and restarts one computer name" {
Set-ComputerState -computername SERVER1 -Action Restart
Assert-MockCalled Restart-Computer -Exactly 1 -Scope It
}
It "accepts and restarts many names" {
$names = @('SERVER1','SERVER2','SERVER3')
Set-ComputerState -computername $names -Action Restart
Assert-MockCalled Restart-Computer -Exactly 3 -Scope It
}
It "accepts and restarts from the pipeline" {
$names = @('SERVER1','SERVER2','SERVER3')
$names | Set-ComputerState -Action Restart
Assert-MockCalled Restart-Computer -Exactly 3 -Scope It
}
}
```

We can get a report of the tests by `Invoke-Pester -CodeCoverage ./Set-ComputerState.ps1`



So a complete execution would look like:

```bash
Describe "Set-ComputerState" {
Mock Restart-Computer { return 1 }
Mock Stop-Computer { return 1 }
It "accepts and restarts one computer name" {
Set-ComputerState -computername SERVER1 -Action Restart
Assert-MockCalled Restart-Computer -Exactly 1 -Scope It
}
It "accepts and restarts many names" {
$names = @('SERVER1','SERVER2','SERVER3')
Set-ComputerState -computername $names -Action Restart
Assert-MockCalled Restart-Computer -Exactly 3 -Scope It
}
It "accepts and restarts from the pipeline" {
$names = @('SERVER1','SERVER2','SERVER3')
$names | Set-ComputerState -Action Restart
Assert-MockCalled Restart-Computer -Exactly 3 -Scope It
}
It "accepts and force-restarts one computer name" {
Set-ComputerState -computername SERVER1 -Action Restart -Force
Assert-MockCalled Restart-Computer -Exactly 1 -Scope It
}
Additional
tests232 CHAPTER 20 Pestering your script
It "accepts and shuts down one computer name" {
Set-ComputerState -computername SERVER1 -Action Shutdown
Assert-MockCalled Stop-Computer -Exactly 1 -Scope It
}
}
```

And the test report:

```bash 
Describing Set-ComputerState
[+] accepts and restarts one computer name 552ms
[+] accepts and restarts many names 64ms
[+] accepts and restarts from the pipeline 86ms
[+] accepts and force-restarts one computer name 277ms
[+] accepts and shuts down one computer name 115ms
Tests completed in 1.1s
Passed: 5 Failed: 0 Skipped: 0 Pending: 0 Inconclusive: 0
Code coverage report:
Covered 100.00 % of 10 analyzed commands in 1 file.
```