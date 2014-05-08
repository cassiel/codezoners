`-*- mode: markdown; mode: visual-line; -*-`

# Hello

This markdown file can be compiled as CoffeeScript into Javascript with the command

        # coffee -c -l hello.md 

(The `#` is there so that the shell script line above is not itself compiled into JavaScript.) The `-l` means treat the input as "literate CoffeeScript", where the indented lines are code.)

Here's the CoffeeScript:

        console.log "The date is #{Date()}"
        
Compile it to `hello.js`, then run it using Node JS:

        # node hello.js
