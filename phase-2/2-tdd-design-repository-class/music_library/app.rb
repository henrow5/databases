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

# puts result
# result.each do |record|
#   p record
# end

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   p artist
# end

album_repository.all.each do |album|
  p album.title
end
