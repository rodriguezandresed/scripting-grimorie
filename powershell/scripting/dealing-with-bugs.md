Dealing with syntax bugs:

We can use (and whe should because it's a recommended practice) `Set-StrictMode -Version 2.0` to make it so our parameters need to be specified by name when calling our script, for example:

`My-Function(1,2,3)` or `My-Function 1 2 3` won't work.

Only calling it as `My-Function -Param 1 -OtherParam 2 -ThirdParam 3` would work


When we are working with vscode we should use the `Set-PSBreakpoint` to set breakpoints in our script while debugging, that will allow us to examine the content of the variables line by line.

We can also set watches that allows us to see those watched variables state during the debugging process.