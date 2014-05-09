`-*- mode: markdown; mode: visual-line; -*-`

# WEEK 14

We're at the stage where should be moving away from working in just one language (Javascript) and getting comfortable with switching between languages, sometimes within the same project. We're already doing this to some extent: hosting Javascript inside HTML web pages and adding CSS for styling. However, HTML and CSS aren't really programming languages, so we want to look at other languages which have the expressive power of Javascript - this will help us learn how to recognise which features are specific to a particular language, and which are universal.

The next major jump I want to make is to Clojure: it's being used both as a front-end language (to build browser-based applications) and for the back-end (web services, database access, "big data"), so we can use it to explore a few other topics which I want to cover over the coming weeks. However, Javascript to Clojure is a big jump, partly because Javascript is encumbered with many instances of bad design (not least the syntax). So, we're going to look at CoffeeScript as an intermediate point. (If we ever need to write more Javascript, we might well use CoffeeScript instead.) We'll see things in CoffeeScript that we'll encounter in more depth in Clojure.

## CoffeeScript Reference

CoffeeScript is described [here](http://jashkenas.github.io/coffee-script/). It's a lightweight language that compiles into Javascript, and the output is readable - you can see how each CoffeeScript statement is converted into equivalent (but, generally, much messier) Javascript. The main page of this site gives a good overview of the main syntax features.

## Trying It Out

Click the "Try CoffeeScript" link to get an interactive CoffeeScript compiler. This page shows the generated Javascript, and also (when you clink "Run") executes it. (If you want to see some output, open this page in Chrome, use the `console.log` function for printing, and view the JavaScript console.)

## Getting Started

Try these small pieces of CoffeeScript, one at a time, and see what they generate in Javascript (and so, without looking them up, can you work out what they mean?):

        [1..10]

        -> 45

        (n * n for n in [1..5])

        colour: "RED"
        
        "RED" in ["RED", "BLUE"]
        
        [a, b] = [3, 4]
        
        {a, b} = {b: 3, a: 4}
        
        x: "RED", y: "BLUE"
        
        x:
            "RED"
        y:
            "BLUE"

(That last fragment is four lines long. All the others are single lines.) Can you also wrap a `console.log` call around each one to see what it evaluates to?

## Workflow

There is currently no compilation mode for CoffeeScript inside Light Table, although it will do syntax highlighting of CoffeeScript source files (with extension `.coffee`). CoffeeScript files have to be manually compiled into Javascript, using a CoffeeScript "compiler".

This is the installation procedure for OS X (at least, it's the scheme I used):

- Install MacPorts: see http://www.macports.org
- Install the NodeJS package manager: in a Terminal, type `sudo port install npm`
- Install CoffeeScript using `npm`: `sudo npm install -g coffee-script`

For Windows, download a NodeJS installer from [here](http://nodejs.org): that will provide the `npm` command.

Then you should be able to do things like this:

- `coffee` (starts an interactive interpreter to execute CoffeeScript statements)
- `coffee file.coffee` (compile and run a CoffeeScript file)
- `coffee -c file.coffee` (compile `file.coffee` to `file.js` - for example, to use in a web page)

## Literate Programming

The CoffeeScript compiler supports "literate programming", where the source code is embedded inside a document describing how it works. The compiler picks out the actual source code from the surrounding text. There's more information [here](http://jashkenas.github.io/coffee-script/#literate). In this project I have a file `hello.md` which is "literate" - run it with `coffee -l hello.md`.

## Practice

Here are some exercises based on the calculator we've been working on for the last few weeks. Before tackling these, make sure you're comfortable with the basics of CoffeeScript (converting and evaluating in the web browser, and using the "coffee" compiler in the command line, as above). The exercises are basically: convert the calculator code into CoffeeScript. Since CoffeeScript compiles into Javascript, you can do the conversion bit by bit.

- Start with `calctest.js` (the unit tests). These are an excellent candidate for literate programming, since the tests also act as a specification of the desired behaviour, so it's useful to add descriptions of what the tests are attempting to exercise. Can you create a `calctest.md` Markdown document which contains the tests, and also reads as a descriptive document? (Initially, you'll need to compile this to Javascript and paste it into Light Table to actually run the tests - the actual calculator is being built by the web page that Light Table renders. If that gets too tedious, by all means see if you can build the calculator as well, perhaps using [RequireJS](http://requirejs.org).)

- Look at the the jQuery linkage (`actions.js`) which captures the button clicking in the page. This is only three lines long, but is perhaps a little tricky, since the function nesting is not trivial. Can you write an `actions.coffee` which compiles into an equivalent `actions.js`? (You can test this conversion out in the browser-based CoffeeScript compiler.)

- The biggest job is the actual calculator (`calc.js`) but it should convert pretty cleanly, since it's pure Javascript.

- `components.js` (the React linkage) is not so obvious, since it has bits of JSX inside it, but it's possible to write for React without using JSX, so you could think about first removing the JSX phrases completely (replace them with calls to `React.DOM.[...]`) and then converting to CoffeeScript.

- Back to the calculator: can this be cleaned up a little by using CoffeeScript's classes? (JavaScript doesn't really have classes, as we've seen over the last week or two.)
