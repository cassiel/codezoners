`-*- mode: markdown; mode: visual-line; mode: adaptive-wrap-prefix; -*-`

# WEEK 31: WEB SERVERS WITH COMPOJURE

## Getting Started

Use the command

        lein new compojure project-name
        
to get a new project containing all the configuration and libraries to run a Clojure-based web server.

Then:

        cd project-name
        lein ring server-headless
        
to launch the server.
 
The Compojure server is smart enough to dynamically reload source files that you change. You can also bring up a REPL (a second Clojure process) in the same project to live-code (although you'll find that you can't run the main declarations of the server code, such as the `defroutes` code).
 
(TODO: bring up a REPL in the same Clojure session.)
 
If you want to understand what `lein ring` does for us, there's an article [here](http://www.learningclojure.com/2011/03/hello-web-dynamic-compojure-web.html), showing how to bring up the web server manually.
 
## Next Steps

Writing real HTML. Put this in strings in the handler routes, or statically in the `resources` directory. (Or, we could manually read from files, perhaps modifying the content on the fly, using `java.io.File` or `slurp`.)
 
Rendering HTML with Hiccup. We can start by doing this manually in a REPL. (We need `hiccup` as a dependency in `project.clj`; it's not required by Compojure itself.)
