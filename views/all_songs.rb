def showFirstTab(f1)
    songs = []
    songs = $dbHelper.getSongsFromDB()
    
    $fields = []

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
            $fields << TkLabel.new(f1) do
                text song[column_name]
                height 2
                width 20
                relief "ridge"
                grid(row: s_index+1, column: c_index, columnspan: 1)
            end
        end
    end
end

def emptyTable()
    $fields.each do |field|
        field.destroy
    end
end
