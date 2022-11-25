TRUNCATE TABLE accounts, posts RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email_address) VALUES ('john1', 'john1@redmail.com');
INSERT INTO accounts (username, email_address) VALUES ('matt3', 'matt3@bluemail.com');