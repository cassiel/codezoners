`-*- mode: markdown; mode: visual-line; mode: adaptive-prefix; -*-`

# ajax-101

The directory `ajax-101` contains a complete Compojure server example. It uses Javascript to send data to the server, and to asynchronously handle the reply, using D3 to visualise it.

## Setup

The scripts are written in CoffeeScript, which has to be converted to Javascript (you should recall this from the exercises in weeks 14 and 15). Before the system will actually do anything useful, generate the Javascript. In `resources/public`:

	coffee --watch --compile --output __js/ coffee/
        
(For anyone like me using Emacs and generating pesky autosave files: replace `coffee/` with `coffee/*.coffee`, and restart if the set of files is changed.) You can omit the `--watch` if you aren't planning to repeatedly modify the CoffeeScript sources.

To run the server, use the standard Leiningen method. In the project root:

        lein ring server-headless
      
## Pages

Go to

        http://localhost:3000
        
You'll see three links to example pages. All of these use D3 for graphics; they vary in terms of how they determine where to draw the circles.

- Circles 1: uses a hard-wired array of values in the script, draw circles with varying X position and radius based on these values. (The buttons on the page are not used.)

- Circles 2: uses D3's ability to fetch CSV data from a URL. (We saw this with the Glastonbury timetable example.) The data is requested as soon as the page loads. The CSV file is static - you'll find it in `resources/public`. (Again, the buttons are not used.)

- Circles 3: as for Circles 2, but provides functions `clickRow` and `clickCol` which are attached to the buttons.

All three pages are simple drawing applications: they draw a grid of dots. We've built applications like this before, running purely in the browser; this one actually communicates with the server, which returns a list of point coordinates.

## How It Works

Look at `handler.clj`. It supports three routes (URLs):

- `/`: the root URL. This dynamically creates the list of other pages. (You have seen enough Hiccup now that the generation of this page should make sense, although it's a little intricate. Do an "Inspect Element" in Chrome to see how the HTML on the page relates to the Clojure code.)

- `/circles/:id`: the example pages. Any URL of the type `/circles/N` will match this, and call the function `page` with the integer value `N`.

- `/data/`: this route is called from the Javascript code, to return the data for the circles in Circles 3. It creates a CSV "file" from the number of rows and columns which are lifted from the request parameters (the binding in `[rows cols]`), using the function `create-CSV`. This route only accepts a `POST` request (for example, from an HTML form, although here D3 is taking care of the `POST` for us).

## Questions

- What exactly causes the three "circles" pages to generate different graphics? How would you go about building a fourth page (`/circles/4`)?

## Exercises

- [easy] Assume you're going to implement a Circles 4. Can you modify the root to add it to the links on the main page?

- [slightly harder] Can you get Circles 4 working just as a copy of one of the other pages (Circles 1 to 3)?

- [easy] In Circles 3, can you increase the horizontal spacing between the circles? (It's easy to do in the CoffeeScript once the data has arrived; for more credit, do it in Clojure, and don't alter the CoffeeScript at all.)

- [easy] I don't like the circle colours in Circles 2. Can you add some new colours to the CSV file, and make the CoffeeScript pick up and display the colours? (This doesn't require any modifications to the Clojure/Compojure code at all.)

- [moderate] Sticking with the colours example: can you make Circles 3 draw in random colours? This is pretty easy to do in CoffeeScript - can you do it on the server (returning the colours via CSV)?

- [hard] Can you implement `/circles/4` which draws a number of circles in random positions? (Ignore the on-page buttons.) Hint: you'll need a new CoffeeScript file for it. An easy way would be to do the random position generation in CoffeeScript (i.e. not talk to the server at all); for more credit, do it on the server in Clojure. (This makes it very similar to Circles 3.)

- [moderate] If you've done Circles 4: can you add an on-page button which randomises the circles each time you press it (with a round-trip request to the server)?

- [moderate] There are some unit tests in the project. At least one of them (expecting `"Hello World"`) will no longer work. Can you devise some tests for our application which ensure that we're getting the correct output?
