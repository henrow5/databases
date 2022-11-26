require_relative "tag"

class TagRepository
  def find_by_post(id)
    sql = "SELECT tags.id,
                  tags.name
          FROM tags
          JOIN posts_tags ON posts_tags.tag_id = tags.id
          JOIN posts ON posts_tags.post_id = posts.id
          WHERE posts.id = $1;"

    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    tags = []
    result.each do |record|
      tag = Tag.new
      tag.id = record["id"]
      tag.name = record["name"]
      tags << tag
    end

    return tags
  end
end
