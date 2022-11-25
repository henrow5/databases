require_relative "../app"

describe Application do
  def reset_tables
    seed_sql = File.read("spec/seeds_app.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it "asks for user input and returns a list of albums" do
    io = double(:io)
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("* 1 - Doolittle")
    expect(io).to receive(:puts).with("* 2 - Surfer Rosa")
    expect(io).to receive(:puts).with("* 3 - Waterloo")
    expect(io).to receive(:puts).with("* 4 - Super Trouper")

    app1 = Application.new(
      "music_library_test",
      io,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app1.run
  end

  it "asks for user input and returns a list of artists" do
    io = double(:io)
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("* 1 - Pixies")
    expect(io).to receive(:puts).with("* 2 - ABBA")
    expect(io).to receive(:puts).with("* 3 - Taylor Swift")
    expect(io).to receive(:puts).with("* 4 - Nina Simone")

    app1 = Application.new(
      "music_library_test",
      io,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app1.run
  end
end
