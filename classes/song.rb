class Song
   attr_reader :name, :artist, :year, :genre, :band, :popular, :country, :duration, :album, :loudness, :points
   def initialize()
      @points = 0
   end

   def addAllDetails(name, artist, year, genre, band, popular, country, duration, album, loudness)
		@name = name
		@artist = artist
		@year = year
		@genre = genre
		@band = band
		@popular = popular
		@country = country
		@duration = duration
		@album = album
      @loudness = loudness
	end

   def hasAllDetails()
      if (@name == nil || @artist == nil || @year == nil || @genre == nil || @band == nil || @popular == nil || @country == nil || @duration == nil || @album == nil || @loudness == nil)
         return false
      else
         return true
      end
   end

   def [](var_name)
      case var_name
      when "Name"
         return name
      when "Artist"
         return artist
      when "Year"
         return year
      when "Genre"
         return genre
      when "Band?"
         return band
      when "Popular?"
         return popular
      when "Country"
         return country
      when "Duration"
         return duration
      when "Album"
         return album
      when "Loudness"
         return loudness
      end
   end

	def add_point()
		@points+=1
	end
end