# Read CSV file, generate vector graphics.

# This will log the entire dataset to the console:

#d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
#        .row (d) -> {name: d["Artist name"], stage: d["Stage"]}
#        .get (error, rows) -> console.log rows

# Let's get more selective, and start collating according to some of the columns.

m = mori

# We can't reliably do `console.log` on Mori data structures; we see the underlying representation instead.

d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
        .row (d) -> {name: d["Artist name"], stage: d["Stage"]}
        .get (error, rows) ->
                console.log (m.first (m.js_to_clj rows))
