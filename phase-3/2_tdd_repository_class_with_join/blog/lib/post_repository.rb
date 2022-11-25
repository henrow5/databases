require_relative "post"
require_relative "comment"

class PostRepository
  def find_with_comments(id)
    sql = "SELECT posts.title,
                  posts.content,
                  comments.name,
                  comments.content AS comment_content
          FROM posts
          JOIN comments ON comments.post_id = posts.id
          WHERE posts.id = $1;"

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    post = Post.new

    post.title = result.first["title"]
    post.content = result.first["content"]

    result.each do |record|
      comment = Comment.new
      comment.name = record["name"]
      comment.content = record["comment_content"]

      post.comments << comment
    end

    return post
  end
end
