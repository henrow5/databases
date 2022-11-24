# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: posts

Columns:
id | title | content | views | account_id 
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
INSERT INTO posts (title, content, views, account_id) VALUES ('weather', 'it was sunny', '3', '1');
INSERT INTO posts (title, content, views, account_id) VALUES ('dinner', 'it was delicious', '5', '1');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < spec/seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/student_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :account_id
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
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, account_id) VALUES($1, $2);

    # Returns nothing (only creates the record)
  end

  # Deletes an account record 
  # from given id
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1

    # Returns nothing (only deletes the record)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 Get all Posts

repo = PostRepository.new
posts = repo.all

posts.length # =>  2
posts.first.title # => 'weather'
posts.first.content # => 'it was sunny'
posts.first.views # => '3'
posts.first.account_id # => '1'

# 2 Get a single post ('weather')

repo = PostRepository.new
post = repo.find(1)

post.title # => 'weather'
post.content # => 'it was sunny'
post.views # => '3'
post.account_id # => '1'

# 3 Get another post ('dinner')

repo = PostRepository.new
post = repo.find(2)

post.title # => 'dinner'
post.content # => 'it was delicious'
post.views # => '5'
post.account_id # => '1'

# 4 Create a new post

repo = PostRepository.new
new_post = Post.new
new_post.title = 'interview'
new_post.content = 'got the job'
new_post.views = '10'
new_post.account_id = '1'

repo.create(new_post)

posts = repo.all
last_post = posts.last
last_post.title # => 'interview'
last_post.content # => 'got the job'
last_post.views # => '10'
last_post.account_id # => '1'

# 5 deletes post with id 1
repo = PostRepository.new

delete_id = 1

repo.delete(delete_id)

all_posts = repo.all
all_posts.length # => 1
all_posts.first.id # => '2'

# 6 deletes the two posts
repo = PostRepository.new

repo.delete(1)
repo.delete(2)

all_posts = repo.all
all_posts.length # => 0
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