require_relative "lib/database_connection"
require_relative "lib/post_repository"

DatabaseConnection.connect("blog")

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

repo = PostRepository.new
post = repo.find_with_comments(1)

puts "Comments for #{post.title}"
post.comments.each_with_index do |comment, index|
  puts "#{index + 1} - From: #{comment.name}, Comment: #{comment.content}"
end
