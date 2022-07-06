-- creating new table
CREATE TABLE student (id serial PRIMARY KEY,name varchar);

-- initiate synchronisation key
ALTER TABLE public.student REPLICA IDENTITY FULL;

-- inserting test data
INSERT INTO student (id, name)
VALUES
(01, 'Bob'),
(02, 'Sam');
