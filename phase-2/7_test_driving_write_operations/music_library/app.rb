require_relative "lib/database_connection"
require_relative "lib/artist_repository"
require_relative "lib/album_repository"
# We need to give the database name to the method `connect`.
DatabaseConnection.connect("music_library")

# Perform a SQL query on the database and get the result set.
# sql = "SELECT id, title FROM albums;"
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

# result = DatabaseConnection.exec_params("SELECT * FROM artists;", [])

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   p artist
# end

# album_repository.all.each do |album|
#   p album
# end

# artist = artist_repository.find(4)
# puts artist.name

# Get the album with id 3
# album = album_repository.find(3)

# puts "#{album.id} - #{album.title} - #{album.release_year}"

artist = Artist.new
artist.name = 'Kiasmos'
artist.genre = 'Electronic'

repo.create(artist) # INSERT INTO artists ...

repo.delete(id) # DELETE FROM artists WHERE id =

artist = repo.find(1)

artist.name = 'Whatever'

repo.update(artist) # UPDATE artists ... WHERE id = 

