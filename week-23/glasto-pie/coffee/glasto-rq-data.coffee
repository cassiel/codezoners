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
                INSERT OR IGNORE INTO Appearance (Artist_ID, Stage_ID, StartTime, EndTime)
                SELECT Artist.ID AS Artist_ID,
                       Stage.ID AS Stage_ID,
                       DateTime($startTime),
                       DateTime($endTime)
                  FROM Artist, Stage
                 WHERE Artist.Name = $artist
                   AND Stage.Name = $stage
        """
        rows.forEach (r) ->
                #console.log "Inserting artist #{r.artist}"
                stmtA.bind '$artist': r.artist
                stmtA.run()
                stmtS.bind
                        '$artist': r.artist
                        '$stage': r.stage
                        '$startTime': r.startTimeStr
                        '$endTime': r.endTimeStr
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
        CREATE TABLE Appearance(Artist_ID Integer REFERENCES Artist(ID),
                                Stage_ID Integer REFERENCES Stage(ID),
                                StartTime DateTime NOT NULL,
                                EndTime DateTime NOT NULL)
"""
QUERY = """
        SELECT a.Name AS Name,
               s.Name AS Stage,
               g.Name AS StageGroup
          FROM Artist a, Stage s, StageGroup g, Appearance ast
         WHERE g.Name LIKE '%CIRCUS%'
           AND a.ID = ast.Artist_ID
           AND s.ID = ast.Stage_ID
           AND s.StageGroup_ID = g.ID
"""
dayToDateMap =
        "WEDNESDAY" : "2014-06-25"
        "THURSDAY"  : "2014-06-26"
        "FRIDAY"    : "2014-06-27"
        "SATURDAY"  : "2014-06-28"
        "SUNDAY"    : "2014-06-29"

define () ->
        # This is a bit of design smell, uncovered by the Require restructuring: geometry
        # declarations in the data generation!
        width = 960
        height = 500
        radius = Math.min(width, height) / 2

        withResults: (f) ->
                d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
                        .row (d) ->
                                # Make the field names more sanitary:
                                artist: d["Artist name"]
                                group: d["Stage group"]
                                stage: d["Stage"]
                                startTimeStr: '2014-06-25 03:00:00'
                                endTimeStr: '2014-06-25 06:00:00'

                        .get (error, rows) ->
                                results = []
                
                                populate db, rows

                                stmt = db.prepare QUERY
                                while stmt.step()
                                        results.push(stmt.getAsObject())

                                results.forEach (d) ->
                                        # We're still generating random values for angles and radius distances.
                                        # (But doing one per data query row.)
                                        d.startAngle = Math.random() * 2.0 * Math.PI
                                        d.endAngle = d.startAngle + Math.PI / 4.0
                                        d.outerRadius = radius - 10 - Math.random() * 30
                                        d.innerRadius = d.outerRadius - 60

                                f results
