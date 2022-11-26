-- Create the first table.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text
);

-- Create the second table.
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag_name text
);

-- Create the join table.
CREATE TABLE students_tags (
  student_id int,
  tag_id int,
  constraint fk_student foreign key(student_id) references students(id) on delete cascade,
  constraint fk_tag foreign key(tag_id) references tags(id) on delete cascade,
  PRIMARY KEY (student_id, tag_id)
);

INSERT INTO students (name) VALUES
('Bruce Wayne'),
('Clark Kent'),
('Hal Jordan');

INSERT INTO tags (tag_name) VALUES
('happy'),
('excited'),
('calm');

INSERT INTO students_tags (student_id, tag_id) VALUES
(1, 3),
(2, 1),
(3, 2);