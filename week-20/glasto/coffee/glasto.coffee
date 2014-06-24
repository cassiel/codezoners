sql = window.SQL

db = new sql.Database()

db.run """
        CREATE TABLE StageGroup(ID Integer PRIMARY KEY,
                                Name STRING UNIQUE)
"""

db.run """
        CREATE TABLE Stage(ID Integer PRIMARY KEY,
                           Name STRING UNIQUE,
                           StageGroup_ID Integer REFERENCES StageGroup(ID))
"""

db.run """
        CREATE TABLE Artist(ID Integer PRIMARY KEY,
                            Name STRING UNIQUE)
"""

db.run """
        CREATE TABLE Artist_Stage_Linkage(Artist_ID Integer REFERENCES Artist(ID),
                                          Stage_ID Integer REFERENCES Stage(ID),
                                          CONSTRAINT C UNIQUE (Artist_ID, Stage_ID))
"""

populateStageGroups = (db, rows) ->
        stmt = db.prepare """
                INSERT OR IGNORE INTO StageGroup (Name) VALUES ($name)
        """
        rows.forEach (r) ->
                stmt.bind '$name': r.group
                stmt.run()

populateStages = (db, rows) ->
        stmt = db.prepare """
                INSERT OR IGNORE INTO Stage (Name, StageGroup_ID)
                SELECT $stage AS Name, ID AS StageGroup_ID FROM StageGroup WHERE Name = $group
        """
        rows.forEach (r) ->
                stmt.bind '$stage': r.stage, '$group': r.group
                stmt.run()

populate = (db, rows) ->
        populateStageGroups db, rows
        populateStages db, rows

window.onload = ->
        d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
                .row (d) ->
                        name: d["Artist name"]
                        stage: d["Stage"]
                        group: d["Stage group"]
                .get (error, rows) ->
                        populate db, rows
                        result = db.exec "SELECT * FROM StageGroup"

                        tableData = []
                        tableData.push result[0].columns
                        result[0].values.forEach (r) -> tableData.push r

                        tr = d3.select("#main").append("table").selectAll("tr").data(tableData).enter().append("tr")
                        td = tr.selectAll("td").data((d) -> d).enter().append("td").text((d) -> d)
