def showThirdTab(n)
    #Third tab: add song
    f3 = TkFrame.new(n)
    n.add f3, :text => '+ Add song (coming soon...)'

    field_names = ['Name', 'Artist', 'Year', 'Genre', 'Band?', 'Popular?', 'Country', 'Duration', 'Album', 'Loudness']

    field_names.each_with_index do |field_name, index|
    TkLabel.new(f3) do
        text field_name
        grid(row:index, column: 0, columnspan: 5)
    end
    TkEntry.new(f3) do
        grid(row:index, column:6, columnspan: 5)
    end
    end

    TkButton.new(f3) do
    text 'Add song'
    # command (proc {asdas})
    grid(row:15, column:6, columnspan: 5)
    end
end