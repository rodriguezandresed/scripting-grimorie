Foreach:

For each allows us to iterate through a series of values in a collection of items.

`Foreach ( (temporary varible) in (collection of objects) ) {do something}` , the process block is surrounded by {}.

For example:

```bash
$array =1..10
foreach ($a in $array) {Write-output $a}
```

`Get-ChildItem | Foreach-object {$_.name} 

The aliast for Foreach-Object is % so, we could rewrite as:

`Get-ChildItem | % {$_.name}

We can also add the `-Parallel` parameter to enable parallel jobs, so for example:

`import-csv c:\scripts\newusers.csv | % {new-aduser -Name $_.Name}`

We could rewrite as:

`import-csv c:\scripts\newusers.csv | % -Parallel {new-aduser -Name $_.Name}`

We can increase the throttle of the parallel using the `-ThrottleLimit` parameter.

While loop:

This iterative loop will run until the termination condition is satisfied (meaning the condition is true)

For example:

```bash
$n=1
While ($n -le 10){Write-Output $n; $n++}
```

or

```bash
$date.day -ne 25 -and $date.month -ne 12
{Write-Host "Its not Christmas Yet"}
```

Do While:

This allows us to excecute the script block at least one and then evaluate our condition to see if we need to repeat the loop.

For Example:

```bash
$date = get-date

do{
Write-Output "Checking if the month is December"
$date=$date.AddMonths(1)
} while ($date.Month -ne 12)

