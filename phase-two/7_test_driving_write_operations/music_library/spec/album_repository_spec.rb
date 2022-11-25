require "album_repository"

describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read("spec/seeds_albums.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
  end

  def empty_albums_table
    seed_sql = File.read("spec/seeds_empty.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it "returns two albums" do
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq(2)
    expect(albums.first.title).to eq("Bossanova")
    expect(albums.first.release_year).to eq(1999)
    expect(albums.first.artist_id).to eq(1)
  end

  it "returns an empty array" do
    empty_albums_table
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums).to eq([])
  end

  it "returns the single album Bossanova" do
    repo = AlbumRepository.new
    album = repo.find(1)

    expect(album.title).to eq("Bossanova")
    expect(album.release_year).to eq(1999)
    expect(album.artist_id).to eq(1)
  end

  it "returns the single album Surfer Rosa" do
    repo = AlbumRepository.new
    album = repo.find(2)

    expect(album.title).to eq("Surfer Rosa")
    expect(album.release_year).to eq(2001)
    expect(album.artist_id).to eq(1)
  end

  it "creates a new album" do
    repo = AlbumRepository.new

    new_album = Album.new
    new_album.title = "Trompe le Monde"
    new_album.release_year = 1991
    new_album.artist_id = 1

    repo.create(new_album)

    all_albums = repo.all

    expect(all_albums).to include(
      have_attributes(
        title: new_album.title,
        release_year: 1991,
        artist_id: 1,
      )
    )
  end
end
