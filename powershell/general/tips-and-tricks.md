Profiles:

We can create profiles to customize our experience when working with PowerShell, for example:

Taking the following profile script:

```bash
Import-Module ActiveDirectory
Import-Module DBATools
cd c:\
```

We can get more information if we run `help about_profiles`

The files that the console will try to load once it's starting are:

1. `$pshome\profile.ps1` - This will execute for all users of the computer, no matter
which host they’re using (remember that $pshome is predefined within
PowerShell and contains the path of the PowerShell installation folder).

2. `$pshome\Microsoft.PowerShell_profile.ps1` - This will execute for all users of
the computer if they’re using the console host.

3. `$pshome/Microsoft.VSCode_profile.ps1` If you are using the VS Code with
the PowerShell extension, this script will be executed instead.

4. `$home\Documents\WindowsPowerShell\profile.ps1` - This will execute only for
the current user (because it lives under the user’s home directory), no matter
which host they’re using.

5. `$home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` - This will execute for the current user if they’re using the console host. If they’re using VS Code with the PowerShell extension, the `$home\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1` script will be executed instead.

If one or more of these scripts don't exists, the hosting application will just skip to the next one in line.

We can see all our profiles by running `$Profile | Format-List -force`

More information about the running configs:

```bash
$pshome is a built-in PowerShell variable that contains the installation folder for
PowerShell itself; on most systems, that’s in C:\Program Files\PowerShell\7.

$home is another built-in variable that points to the current user’s profile folder
(such as C:\Users\Sarah).

We’ve used Documents to refer to the Documents folder, but on some versions of
Windows it will be My Documents.

We’ve written “no matter which host they’re using,” but that technically isn’t
true. It’s true of hosting applications (e.g., VS Code) written by Microsoft, but
there’s no way to force the authors of non-Microsoft hosting applications to follow these rules.
```

When we want the same profile to be run on the console and VS code, we should customize the profile on `$home\Documents\WindowsPowerShell\profile.ps1`

Prompt:

We can edit the prompt by adding to our profile a new function for prompt, taking the default function:

```bash
function prompt
{
$(if (test-path variable:/PSDebugContext) { '[DBG]: ' }
else { '' }) + 'PS ' + $(Get-Location) `
+ $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '
}
```

For example, we could change it to display the current time and current hostname:

```bash
function prompt {
$time = (Get-Date).ToShortTimeString()
"$time [$env:COMPUTERNAME]:> "
}
```

One of the things we should do is change the title of the window to display the current hostname, as:

```bash
$host.UI.RawUI.WindowTitle = "$env:username"
```

Colors:

To edit the colors we can do so by using the methods:

`(Get-Host).PrivateData.ErrorForegroundColor = "green"`

You can change colors for the following settings:

```bash 
- ErrorForegroundColor
- ErrorBackgroundColor
- WarningForegroundColor
- WarningBackgroundColor
- DebugForegroundColor
- DebugBackgroundColor
- VerboseForegroundColor
- VerboseBackgroundColor
- ProgressForegroundColor
- ProgressBackgroundColor
```

And here are some of the colors you can choose:

```bash
- Red
- Yellow
- Black
- White
- Green
- Cyan
- Magenta
- Blue
- DarkRed
- DarkYellow
- DarkGreen
- Darksoon..
```

Operators (-as, -is, -replace, -join, -split, -contains, -in)

`-as` used to convert datatypes, for example: `1000/3 -as [int]`

`-is` used to verify datatype, for example: `(Get-Date) -is [datetime]`

`-replace` used to replace all ocurrences of a string within another to a third string, for example:

`"172.16.5.135" -replace "5","70"`

The output would be "172.16.70.135"

`-join` and `-split` are used to convert arrays to delimited lists and vice versa, for example:

```bash
$array = "one","two","three","four","five"
$array
one
two
three
four
five
```

Now, using join:

```bash
$array -join "|"
one|two|three|four|five
```
Saving that result into a variable will let you reuse it, or even pipe it out to a file:

```bash
$string = $array -join "|"
$string
one|two|three|four|five
 $string | out-file data.dat
```
And using split:

```bash
gc computers.tdf
Server1 Windows East Managed
```

Keep in mind that gc is an alias for Get-Content.

You can use the -split operator to break that into four individual array elements:

```bash
$array = (gc computers.tdf) -split "`t"
$array
Server1
Windows
East
Managed
```

Notice the use of the escape character, a backtick, and a t (`t) to define the tab character. This has to be in double quotes so that the escape character will be recognized.

The resulting array has four elements, and you can access them individually by using
their index numbers:

`$array[0]` would output -> Server1

`-contains` and  `-in`:

The `-contains` operator is used to test whether a given object exists within a collection. For example:

```bash
$collection = 'abc','def','ghi','jkl'
$collection -contains 'abc'
True
$collection -contains 'xyz'
False
```

While the `-in` does the same thing but flips the order of the operands, so that the collection goes on the right and the test objects on the left:

```bash
$collection = 'abc','def','ghi','jkl'
'abc' -in $collection
True
'xyz' -in $collection
False
```

String Manipulation:

We can get many methods to use with strings by checking for example `"string" | get-member`

To name a few:

`Trim()` - Removes whitespace from both ends of a string.
`TrimStart() and TrimEnd()` - Remove whitespace from the beginning or end of a string, respectively:

```bash
$username = " Sarah "
$username.Trim()
Sarah
```

Date Manipulation:

We can get many methods to use with dates by checking for example `Get-date| get-member`

The methods enable two things: calculations and conversions to other formats. For
example, to get the date for 90 days ago, we like to use AddDays() with a negative
number:

```bash
$today = get-date
$90daysago = $today.adddays(-90)
90daysago
Saturday, March 13, 2021 11:26:08 AM
```

The methods whose names start with To are designed to provide dates and times in an
alternative format, such as a short date string:

```bash
$90daysago.toshortdatestring()
3/13/2021
```

These methods all use your computer’s current regional settings to determine the correct way of formatting dates and times.

When using PowerShell 5.1 we can convert vimobject strings that store data by:

```bash
$os = get-wmiobject win32_operatingsystem
$os.ConvertToDateTime($os.lastbootuptime
```

And we could format like in the example:

`get-wmiobject win32_operatingsystem | select BuildNumber,__SERVER,
[CA]@{l='LastBootTime';e={$_.ConvertToDateTime($_.LastBootupTime)}}`

Default Parameter Values:

Defaults are stored in a special built-in variable called `$PSDefaultParametersValues`, this variable is emtpy each time and is meant to be filled with a hash table (that we can script into a profile).

For example to store our credentials:

```bash
$credential = Get-Credential -UserName Administrator
-Message "Enter Admin credential"
$PSDefaultParameterValues.Add('*:Credential',$credential)
```

Or we can use the `Invoke-Command` to ask credentials every time it's run, for example:

```bash
$PSDefaultParameterValues.Add('Invoke-Command:Credential',
(Get-Credential -Message 'Enter administrator credential'
-UserName Administrator})
```

We can see that the basic format for the Add() method’s first argument is <-cmdlet>
:<parameter>, and <cmdlet> and can accept wildcards such as *. The second argument 
for the Add() method is either the value you want to make the default, or a script block
that executes another command or commands.

We can check what our default variables are by typing `$PSDefaultParameterValues`

We can read more about this in `about_parameters_default_values` help file

If used as `-PSDefaultParameterValues` within a script, it will only apply to that script.

Script Blocks:

```bash
$block = {
Get-process | sort -Property vm -Descending | select -first 10 }
```

It's everything that we encase in curly braces, to read more about these, we can read the `about_script_blocks` help file.
