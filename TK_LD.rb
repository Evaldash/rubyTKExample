require 'tk'
require_relative 'classes/databasehelper'
require_relative 'classes/song'
require_relative 'views/all_songs'
require_relative 'views/top3_form'
require_relative 'views/add_song'

def refreshAllSongs(n, f1)
   emptyTable()
   showFirstTab(f1)
end

$dbHelper = DatabaseHelper.new()

#GUI dalis
root = TkRoot.new
root.title = "Dainų registras"
root.height = 800
root.width = 1500

n = Tk::Tile::Notebook.new(root)do
   height 110
   place('height' => 800, 'width' => 1500, 'x' => 10, 'y' => 10)
end

f1 = TkFrame.new(n)
n.add f1, :text => 'All songs'

TkButton.new(f1) do
   text 'Refresh'
   command {refreshAllSongs(n, f1)}
   grid(row: 100, column: 0, columnspan: 1)
end

f2 = TkFrame.new(n)
n.add f2, :text => 'TOP 3 form'

#Third tab: add song
f3 = TkFrame.new(n)
n.add f3, :text => '+ Add song'

showFirstTab(f1)
showSecondTab(f2)
showThirdTab(f3)

Tk.mainloop