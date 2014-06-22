# Read CSV file, generate vector graphics.

# This will log the entire dataset to the console:

sql = window.SQL

db = new sql.Database()

db.run "CREATE TABLE Glasto(Name STRING, Stage STRING)"

d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
        .row (d) -> {name: d["Artist name"], stage: d["Stage"]}
        .get (error, rows) ->
                console.log rows
                stmt = db.prepare "INSERT INTO Glasto (Name, Stage) VALUES ($name, $stage)"
                rows.forEach (r) ->
                        stmt.bind '$name': r.name, '$stage': r.stage
                        stmt.run()
                console.log (db.exec "SELECT Count(*) FROM Glasto")
