require 'sqlite3'

class DatabaseHelper
    $db = SQLite3::Database.open 'myDatabase.db'

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

            songs << Song.new(name, artist, year, genre, band, popular, country, duration, release_type, loudness)
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

    def addSongToDB()

    end

    def initialize()
        $db.execute "CREATE TABLE IF NOT EXISTS Songs(Name TEXT, Artist TEXT, Year int, Genre TEXT, Band bool, Popular bool, Country TEXT, Duration float, Album TEXT, Loudness int)"
    end



    #db.execute "INSERT INTO Songs (Name, Artist, Year, Genre, Band, Popular, Country, Duration, Album, Loudness)
    #VALUES ('Happier Than Ever', 'Billie Eilish', 2021, 'Pop', 0, 1, 'USA', 5.15, 'Single', 2);"
end