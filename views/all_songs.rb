def showFirstTab(n)
    db = DatabaseHelper.new()
    songs = []
    songs = db.getSongsFromDB()
    
    f1 = TkFrame.new(n)
    n.add f1, :text => 'All songs'

    # Display all songs, first tab
    column_names = ["Name", "Artist", "Year", "Genre", "Band?", "Popular?", "Country", "Duration", "Album", "Loudness"]
    column_names.each_with_index do |column_name, index|
        TkLabel.new(f1) do
            text column_name
            height 2
            width 20
            background "#BCBCBC"
            grid(row: 0, column: index, columnspan: 1)
        end
    end

    songs.each_with_index do |song, s_index|
        column_names.each_with_index do |column_name, c_index|
            TkLabel.new(f1) do
                text song[column_name]
                height 2
                width 20
                grid(row: s_index+1, column: c_index, columnspan: 1)
            end
        end
    end
end