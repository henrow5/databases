TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, starting_date) VALUES
  ('January', '01-01-2022'),
  ('February', '01-02-2022');


INSERT INTO students (name, cohort_id) VALUES
  ('Bruce Wayne', 1),
  ('Clark Kent', 1),
  ('Barry Allen', 2),
  ('Hal Jordan', 2);