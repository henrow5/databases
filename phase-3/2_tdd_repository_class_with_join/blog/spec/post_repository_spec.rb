require "post_repository"

def reset_tables
  seed_sql = File.read("spec/seeds_blog.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_test" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_tables
  end

  it "finds a post with related comments" do
    repo = PostRepository.new
    post = repo.find_with_comments(1)

    expect(post.title).to eq("weather")
    expect(post.content).to eq("it was sunny")
    expect(post.comments.length).to eq(2)
    expect(post.comments[0].name).to eq("Bruce")
    expect(post.comments[1].name).to eq("Clark")
    expect(post.comments[0].content).to eq("hot day")
    expect(post.comments[1].content).to eq("vitamin d!")
  end
end
