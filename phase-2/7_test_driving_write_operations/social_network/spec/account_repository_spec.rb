require "account_repository"

def reset_accounts_table
  seed_sql = File.read("spec/seeds_accounts.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do
    reset_accounts_table
  end

  it "returns a list of accounts" do
    repo = AccountRepository.new
    accounts = repo.all

    expect(accounts.length).to eq(2)
    expect(accounts.first.id).to eq("1")
    expect(accounts.first.username).to eq("john1")
  end

  it "returns john1 as the single account" do
    repo = AccountRepository.new
    account = repo.find(1)

    expect(account.username).to eq("john1")
    expect(account.email_address).to eq("john1@redmail.com")
  end

  it "returns matt3 as the single account" do
    repo = AccountRepository.new
    account = repo.find(2)

    expect(account.username).to eq("matt3")
    expect(account.email_address).to eq("matt3@bluemail.com")
  end

  it "creates a new account" do
    repo = AccountRepository.new

    new_account = Account.new
    new_account.username = "richard5"
    new_account.email_address = "richard5@orangemail.com"

    repo.create(new_account)

    accounts = repo.all
    last_account = accounts.last

    expect(last_account.username).to eq("richard5")
    expect(last_account.email_address).to eq("richard5@orangemail.com")
  end

  it "deletes account with id 1" do
    repo = AccountRepository.new

    delete_id = 1
    repo.delete(delete_id)

    all_accounts = repo.all
    expect(all_accounts.length).to eq(1)
    expect(all_accounts.first.id).to eq("2")
  end

  it "deletes the two accounts" do
    repo = AccountRepository.new

    repo.delete(1)
    repo.delete(2)

    all_accounts = repo.all
    expect(all_accounts.length).to eq(0)
  end
end
