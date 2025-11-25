-- SQL script to create the employee table
CREATE TABLE employee (
   id NUMBER primary key,
   name   VARCHAR2(50),
   salary NUMBER,
   bonus  NUMBER
);

-- Insert sample data into the employee table
INSERT ALL
    INTO employee (id, name, salary, bonus) VALUES (1,  'Alice',      50000, 0)
    INTO employee (id, name, salary, bonus) VALUES (2,  'John',       70000, 0)
    INTO employee (id, name, salary, bonus) VALUES (3,  'Grace',      0, 0)
    INTO employee (id, name, salary, bonus) VALUES (4,  'Michael',   -10000, 0)
    INTO employee (id, name, salary, bonus) VALUES (5,  'Daniel',     65000, 0)
    INTO employee (id, name, salary, bonus) VALUES (6,  'Sarah',      80000, 0)
    INTO employee (id, name, salary, bonus) VALUES (7,  'Peter',      50000, 0)
    INTO employee (id, name, salary, bonus) VALUES (8,  'Linda',      70000, 0)
    INTO employee (id, name, salary, bonus) VALUES (9,  'Brian',     110000, 0)
    INTO employee (id, name, salary, bonus) VALUES (10, 'Jennifer',   700000, 0)
SELECT * FROM dual;
