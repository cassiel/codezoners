# Read CSV file, generate vector graphics.

d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
        .get (error, rows) -> console.log rows
