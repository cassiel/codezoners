`-*- mode: markdown; mode: visual-line; mode: adaptive-wrap-prefix; -*-`

# WEEK 20: QUERYING GLASTONBURY

We're using a data feed from The Guardian, [here](http://www.theguardian.com/news/datablog/2014/jun/04/glastonbury-2014-festival-full-list-of-acts-by-stage-and-start-time).

Download/export as CSV from the Google document. We've saved a copy here, under `glasto/data`.

Reading CSV files in D3: documentation [here](https://github.com/mbostock/d3/wiki/CSV).

This project folder is laid out assuming you'll be wanting to work in CoffeeScript. The command to watch the `coffee` directory and output Javascript for the web page is:

	coffee --watch --compile --output __js/ coffee/

The plan is to read the CSV file into a relational database (using [SQL.js](https://github.com/kripken/sql.js), a cross-compiled version of [sqlite](http://www.sqlite.org/)). The sqlite site has a description of the SQL dialect.

Why SQL? So that we can do some interesting lookups (queries) into the data without writing lots of code. For example, interesting Glastonbury queries might be:

- What act is currently playing on this stage? (And who is on next?)

- What acts are on around 5pm?

- How often are TUMBELLINA on?

- Where and when is CATBALLOU playing?

- What stages are in the group SOUTH EAST CORNER?

- When and where is the first act tomorrow?

- What's the longest act in the whole festival?

- Have I missed THE WOODCRAFT FOLK?

There's an SQL introduction [here](http://www.1keydata.com/sql/sql.html). A more formal reference for `sqlite` is [here](http://www.sqlite.org/lang.html).

As we progress, we'll be doing some [normalization](http://databases.about.com/od/specificproducts/a/normalization.htm).
