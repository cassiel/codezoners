# Read CSV file, generate vector graphics.

# This will log the entire dataset to the console:

populateStageGroups = (db, rows) ->
        stmt = db.prepare "INSERT OR IGNORE INTO StageGroup (Name) VALUES ($group)"
        rows.forEach (r) ->
                #console.log "Inserting group #{r.group}"
                stmt.bind '$group': r.group
                stmt.run()

populateStages = (db, rows) ->
        stmt = db.prepare """
                INSERT OR IGNORE INTO Stage (Name, StageGroup_ID)
                SELECT $stage AS Name, ID AS StageGroup_ID FROM StageGroup WHERE Name = $group
        """
        rows.forEach (r) ->
                #console.log "Inserting stage #{r.stage}"
                stmt.bind '$stage': r.stage, '$group': r.group
                stmt.run()

populateArtists = (db, rows) ->
        stmtA = db.prepare """
                INSERT OR IGNORE INTO Artist (Name) VALUES ($artist)
        """
        stmtS = db.prepare """
                INSERT OR IGNORE INTO Artists_Stages (Artist_ID, Stage_ID)
                SELECT Artist.ID AS Artist_ID, Stage.ID AS Stage_ID
                  FROM Artist, Stage
                 WHERE Artist.Name = $artist
                   AND Stage.Name = $stage
        """
        rows.forEach (r) ->
                #console.log "Inserting artist #{r.artist}"
                stmtA.bind '$artist': r.artist
                stmtA.run()
                stmtS.bind '$artist': r.artist, '$stage': r.stage
                stmtS.run()

populate = (db, rows) ->
        populateStageGroups db, rows
        populateStages db, rows
        populateArtists db, rows

sql = window.SQL
db = new sql.Database()

# Create tables, with some normalization.

# (We have to make assumptions based on an inspection of the
# data. Each stage only appears in one stage group (many<->one), but
# some artists appear on different stages (many<->many)).

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
        CREATE TABLE Artists_Stages(Artist_ID Integer REFERENCES Artist(ID),
                                    Stage_ID Integer REFERENCES Stage(ID),
                                    CONSTRAINT X UNIQUE (Artist_ID, Stage_ID))
"""

QUERYx = """
        SELECT a.Name AS Name,
               s.Name AS Stage
          FROM Artist a, Stage s, Artists_Stages ast
         WHERE a.Name LIKE 'TEMPLES'
           AND a.ID = ast.Artist_ID
           AND s.ID = ast.Stage_ID
"""
QUERY = """
        SELECT a.Name AS Name,
               s.Name AS Stage,
               g.Name AS StageGroup
          FROM Artist a, Stage s, StageGroup g, Artists_Stages ast
         WHERE g.Name LIKE '%CIRCUS%'
           AND a.ID = ast.Artist_ID
           AND s.ID = ast.Stage_ID
           AND s.StageGroup_ID = g.ID
"""

window.onload = ->
        d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
                .row (d) ->
                        artist: d["Artist name"]
                        group: d["Stage group"]
                        stage: d["Stage"]
                .get (error, rows) ->
                        populate db, rows

                        m1 = db.exec QUERY

                        result = []
                        result.push(m1[0].columns)
                        m1[0].values.forEach (r) -> result.push r

                        tr = d3.select("#main").append("table").selectAll("tr").data(result).enter().append("tr")
                        td = tr.selectAll("td").data((d) -> d).enter().append("td").text((d) -> "#{d}")
