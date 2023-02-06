Powershell offers two broad models to narrow results, the first model, we instruct the cmdlet that's retrieving the information for us to retrieve what we specified, while the second model takes an iterative approach, using a second cmdlet to filter the things we don't want.

The first technique is "early filtering" or "filter left" which is telling the cmdlet what we're after,
for example `Get-Process -Name p*, *s*` would get us what we asked for.

Filtering left means we put the critearia as far to the left or towards the begining of the command line as possible.

When we're not able to get a cmdlet to do the filtering as we need, we can use `Where-Object` to filter any kind of object we've retrieved.

To use `Where-Object`, we use comparison operators, which take two objects or values and test their relationship to one another. The result of the tested relationship is a boolean value.

Note: these comparators aren't case sensitive

Example: `-Equality` as in  value `5 -eq 5` would equal true or `"hello" -eq "help"` would equal false.

`-Not equal` as in  value `10 -ne 5` would equal true or `"help" -eq "help"` would equal false.

`-ge and -le` greater than or equal to and lesser than or equal to as in  value `10 -ge 5` would equal true or `(Get-Date) -le `2020-12-02` would depend on the date obtained.

`-gt and lt` less than and greater than as in `10 -lt 10` would be false.

For string comparison we can use case-sensitive operators such as `-ceq, -cne, -clt, -cge, -cle`\

If we want to compare more than one thing at once, we can use the logical operators `-and` or `-or`, for example: `(5 -gt 10) -and (10 -gt 100)`

We can use the logical `-not` operator that reverses true or false, for example, if we wanted to test a process that isn't responding, we could use a $_ as a placeholder for a process object:

Note: PowerShell defines $False and $True to represent the false and true booleans

`$_.Responding -eq $False` or `-not $._Responding`

Other comparisor operators when using strings of text:

`-like` (Accepts *, ?, [] as wildcards), so you can use it to compare "Hello" -like "*ll*" (would be True). The reverse is `-notlike` and BOTH ARE CASE INSENSITIVE, we can use `-clike` and `-cnotlike` to make case-sensitive comparisons.

`-match`makes a comparisong between a string of text and a regular expression pattern, its logical opposite is `-notmatch`and we use `-cmatch` and `-cnotmatch` for case-sensitive operations.

Once we've type a comparison, we use it with Where-Object, for example: 

`Get-Process | Where-Object -FilterScript {$_.WorkingSet -gt 100MB}` or `Get-Process | Where-Object {$_.WorkingSet -gt 100MB}`

When we pipe things to Where-Object, it examines each one of them using its filter. It places one object at a time into the `$_placeholder` and then runs the comparison to see if it's true or false. If it's false, then the object is dropped from the pipeline, if it's true, then it pipes the output to the next cmdlet, if there's not cmdlet it goes to the default display cmdlet `Out-Default`

Note: see that `$_.WorkingSet` is a placeholder for a propertie that belongs to that cmdlet, so we could see using `Get-Member` other placeholders with the actual property name that we could use.

There's also the iterative command-line model, the idea of this model is to not use a large, complex command line at once.

For example: if we wanted to measure the amount of virtual memory using by the 10 most virtual-memory-hungry processes while filtering out the PowerShell Processes we would need:

```bash
1. Get Processes
2. Get rid of everything that's PowerShell
3. Sort the process by virtual memory.
4. Keep only the top 10 or bottom 10, depending on how you sort them.
5. Add up the virtual memory for whatever is left.
```

The end result would come as:

```bash
1. Get-Process
2. Get-Process | Where-Object { $_.name -notlike 'pwsh*'}
3. Get-Process | Where-Object {$_.name -notlike 'pwsh*'} | Sort-Object VM -Descending
4. Get-Process | Where-Object {$_.name -notlike 'pwsh*'} | Sort-Object VM -Descending | Select -First 10
To get the entire sum:
5. Get-Process | Where-Object {$_.name -notlike 'pwsh*'} | Sort-Object VM -Descending | Measure-Object -Property VM -Sum
```

Note on when $_ is allowed:

For example: `Get-Process -Name (Get-Content c:\names.txt | Where-Object -filter { $_ -notlike '*daemon' }) | Where-Object -filter { $_.WorkingSet -gt 128KB }`

First the `Get-Content` gets run then it pipes its content to Where-Object, which will filter using `$_` the piped output to filter it with `-notlike` daemon, then the `Get-Process` cmdlet gets run with the last filtered output and pipes that output into the  `Where-Object` using the `$_.WorkingSet` placeholder.

Note: using (Get-Date).AddDays(-7) will return the date from a week ago.