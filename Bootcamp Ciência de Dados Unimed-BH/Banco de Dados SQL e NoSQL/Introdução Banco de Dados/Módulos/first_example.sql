SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS first_example;
USE first_example;
SHOW TABLES;
CREATE TABLE IF NOT EXISTS person(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	gender enum('M','F'),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);
DESC person;

CREATE TABLE IF NOT EXISTS favorite_food(
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id)
    references person(person_id)
);

DESC favorite_food;

SHOW databases;
DESC information_schema.table_constraints;
SELECT * from information_schema.table_constraints
WHERE constraint_schema = 'person';
SELECT * FROM information_schema.table_constraints
WHERE constraint_schema = 'first_example';

DESC person;

INSERT INTO person VALUES('1', 'Karolina', 'Lucas', 'F', '1979-08-21','Rua XJ','Cidade J', 'PE','Brazil','260574'),
                         ('2', 'Carol', 'Bernardes', 'F', '1979-08-21','Rua XJ','Cidade J', 'PE','Brazil','260574'),
                         ('3', 'Carollyna', 'Oliveira', 'F', '1979-08-21','Rua XJ','Cidade J', 'PE','Brazil','260574'),
                         ('4', 'Carolina', 'Silvairo', 'F', '1979-08-21','Rua XJ','Cidade J', 'PE','Brazil','260574');

SELECT * FROM person;

DELETE FROM person WHERE person_id = 2 
				   OR person_id = 3
                   OR person_id = 4;

DESC favorite_food;
INSERT INTO favorite_food VALUES('0','Lasanha'),
								('1','Macarrão');
                                
SELECT * FROM favorite_food;

-- Union, Except, and Intersect

USE first_example;
CREATE TABLE R(
A VARCHAR(2)
);
CREATE TABLE S(
A varchar(2)
);

INSERT INTO R(A) VALUES ('a1'),('a2'),('a2'),('a3');
INSERT INTO S(A) VALUES ('a1'),('a1'),('a2'),('a2'),('a2'),('a3'),('a4'),('a5');

SELECT * FROM R;

-- EXCEPT -> NOT IN
SELECT * 
FROM S 
WHERE A NOT IN (SELECT A FROM R);

-- INTERSECT
SELECT R.A 
FROM R 
WHERE R.A IN (SELECT S.A FROM S);

SELECT DISTINCT R.A 
FROM R 
WHERE R.A IN (SELECT S.A FROM S);

-- UNION
(SELECT DISTINCT R.A FROM R) UNION (SELECT DISTINCT S.A FROM S);
(SELECT R.A FROM R) UNION (SELECT S.A FROM S); 