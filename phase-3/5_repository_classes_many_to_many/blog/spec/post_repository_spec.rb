require "post_repository"

def reset_tables
  seed_sql = File.read("spec/seeds_blog.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags_test" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_tables
  end

  it "returns all posts with the tag coding" do
    repo = PostRepository.new
    posts = repo.find_by_tag("coding")

    expect(posts[0].id).to eq("1")
    expect(posts[0].title).to eq("How to use Git")
    expect(posts[1].id).to eq("2")
    expect(posts[1].title).to eq("Ruby classes")
    expect(posts[2].id).to eq("3")
    expect(posts[2].title).to eq("Using IRB")
    expect(posts[3].id).to eq("7")
    expect(posts[3].title).to eq("SQL basics")
  end

  it "returns all posts with the tag travel" do
    repo = PostRepository.new
    posts = repo.find_by_tag("travel")

    expect(posts[0].id).to eq("4")
    expect(posts[0].title).to eq("My weekend in Edinburgh")
    expect(posts[1].id).to eq("6")
    expect(posts[1].title).to eq("A foodie week in Spain")
  end
end
