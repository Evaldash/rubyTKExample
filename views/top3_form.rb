def showSecondTab(n)
    db = DatabaseHelper.new()
    songs = []
    songs = db.getSongsFromDB()
    params = {}

    distinct_artists = db.getDistinctSpecified('Artist')
    distinct_genres = db.getDistinctSpecified('Genre')
    distinct_countries = db.getDistinctSpecified('Country')

    #Top 3 form, Second tab
    f2 = TkFrame.new(n)
    n.add f2, :text => 'TOP 3 form'


    TkLabel.new(f2) do
        text 'Choose your favourite artist.'
        grid(row: 0, column: 0, columnspan: 1, sticky: 'W')
        end
        $fav_author_field = TkCombobox.new(f2) do
        values distinct_artists
        grid(row: 0, column: 1, columnspan: 1)
    end



    TkLabel.new(f2) do
        text 'Choose your favourite music genre.'
        grid(row: 1, column: 0, columnspan: 1, sticky: 'W')
        end
        $fav_genre_field = TkCombobox.new(f2) do
        values distinct_genres
        grid(row: 1, column: 1, columnspan: 1)
    end



    TkLabel.new(f2) do
        text 'Choose a country'
        grid(row: 2, column: 0, columnspan: 1, sticky: 'W')
        end
        $fav_country_field = TkCombobox.new(f2) do
        values distinct_countries
        grid(row: 2, column: 1, columnspan: 1)
    end



    $likes_older = TkVariable.new
    $likes_popular = TkVariable.new
    $likes_loud = TkVariable.new
    $likes_band = TkVariable.new

    TkLabel.new(f2) do
        text 'Do you prefer older songs, or newer ones?'
        grid(row: 3, column: 0, columnspan: 1, sticky: 'W')
    end
    TkRadioButton.new(f2) do
        text 'Older'
        value 1
        variable $likes_older
        tristatevalue 1
        grid(row: 3, column: 1, columnspan: 1)
    end
    TkRadioButton.new(f2) do
        text 'Newer'
        value 0
        variable $likes_older
        tristatevalue 0
        grid(row: 3, column: 2, columnspan: 1)
    end

    TkLabel.new(f2) do
        text 'Do you like popular songs?'
        grid(row: 4, column: 0, columnspan: 1, sticky: 'W')
    end
    TkRadioButton.new(f2) do
        text 'Yes'
        value 1
        variable $likes_popular
        tristatevalue 1
        grid(row: 4, column: 1, columnspan: 1)
    end
    TkRadioButton.new(f2) do
        text 'No'
        value 0
        variable $likes_popular
        tristatevalue 0
        grid(row: 4, column: 2, columnspan: 1)
    end



    TkLabel.new(f2) do
        text 'Do you prefer band songs, or single artist ones?'
        grid(row: 5, column: 0, columnspan: 1, sticky: 'W')
    end
    TkRadioButton.new(f2) do
        text 'One artist'
        value 0
        variable $likes_band
        tristatevalue 0
        grid(row: 5, column: 1, columnspan: 1)
    end
    TkRadioButton.new(f2) do
        text 'Band'
        value 1
        variable $likes_band
        tristatevalue 1
        grid(row: 5, column: 2, columnspan: 1)
    end



    TkLabel.new(f2) do
        text 'Do you prefer loud, or quiet songs?'
        grid(row: 6, column: 0, columnspan: 1, sticky: 'W')
    end
    TkRadioButton.new(f2) do
        text 'Loud'
        value 1
        variable $likes_loud
        tristatevalue 1
        grid(row: 6, column: 1, columnspan: 1)
    end
    TkRadioButton.new(f2) do
        text 'Quiet'
        value 0
        variable $likes_loud
        tristatevalue 0
        grid(row: 6, column: 2, columnspan: 1)
    end



    TkLabel.new(f2) do
        text 'Set your perfect song length.'
        grid(row: 7, column: 0, columnspan: 1, sticky: 'W')
    end
    TkScale.new(f2) do
        orient 'horizontal'
        from 0
        to 7
        length 500
        variable $minutes
        grid(row: 7, column: 1, columnspan: 5)
    end
    TkLabel.new(f2) do
        text 'min'
        grid(row: 7, column: 6, columnspan: 1)
    end
    TkScale.new(f2) do
        orient 'horizontal'
        from 0
        to 59
        length 500
        variable $seconds
        grid(row: 7, column: 7, columnspan: 5)
    end
    TkLabel.new(f2) do
        text 's'
        grid(row: 7, column: 13, columnspan: 1)
    end



    TkButton.new(f2) do
        text 'Show me my Top 3'
        command (proc {showTop3(songs, f2)})
        grid(row: 8, column: 0, columnspan: 1)
    end


end

 def showTop3(songs, f2)
    params = Hash.new { |hash, key| hash[key] = Array.new }
    params['fav_author'] = $fav_author_field.value.to_s
    params['fav_genre'] = $fav_genre_field.value.to_s
    params['fav_country'] = $fav_country_field.value.to_s
    
    params['likes_popular'] = $likes_popular
    params['likes_older'] = $likes_older
    params['likes_loud'] = $likes_loud
    params['likes_band'] = $likes_band

    params['prefered_length'] = $minutes.to_s + "." + $seconds.to_s
 
    score_songs(songs, params)

    descending  = -1
    sorted_songs = songs.sort_by {|song| song["Points"] * descending}

    3.times {|i|
        TkLabel.new(f2) do
            text (i+1).to_s + '.' + sorted_songs[i].name + " - " + sorted_songs[i].artist
            grid(row: i+9, column: 0, columnspan: 3)
        end
    }
 end

 def score_songs(songs, params)
    songs.each {|song|
       if (song["Artist"] == params['fav_author']) then song.add_point() end
       if (song["Genre"] == params['fav_genre']) then song.add_point() end
       if (song["Country"] == params['fav_country'] ) then song.add_point() end
       if (song["Popular?"] == params['likes_popular']) then song.add_point() end
       if (song["Band?"] == params["likes_band"]) then song.add_point() end
       
       if (song["Loudness"]>3 && params['likes_loud']==1) then song.add_point()
       elsif (song["Loudness"]<=3 && params['likes_loud']==0) then song.add_point() end
 
       if (params['likes_older']=="true" && song["Year"] <=2000) then song.add_point()
       elsif (params['likes_older']=="false" && song["Year"] >=2000) then song.add_point() end   
       
       @minute_before = song["Duration"]-1
       @minute_after = song["Duration"]+1
 
       if ((@minute_before...@minute_after).include? params['prefered_length'].to_f) then song.add_point() end            
    }
 end