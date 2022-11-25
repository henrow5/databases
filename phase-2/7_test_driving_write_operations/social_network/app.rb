# file: app.rb

require_relative "lib/database_connection"
require_relative "lib/post.rb"
require_relative "lib/post_repository"
# We need to give the database name to the method `connect`.
DatabaseConnection.connect("social_network")

repo = PostRepository.new

posts = repo.all

posts.each do |post|
  p "#{post.id} - #{post.title} - #{post.content} - #{post.views}"
end
