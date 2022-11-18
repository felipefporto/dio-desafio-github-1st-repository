-- cláusulas de ordenação
USE company;

SELECT Fname, Lname, Dno FROM employee;
SELECT Fname, Lname, Dno FROM employee ORDER BY (Dno);
SELECT Fname, Lname, Dno FROM employee ORDER BY fname, Lname;

SELECT Ssn, Salary FROM employee
	ORDER BY Salary DESC;
    
SELECT * FROM departament;
-- nome do departamento e gerente
SELECT DISTINCT d.Dname, concat(e.Fname,' ',e.Lname) AS Manager
	FROM departament AS d, employee AS e, works_on AS w, project AS p
	WHERE (d.Dnumber = e.Dno AND e.Ssn = d.Mgr_ssn AND w.Pno = p.Pnumber)
    ORDER BY d.Dname, e.Fname, e.Lname ASC;
    
-- empregados e seus projetos
SELECT DISTINCT d.Dname AS Department, concat(e.Fname,' ',e.Lname) AS Employee, p.Pname AS Project_Name
	FROM departament AS d, employee AS e, works_on AS w, project AS p
	WHERE d.Dnumber = e.Dno AND e.Ssn = w.Essn AND w.Pno = p.Pnumber
    ORDER BY d.Dname ASC, e.Fname ASC, e.Lname ASC;

-- sem alias na identificação dos atributos
SELECT Dname, Lname,Fname, Pname FROM departament, employee, works_on, project
	WHERE Dnumber = Dno AND Ssn = Essn AND Pno = Pnumber
	ORDER BY Dname, Lname,Fname;

-- colocando o alias
SELECT d.Dname, e.Lname, e.Fname, p.Pname FROM departament d, employee e, works_on w, project p
	where d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber
	ORDER BY Dname, Lname,Fname; 

-- desc e asc atribuídos a cada atributo separadamente
SELECT d.Dname, e.Lname, e.Fname, p.Pname FROM departament d, employee e, works_on w, project p
	where d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber
	ORDER BY Dname desc, Lname asc,Fname asc;    

--
--
-- Ordenação com expressões
--
--

-- ordenando com base na posição dos atributos
SELECT * FROM employee
ORDER BY 2, 5;

-- ordenando de acordo com os três ultimos n do ssn
SELECT e.Ssn, e.Fname, e.Lname, e.Super_ssn
FROM employee e
ORDER BY RIGHT(e.Super_ssn, 3);