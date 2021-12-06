require 'tk'
require_relative 'databasehelper'
require_relative 'classes/song'
require_relative 'views/all_songs'
require_relative 'views/top3_form'
require_relative 'views/add_song'

#GUI dalis
root = TkRoot.new
root.title = "Dainų registras"
root.height = 800
root.width = 1500

n = Tk::Tile::Notebook.new(root)do
   height 110
   place('height' => 800, 'width' => 1500, 'x' => 10, 'y' => 10)
end

showFirstTab(n)
showSecondTab(n)
showThirdTab(n)

Tk.mainloop