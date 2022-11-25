TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES
  ('weather', 'it was sunny'),
  ('interview', 'got the job');


INSERT INTO comments (name, content, post_id) VALUES
  ('Bruce', 'hot day', 1),
  ('Clark', 'vitamin d!', 1),
  ('Barry', 'nice work!', 2),
  ('Hal', 'congratulations!', 2);