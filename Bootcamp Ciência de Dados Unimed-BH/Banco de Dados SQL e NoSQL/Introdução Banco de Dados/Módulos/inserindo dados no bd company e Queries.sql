-- Inserção de Dados no BD
USE company;
SHOW TABLES;

SELECT * FROM employee;
INSERT INTO employee VALUES ('John', 'B', 'Smith', 123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, Null, 5),
							('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 123456789, 5),
                            ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 333445555, 4),
                            ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, 999887777, 4),
                            ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, 987654321, 5),
                            ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, 666884444, 5),
                            ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 453453453, 4),
                            ('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

SELECT * FROM dependent;
INSERT INTO dependent VALUES (333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
							 (333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
                             (333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
                             (987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
                             (123456789, 'Michael', 'M', '1988-01-04', 'Son'),
                             (123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
                             (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');

INSERT INTO departament VALUES ('Research', 5, 333445555, '1988-05-22','1986-05-22'),
							   ('Administration', 4, 987654321, '1995-01-01','1994-01-01'),
                               ('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');

INSERT INTO dept_locations VALUES (1, 'Houston'),
								  (4, 'Stafford'),
                                  (5, 'Bellaire'),
                                  (5, 'Sugarland'),
                                  (5, 'Houston');

INSERT INTO project VALUES ('ProductX', 1, 'Bellaire', 5),
						   ('ProductY', 2, 'Sugarland', 5),
						   ('ProductZ', 3, 'Houston', 5),
                           ('Computerization', 10, 'Stafford', 4),
                           ('Reorganization', 20, 'Houston', 1),
                           ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO works_on VALUES (123456789, 1, 32.5),
							(123456789, 2, 7.5),
                            (666884444, 3, 40.0),
                            (453453453, 1, 20.0),
                            (453453453, 2, 20.0),
                            (333445555, 2, 10.0),
                            (333445555, 3, 10.0),
                            (333445555, 10, 10.0),
                            (333445555, 20, 10.0),
                            (999887777, 30, 30.0),
                            (999887777, 10, 10.0),
                            (987987987, 10, 35.0),
                            (987987987, 30, 5.0),
                            (987654321, 30, 20.0),
                            (987654321, 20, 15.0),
                            (888665555, 20, 0.0);

-- Consultas SQL

SELECT * FROM employee;

-- gerente e seu departamento
SELECT Ssn, Fname, Dname FROM employee e, departament d WHERE (e.Ssn = d.Mgr_ssn);

-- funcionario e dependente
SELECT Fname, Relationship, Dependent_name FROM employee, dependent WHERE Essn = Ssn;

-- usando um filtro aleatório
SELECT Bdate, Address FROM employee
	WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Ssn, count(Essn) FROM employee e, dependent d WHERE (e.Ssn = d.Essn);
SELECT * FROM dependent;

-- recuperando departamento específico
SELECT * FROM departament WHERE Dname = 'Research';


SELECT Fname, Lname, Address FROM employee, departament
	WHERE Dname = 'Research' AND Dnumber = Dno;

DESC works_on;
SELECT * FROM project;

SELECT * FROM project, works_on WHERE Pnumber = Pno;

SELECT Pname, Essn, Fname, Hours 
FROM project, works_on, employee 
	WHERE Pnumber = Pno AND Essn = Ssn;
    
SHOW TABLES;
DESC departament;
DESC dept_locations;

SELECT * FROM departament;
SELECT * FROM dept_locations;

-- Retira ambiguidade atráves do Alias ou AS Statement
SELECT Dname, l.Dlocation AS Departament_name 
	FROM departament AS d, dept_locations AS l
	WHERE d.Dnumber = l.Dnumber;
    
SELECT concat(Fname, ' ', Lname) FROM employee;
SELECT concat(Fname, ' ', Lname) AS Employee FROM employee;
--
--
--
-- Expressões e concatenação de strings
--
--
-- recuperando informações dos departamentos presentes em Stafford
SELECT Dname AS Department, Mgr_ssn AS Manager, Dlocation 
FROM departament d, dept_locations l
WHERE d.Dnumber = l.Dnumber;

-- recuperando gerente e departamento
SELECT Dname AS Departament_name, concat(Fname,' ', Lname) AS Nome, Mgr_ssn AS Manager, Address
FROM departament d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Dlocation='Stafford' AND Mgr_ssn = e.Ssn;

-- padrão sql -> || no MySQL usa a função concat()
SELECT Dname AS Department, concat(Fname, ' ', Lname) 
FROM departament d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Mgr_ssn = e.Ssn;

-- recuperando info dos projetos em Stafford
SELECT * 
FROM project, departament 
WHERE Dnum = Dnumber AND Plocation = 'Stafford';

-- recuperando info sobre os departamentos e projetos localizados em Stafford
DESC project;
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project p, departament d, employee e
WHERE p.Dnum = d.Dnumber AND Mgr_ssn = Ssn AND
Plocation = 'Stafford';

SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project p, departament d, employee e
WHERE p.Dnum = d.Dnumber AND Mgr_ssn = e.Ssn AND p.Plocation = 'Stafford';

DESC employee;
SELECT * 
FROM employee 
WHERE Dno IN (1,2,3,6,9);

--
--
-- Operadores lógicos
--
SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

--
--
-- Expressões e alias
--
-- recolhendo o valor do INSS-*
SELECT Fname, Lname, Salary, Salary*0.011 FROM employee;
SELECT Fname, Lname, Salary, Salary*0.011 AS INSS FROM employee;
SELECT Fname, Lname, Salary, round(Salary*0.011,2) AS INSS FROM employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao ProdutoX
DESC project;
DESC works_on;
SELECT * 
	FROM employee AS e, works_on AS w, project AS p 
    WHERE e.Ssn = w.Essn AND w.Pno = p.Pnumber;
    
SELECT concat(e.Fname,' ', e.Lname) AS Complete_name, round(1.1*e.Salary,2) AS increased_sal 
	FROM employee AS e, works_on AS w, project AS p 
    WHERE e.Ssn = w.Essn AND w.Pno = p.Pnumber AND p.Pname='ProductX';

-- concatenando e fornecendo alias
SELECT Dname AS Department, concat(Fname, ' ', Lname) AS Manager FROM departament d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Mgr_ssn = e.Ssn;

-- recuperando dados dos empregados que trabalham para o departamento de pesquisa
SELECT Fname, Lname, Address FROM employee, departament
	WHERE Dname = 'Research' AND Dnumber = Dno;

-- definindo alias para legibilidade da consulta
SELECT concat(e.Fname,' ', e.Lname) AS Employee_name, e.Address 
FROM employee e, departament d
WHERE d.Dname = 'Research' AND d.Dnumber = e.Dno;
    
-- like e between

SELECT *
FROM employee;

SELECT concat(Fname,' ', Lname) AS Complete_Name, Dname AS Department_Name
FROM employee, departament
WHERE Dno = Dnumber AND Address LIKE '%Houston%';

SELECT concat(Fname,' ', Lname) AS Complete_Name, Address
FROM employee
WHERE Address LIKE '%Houston%';

SELECT concat(Fname,' ', Lname) AS Complete_Name, Salary
FROM employee
WHERE (Salary >= 30000 AND Salary <= 40000);

SELECT concat(Fname,' ', Lname) AS Complete_Name, Salary
FROM employee
WHERE (Salary BETWEEN 30000 AND 40000);