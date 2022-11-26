require_relative "lib/database_connection"
require_relative "lib/post_repository"
require_relative "lib/tag_repository"

DatabaseConnection.connect("blog_posts_tags")

repo1 = PostRepository.new
posts = repo1.find_by_tag("coding")

posts.each do |post|
  puts post.id, post.title
end

repo2 = TagRepository.new
tags = repo2.find_by_post(2)

tags.each do |tag|
  puts tag.id, tag.name
end
