-- nested (subqueries)
USE company;

SELECT DISTINCT Pnumber 
FROM project
WHERE Pnumber IN
	(SELECT DISTINCT Pno FROM works_on, employee WHERE Essn = Ssn AND Lname='Smith')
	OR
    Pnumber IN
	(SELECT Pnumber FROM project, departament, employee WHERE Mgr_ssn = Ssn AND Lname = 'Smith' AND Dnum = Dnumber);
    
SELECT * FROM project;

-- todos em employee
SELECT * FROM employee;

-- projetos em que Smith trabalha
SELECT Pno, Hours 
FROM works_on, employee
WHERE Essn = Ssn AND Lname='Smith';

-- Recupe todos do Essn especificado
SELECT DISTINCT * 
FROM works_on
WHERE (Pno, Hours) IN
	(SELECT Pno, Hours
    FROM works_on
    WHERE Essn = 123456789);

-- projetos em que Smith gerencia
SELECT Pnumber 
FROM project, departament, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND Lname='Smith';

--
-- Como retornar ambas informações em uma mesma query? 
--

-- retornar todos os projetos que Smith trabalha e gerencia
SELECT DISTINCT Pnumber
FROM project 
WHERE Pnumber IN 
		(SELECT Pnumber
        FROM project, departament, employee
        WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND Lname='Smith')
        OR 
        Pnumber IN
        (SELECT Pno 
        FROM works_on, employee
        WHERE Essn = Ssn AND Lname='Smith');
        
        
-- comparação com apenas um atributo
SELECT * FROM works_on;
SELECT DISTINCT Pno, Hours 
FROM works_on 
WHERE (Pno, Hours) IN 
	(SELECT Pno, Hours 
    FROM works_on
	WHERE Essn = '123456789');
                            
--
-- utilizando keywords
--

-- recuperando os maiores salários se comparados ao departamento 5 retorna os maiores salários de outros dpts
SELECT concat(Fname,' ',Lname) AS Complete_Name, Salary, Dno
FROM employee
WHERE Salary > ALL (SELECT Salary FROM employee WHERE Dno=5);

-- some e any?
SELECT concat(Fname,' ',Lname) AS Complete_Name, Salary, Dno 
FROM employee
-- IN and = ANY are not synonyms when used with an expression list. IN can take an expression list, but = ANY cannot
WHERE Salary = ANY (SELECT Salary
					FROM employee 
                    WHERE Dno=5);
                     
SELECT concat(Fname,' ',Lname) AS Complete_Name, Salary 
FROM employee
WHERE Salary < ALL (SELECT Salary 
					FROM employee 
                    WHERE Dno=5);
    
SELECT * FROM employee WHERE Dno=5;

--
-- Evitando ambiguidade 
--
--
SELECT E.Fname, E.Lname 
FROM employee AS e
WHERE e.Ssn IN (
	SELECT d.Essn 
    FROM dependent d 
    WHERE e.Fname = d.Dependent_name
    AND e.Sex = d.Sex
);
                    
SELECT concat(E.Fname, ' ', E.Lname) AS Complete_name_employee 
FROM employee AS e
WHERE e.Ssn IN (
	SELECT d.Essn 
    FROM dependent d 
    WHERE e.Ssn = d.Essn
    AND e.Sex = d.Sex
);
--                    
-- Subqueries com cláusuls existis e unique 
--
-- que possuem dependentes
SELECT e.Fname, e.Lname
	FROM employee AS e
	WHERE EXISTS (SELECT * 
				  FROM dependent AS d 
                  WHERE e.Ssn=d.Essn AND e.Sex = d.Sex
				  ); 

-- recuperando nome de empregados que não possuem dependentes
SELECT e.Fname, e.Lname 
	FROM employee AS e
	WHERE NOT EXISTS (SELECT *
					  FROM dependent AS d 
                      WHERE e.Ssn=d.Essn); 
                      
-- e os gerentes? tem dependentes?
SELECT e.Fname, e.Lname 
	FROM employee AS e
	WHERE EXISTS (SELECT * FROM dependent AS d 
				  WHERE e.Ssn=d.Essn)
                  AND
                  EXISTS (SELECT * FROM departament
                  WHERE Ssn = Mgr_ssn);

SELECT e.Fname, e.Lname FROM employee AS e, departament AS d
	WHERE (e.SSn = Mgr_ssn) AND EXISTS (SELECT * FROM dependent AS d
										WHERE e.Ssn = d.Essn);

-- acima de um n° de dependentes
SELECT e.Fname, e.Lname FROM employee AS e
	WHERE EXISTS (SELECT * FROM dependent AS d 
                  WHERE e.Ssn=d.Essn)
                  >=1;
                  
SELECT Fname, Lname FROM employee
	WHERE (SELECT count(*) FROM dependent WHERE Ssn = Essn) >= 2;



--
-- comparando com conjuntos explicítos
--

-- recuperando o ssn de todos empregados que trabalham nos projetos 1,2 ou 3
SELECT DISTINCT Essn, Pno FROM works_on WHERE Pno IN (1,2,3);