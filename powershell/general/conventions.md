On Windows the execution of scripts is disabled by default.

We can use the `Get-ExecutionPolicy` to view the current policy.

Using the `Set-ExecutionPolicy` we can change the setting in the REGISTRY so we need to have administrative permission to do so.

If a GPO is restricting the changes, it won't override unless we use the -ExecutionPolicy switch.

The commands are made of:

NOTHING IS CASE SENSITIVE

Main cmdlet, Parameters (they have a value and ALWAYS start with a -) and switches (no values)

`Get-Command -Verb Get -Module PSReadLine, PowerShellGet -Syntax`

`Command Parameter1 ParameterValue1 Parameter2 ParameterValue2 Switch`

We can use the cmdlet `Get-Alias -Definition "cmdlet to search"` to see the aliases that can be used.

The alias can be used with the help command.

Shortcuts:

Truncating parameter names: PS doesn't need you to type the entire parameter, just as long as you type enough that an autofiller would get what you wanted.

Ex: `-compo for -Composite`

If we want something for Powershell to not parse, we can hse --% and PS won't parse anything that's after the --%
