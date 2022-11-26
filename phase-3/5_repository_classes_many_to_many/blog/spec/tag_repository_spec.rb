require "tag_repository"

def reset_tables
  seed_sql = File.read("spec/seeds_blog.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags_test" })
  connection.exec(seed_sql)
end

describe TagRepository do
  before(:each) do
    reset_tables
  end

  it "returns all tags from post with ID 2" do
    repo = TagRepository.new
    tags = repo.find_by_post(2)

    expect(tags[0].id).to eq("1")
    expect(tags[0].name).to eq("coding")
    expect(tags[1].id).to eq("4")
    expect(tags[1].name).to eq("ruby")
  end

  it "returns all tags from post with ID 6" do
    repo = TagRepository.new
    tags = repo.find_by_post(6)

    expect(tags[0].id).to eq("2")
    expect(tags[0].name).to eq("travel")
    expect(tags[1].id).to eq("3")
    expect(tags[1].name).to eq("cooking")
  end
end
