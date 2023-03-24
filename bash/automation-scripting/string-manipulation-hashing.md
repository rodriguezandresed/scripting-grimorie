Note: we can execute the last command with a begining string using ! (event designator) for example, if our last command was `vim test.txt` we could type `!v` instead

We could generate random numbers using the current date and seconds passing as

`RANDOM=$(date +%s%N${RANDOM}${RANDOM} | shas256 | head -c48)`

We can break likes to 1 character using `fold -w1` and shufle the order of the lines using  `shuf` and then pick a character using `head c1`