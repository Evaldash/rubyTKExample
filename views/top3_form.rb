def showSecondTab(f2)
    songs = []
    songs = $dbHelper.getSongsFromDB()
    params = {}

    distinct_artists = $dbHelper.getDistinctSpecified('Artist')
    distinct_genres = $dbHelper.getDistinctSpecified('Genre')
    distinct_countries = $dbHelper.getDistinctSpecified('Country')

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

    $minutes = TkVariable.new
    $seconds = TkVariable.new

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



    $first_place_field = TkLabel.new(f2) do
        grid(row: 9, column: 0, columnspan: 5)
    end

    $second_place_field = TkLabel.new(f2) do
        grid(row: 10, column: 0, columnspan: 5)
    end

    $third_place_field = TkLabel.new(f2) do
        grid(row: 11, column: 0, columnspan: 5)
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

 def showTop3(songs, f2)
    params = Hash.new { |hash, key| hash[key] = Array.new }
    
    params['fav_author'] = $fav_author_field.value.to_s
    if (params['fav_author'] == '' )
        showErrorPopup("Please select an author.")
        return
    end

    params['fav_genre'] = $fav_genre_field.value.to_s
    if (params['fav_genre'] == '' )
        showErrorPopup("Please select a genre.")
        return
    end

    params['fav_country'] = $fav_country_field.value.to_s
    if (params['fav_country'] == '' )
        showErrorPopup("Please select a country.")
        return
    end
    
    params['likes_popular'] = $likes_popular
    if (params['likes_popular'] == nil)
        showErrorPopup("Please select whether you like popular songs.")
        return
    end

    params['likes_older'] = $likes_older
    if (params['likes_older'] == nil)
        showErrorPopup("Please select whether you like older songs.")
        return
    end

    params['likes_loud'] = $likes_loud
    if (params['likes_loud'] == nil)
        showErrorPopup("Please select whether you like loud songs.")
        return
    end

    params['likes_band'] = $likes_band
    if (params['likes_band'] == nil)
        showErrorPopup("Please select whether you like band, or single artist songs.")
        return
    end

    params['prefered_length'] = $minutes.to_s + "." + $seconds.to_s
    
    temp_songs = Marshal.load( Marshal.dump(songs) )
    score_songs(temp_songs, params)

    descending  = -1
    sorted_songs = temp_songs.sort_by {|song| song["Points"] * descending}

    $first_place_field['text'] = '1. ' + sorted_songs[0]["Name"] + ' - ' + sorted_songs[0]["Artist"]
    $second_place_field['text'] = '2. ' + sorted_songs[1]["Name"] + ' - ' + sorted_songs[1]["Artist"]
    $third_place_field['text'] = '3. ' + sorted_songs[2]["Name"] + ' - ' + sorted_songs[2]["Artist"]
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
       
       minute_before = song["Duration"]-1
       minute_after = song["Duration"]+1
 
       if ((minute_before...minute_after).include? params['prefered_length'].to_f) then song.add_point() end            
    }
 end