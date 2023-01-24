Functions need to be saved in order to be used in other sessions
We can see all functions of the current session using Function PS drive
Functions created have global scope by default, if we create them in a script, they have the scope of the script (they can't be used outside the script)

The Global keyword can be used to change the scope of a function

You can use Get-Help <command> in order to get information about that command
or `Help <command> -ShowWindow `
the `-ShowWindow` parameter opens a window that will show the documentation (and it's customizable)


Best Practices:

function name conventions of cmdlets i.e. - <Verb>-<noun> for example, `Get-Information`

Syntax to create function:

Function <Name of Function>
{ <Code Block>}

--------------------------


Parameters are used by users to provide custom input

We can use the Param keyword to define parameters

One / Many parameters can be defined

InteliSense is the name of the autocompletion funtionality 

------------------

Advance Functions:

CmdletBinding is used to create advanced functions (we add [CmdLetBinding()] as seen in practice 3)

Advanced functions allows you to make use of more inbuilt parameters

------------------

WhatIf & Confirm

Whatif is used to guess the expected output of change making commands in advanced

Confirm is used to be double sure about our actions

SupportShouldProcess keyword is used to include these 2 parameters

--------------

Mandatory

We use the Mandatory keyword to delcate a parameter to be mandatory (so that the use will always have to define it)

-------------------

Ensuring single value against a parameter

We can ensure the datatype and it to be a single value by defining parameters as [DataType]$parametername

We can make it so that the user can input multiple values by defining it as [Datatype[]


-----------------------

Defining default value of parameter

We can define the default value of a parameter such as  [DataType[]]$parametername = "default-value"


-----------


Add help documentation for a function

We write the help documentation between <# helpmessages #>

Keywords like SYNOPSIS, DESCRIPION, PARAMETER, EXAMPLE, INPUTS, OUTPUTS, NOTES are used to define it as .keyword


--------------------

Menu of Values

We use the ValidateSet keyword to define a menu of values inside the param arguments

