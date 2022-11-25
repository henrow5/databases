TRUNCATE TABLE accounts, posts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email_address) VALUES ('john1', 'john1@redmail.com');
INSERT INTO posts (title, content, views, account_id) VALUES ('weather', 'it was sunny', '3', '1');
INSERT INTO posts (title, content, views, account_id) VALUES ('dinner', 'it was delicious', '5', '1');