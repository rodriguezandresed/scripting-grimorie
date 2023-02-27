We can use the `Trace-Command` to debug pipeline parameter binding, this cmdlet will show us the decisions powershell is making ahd the actions it's attempting to make.

The sintax is: `Trace-Command -Name ParameterBnding -Expression {our command here} -PSHost` 

Note that our command will actually run.

For example:

`Trace-Command -Expression {Get-Process | ConvertTo-Html | out-null } -Name ParameterBinding -PSHost`

There we can verify if PowerShell is makign coercion to parameters (for example: turning a numer into a string in order to keep going forward)