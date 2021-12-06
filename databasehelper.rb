require 'sqlite3'

class DatabaseHelper
    $db

    def getSongsFromDB()
        songs = []

        stm = $db.prepare("SELECT * FROM Songs")
        rs = stm.execute

        rs.each do |row|
            name = row[0]
            artist = row[1]
            year = row[2]
            genre = row[3]
            band = row[4]
            popular = row[5]
            country = row[6]
            duration = row[7]
            release_type = row[8]
            loudness = row[9]

            song = Song.new()
            song.addAllDetails(name, artist, year, genre, band, popular, country, duration, release_type, loudness)

            songs << song
        end
        
        return songs
    end

    def getDistinctSpecified(field_name)
        distinct_items = []

        query = "SELECT DISTINCT " + field_name + " FROM Songs"
        stm = $db.prepare(query)
        rs = stm.execute

        rs.each do |row|
            distinct_items << row[0]
        end

        return distinct_items
    end

    def addSongToDB(song)
        if (!song.hasAllDetails)
            return "Song is missing details."
        end

        query = "INSERT OR REPLACE INTO Songs (Name, Artist, Year, Genre, Band, Popular, Country, Duration, Album, Loudness)"
        query += "VALUES ('"
        query += song["Name"]
        query += "', '"
        query += song["Artist"]
        query += "', '"
        query += song["Year"]
        query += "', '"
        query += song["Genre"]
        query += "', "
        query += song["Band?"]
        query += ", "
        query += song["Popular?"]
        query += ", '"
        query += song["Country"]
        query += "', '"
        query += song["Duration"]
        query += "', '"
        query += song["Album"]
        query += "', '"
        query += song["Loudness"]
        query += "');"

        $db.execute(query)
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            puts e
        ensure
            $db.close if $db
    end

    def initialize()
        $db = SQLite3::Database.open 'myDatabase2.db'
        $db.execute "CREATE TABLE IF NOT EXISTS Songs(
            Name TEXT,
            Artist TEXT,
            Year int,
            Genre TEXT,
            Band bool,
            Popular bool,
            Country TEXT,
            Duration float,
            Album TEXT,
            Loudness int,
            CONSTRAINT unq UNIQUE (Name, Artist))"
    end
end