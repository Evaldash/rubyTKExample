def showThirdTab(n)
    #Third tab: add song
    $f3 = TkFrame.new(n)
    n.add $f3, :text => '+ Add song'
    fields = {}

    TkLabel.new($f3) do
        text 'Name'
        grid(row:0, column: 0, columnspan: 5)
    end
    fields["name_field"] = TkEntry.new($f3) do
        grid(row:0, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Artist'
        grid(row:1, column: 0, columnspan: 5)
    end
    fields["artist_field"] = TkEntry.new($f3) do
        grid(row:1, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Year'
        grid(row:2, column: 0, columnspan: 5)
    end
    fields["year_field"] = TkEntry.new($f3) do
        grid(row:2, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Genre'
        grid(row:3, column: 0, columnspan: 5)
    end
    fields["genre_field"] = TkEntry.new($f3) do
        grid(row:3, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Band?'
        grid(row:4, column: 0, columnspan: 5)
    end
    fields["band_field"] = TkEntry.new($f3) do
        grid(row:4, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Popular?'
        grid(row:5, column: 0, columnspan: 5)
    end
    fields["popularity_field"] = TkEntry.new($f3) do
        grid(row:5, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Country'
        grid(row:6, column: 0, columnspan: 5)
    end
    fields["country_field"] = TkEntry.new($f3) do
        grid(row:6, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Duration'
        grid(row:7, column: 0, columnspan: 5)
    end
    fields["duration_field"] = TkEntry.new($f3) do
        grid(row:7, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Album'
        grid(row:8, column: 0, columnspan: 5)
    end
    fields["album_field"] = TkEntry.new($f3) do
        grid(row:8, column:6, columnspan: 5)
    end

    TkLabel.new($f3) do
        text 'Loudness'
        grid(row:9, column: 0, columnspan: 5)
    end
    fields["loudness_field"] = TkEntry.new($f3) do
        grid(row:9, column:6, columnspan: 5)
    end

    TkButton.new($f3) do
    text 'Add song'
     command {add_song_if_ok(fields)}
    grid(row:15, column:6, columnspan: 5)
    end

    private def isOneOrZero(var)
        if (var!='0' && var!='1')
            return false
        else
            return true
        end
    end

    private def is_valid_duration(var)
        time = var.split('.')

        time.each do |part|
            puts part
        end
        
        if ( !(var =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/) || time.size!=2 || time[0].to_i<0 || time[1].to_i<0 || time[1].to_i>59)
            return false
        else
            return true
        end
    end
        

    private def showErrorPopup(msg)
        errorbox = Tk.messageBox(
            'type'    => "ok",  
            'icon'    => "error", 
            'title'   => "Error",
            'message' => msg
          )
    end

    private def add_song_if_ok(fields)
        db = DatabaseHelper.new()
        new_song = Song.new()

        name = fields["name_field"].get
        if (name == '')
            showErrorPopup('Please fill out the name field.')
            return
        end

        artist = fields["artist_field"].get
        if (artist == '')
            showErrorPopup('Please fill out the artist field.')
            return
        end

        year = fields["year_field"].get
        if (!(year.scan(/\D/).empty? and (1582..2500).include?(year.to_i)))
            showErrorPopup('Please enter a valid year.')
            return
        end

        genre = fields["genre_field"].get
        if (genre[/[a-zA-Z]+/]  != genre)
            showErrorPopup('Please enter a valid genre.')
            return
        end

        band = fields["band_field"].get
        if (!isOneOrZero(band))
            showErrorPopup('Please enter 0 or 1 in the band field.')
            return
        end

        popular = fields["popularity_field"].get
        if (!isOneOrZero(popular))
            showErrorPopup('Please enter 0 or 1 in the popularity field.')
            return
        end

        country = fields["country_field"].get
        if (country[/[a-zA-Z]+/]  != country)
            showErrorPopup('Please enter a valid country.')
            return
        end

        duration = fields["duration_field"].get
        if (!is_valid_duration(duration))
            showErrorPopup('Please enter the duration in this format: 1.12')
            return
        end

        album = fields["album_field"].get
        if (album == '')
            showErrorPopup('Please fill out the album field.')
            return
        end

        loudness = fields["loudness_field"].get
        if (!(loudness =~ /^[1-5]$/))
            showErrorPopup('Please enter a number 1-5 in the loudness field.')
            return
        end

        new_song.addAllDetails(name, artist, year, genre, band, popular, country, duration, album, loudness)
        db.addSongToDB(new_song)
    end
end