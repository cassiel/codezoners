# WEEK 19: PLOTTING GLASTONBURY

We're using a data feed from The Guardian, [here](http://www.theguardian.com/news/datablog/2014/jun/04/glastonbury-2014-festival-full-list-of-acts-by-stage-and-start-time).

Download/export as CSV from the Google document. We've saved a copy here, under `glasto/data`.

Reading CSV files in D3: documentation [here](https://github.com/mbostock/d3/wiki/CSV).

This project folder is laid out assuming you'll be wanting to work in CoffeeScript. The command to watch the `coffee` directory and output Javascript for the web page is:

	coffee --watch --compile --output __js/ coffee/

Analysing the data: we've checked in a copy of `mori` (see [here](http://swannodette.github.io/mori/)) which provides Clojure's data structures and functions to Javascript. We can use this to do some simple analysis of the data.
