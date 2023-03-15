#! -> shebang { #sharp !bang}

Here we specify the interpreter of the script
`#!/bin/ruby` -> ruby script

We usually want our scripts have a permission of 755

Remember that we excecute the scripts as `./scriptname` (equivalent to current directory)

We can check if a command is a shell builtin using `type commandname`

And the directory using `type -a commandname`

We can't declare variables using dashes, or digits at the start, we can only use letters, underscore and digits and by convention, we use uppercase for variable names.

There are no spaces between the variable, the equal sign and the variable value!

Remember that  "" expands the variables (shows its values) and '' shows the literal strings!

For example: "This is a shell $VARIABLE" or "This is a shell ${VARIABLE}"

If we want to append text, we have to use the curly bracers!

Example: "${VARIABLE}ing is fun"

Combining variables:

"This is ${WORD}${ENDING}."

There are pre-established variables on bash:

We can see them on the `man bash` page, remember we can type `?$word` to reverse search for that word on the man page and `/$WORD` to do a forward search.

For example: when we're reading a manual and it says:

`command [OPTION1] ... [OPTION2]` means that we can have multiple options 1 and only 1 option 2, because of the (...), things in brackets are optional

To store the output of a command to a variable, we can do it as:

`USER_NAME=$(id-nu)`, we type the command inside parenthesis! or: ` `(id-nu)` ` (we surround it with ticks)

Semicolons on lines are line breakers

[[ -> expresion evaluators (they output an 1 or 0 depending on the output of the expression)

`help test | less ` shows us many evaluators to use

Scripts when they are executed correctly, they output a status of 0, we can make an exit then the script failed by typing `exit 1`, so that it will also output the status of 1. And for scripts if it completes it succesfully it will still output the latest command exit status

The variable `${?}` contains the latests status exit value.

== is used for pattern matching

We can prompt users for input by using the `read` command.

For example, this would store the input to the variable THING:  `read -p 'Type something: ' THING`

Note: the `/etc/login.defs` contains the configurations for the home directories (used by `useradd`)