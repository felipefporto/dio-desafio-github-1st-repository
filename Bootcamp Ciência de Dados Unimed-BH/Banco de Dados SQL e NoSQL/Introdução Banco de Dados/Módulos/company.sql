-- Criando Database Company;

CREATE SCHEMA IF NOT EXISTS company;
USE company;

-- Criação de um domínio no MySQL não dá, ex: D_num faça uma checagem de números inteiros para (D_num> 0 and D_num <21);

CREATE TABLE employee(
	Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL, 
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);


-- modificando a foreign key -> drop e add
ALTER TABLE employee 
	ADD CONSTRAINT fk_employee 
	FOREIGN KEY (Super_ssn) REFERENCES employee (Ssn) 
	ON DELETE SET NULL
    ON UPDATE CASCADE;
    
-- alter table add, drop or modify
-- para dropar ALTER TABLE 'nome da tabela' DROP CONSTRAINT 'nome da chave'
ALTER TABLE employee MODIFY Dno INT NOT NULL DEFAULT 1;

CREATE TABLE departament(
	Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE, 
    Dept_create_date DATE,
    CONSTRAINT chk_dept_date CHECK (Dept_create_date <= Mgr_start_date),
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE(Dname),
    CONSTRAINT fk_dept FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

ALTER TABLE departament DROP CONSTRAINT fk_dept;
ALTER TABLE departament 
	ADD CONSTRAINT fk_dept FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn) 
	ON UPDATE CASCADE;

-- para modificar uma constraint primeiro dropamos

CREATE TABLE dept_locations(
	Dnumber INT NOT NULL,
	Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation)
    CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
);

ALTER TABLE dept_locations DROP CONSTRAINT fk_dept_locations;
ALTER TABLE dept_locations 
	ADD CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
	ON DELETE CASCADE
    ON UPDATE CASCADE;
    
CREATE TABLE project(
	Pname VARCHAR(15) NOT NULL,
	Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    CONSTRAINT unique_name_project UNIQUE (Pname),
    CONSTRAINT fk_project FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
);

CREATE TABLE works_on(
	Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_works_on FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

CREATE TABLE dependent(
	Essn CHAR(9) NOT NULL,
    dependent_name VARCHAR(255) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(8),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

SELECT * FROM information_schema.table_constraints 
	WHERE (constraint_schema = 'company');
