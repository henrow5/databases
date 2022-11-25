require "post_repository"

def reset_posts_table
  seed_sql = File.read("spec/seeds_posts.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "gets all posts" do
    repo = PostRepository.new
    posts = repo.all

    expect(posts.length).to eq(2)
    expect(posts.first.title).to eq("weather")
    expect(posts.first.content).to eq("it was sunny")
    expect(posts.first.views).to eq("3")
    expect(posts.first.account_id).to eq("1")
  end

  it "gets the single post weather" do
    repo = PostRepository.new
    post = repo.find(1)

    expect(post.title).to eq("weather")
    expect(post.content).to eq("it was sunny")
    expect(post.views).to eq("3")
    expect(post.account_id).to eq("1")
  end

  it "gets the single post dinner" do
    repo = PostRepository.new
    post = repo.find(2)

    expect(post.title).to eq("dinner")
    expect(post.content).to eq("it was delicious")
    expect(post.views).to eq("5")
    expect(post.account_id).to eq("1")
  end

  it "creates a new post" do
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = "interview"
    new_post.content = "got the job"
    new_post.views = "10"
    new_post.account_id = "1"

    repo.create(new_post)

    posts = repo.all
    last_post = posts.last

    expect(last_post.title).to eq("interview")
    expect(last_post.content).to eq("got the job")
    expect(last_post.views).to eq("10")
    expect(last_post.account_id).to eq("1")
  end

  it "deletes post with id 1" do
    repo = PostRepository.new

    delete_id = 1

    repo.delete(delete_id)

    all_posts = repo.all
    expect(all_posts.length).to eq(1)
    expect(all_posts.first.id).to eq("2")
  end

  it "deletes the two posts" do
    repo = PostRepository.new

    repo.delete(1)
    repo.delete(2)

    all_posts = repo.all
    expect(all_posts.length).to eq(0)
  end
end
