# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: accounts

Columns:
id | username | email_address
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE accounts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email_address) VALUES ('john1', 'john1@redmail.com');
INSERT INTO accounts (username, email_address) VALUES ('matt3', 'matt3@bluemail.com');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_accounts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/student.rb)
class Account
end

# Repository class
# (in lib/student_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email_address
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email_address FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  def create(account)
    # Executes the SQL query:
    # INSERT INTO accounts (username, email_address) VALUES($1, $2);

    # Returns nothing (only creates the record)
  end

  # Deletes an account record 
  # from given id
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1

    # Returns nothing (only deletes the record)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 Get all accounts

repo = AccountRepository.new
accounts = repo.all

accounts.length # =>  2
accounts.first.id # => '1'
accounts.first.username # = 'john1'

# 2 Get a single account

repo = AccountRepository.new
account = repo.find(1)

account.username # => 'john1'
account.email_address # => 'john1@redmail.com'

# 3 Get another account
repo = AccountRepository.new
account = repo.find(2)

account.username # => 'matt3'
account.email_address # => 'matt3@bluemail.com'

# 4 Create a new account
repo = AccountRepository.new

new_account = Account.new
new_account.username = 'richard5'
new_account.email_address = 'richard5@orangemail.com'

repo.create(new_account)

accounts = repo.all
last_account = accounts.last
last_account.username # => 'richard5'
last_account.email_address # => 'richard5@orangemail.com'

# 5 deletes account with id 1
repo = AccountRepository.new

delete_id = 1
repo.delete(delete_id)

all_accounts = repo.all
all_accounts.length # => 1
all_accounts.first.id # => '2'

# 6 deletes the two accounts 
repo = AccountRepository.new

repo.delete(1)
repo.delete(2)

all_accounts = repo.all
all_accounts.length # => 0

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._