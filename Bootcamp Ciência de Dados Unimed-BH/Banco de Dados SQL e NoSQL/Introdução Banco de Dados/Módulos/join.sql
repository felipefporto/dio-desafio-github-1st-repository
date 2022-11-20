use company;

-- JOIN Statement
desc employee;
desc works_on;

select * from employee, works_on where Ssn = Essn;

-- JOIN
select * from employee JOIN works_on;

-- JOIN ON -> INNER JOIN ON

show tables;
desc departament; -- Dnumber

select * 
from employee 
	JOIN works_on 
		on Ssn = Essn;
        
select * 
from employee, works_on 
	WHERE Ssn = Essn;
    
--

select * from employee JOIN departament on Ssn = Mgr_ssn;

select Dname, Fname, Lname, Address
	from employee join departament on Dno=Dnumber;

select Dname, Fname, Lname, Address
	from (employee join departament on Dno=Dnumber)
    where Dname = 'Research';

select * from dept_locations;  -- address e Dnumber vamos usar como atributo de junção
select * from departament;     -- Dname, Dept_create_date

--

SELECT Dname AS Department, Dept_create_date AS StartDate, Dlocation AS Location
	FROM departament INNER JOIN dept_locations USING(Dnumber)
    ORDER BY StartDate;

SELECT Dname AS Department, Dept_create_date AS StartDate, Dlocation AS Location
	FROM departament JOIN dept_locations ON departament.Dnumber = dept_locations.Dnumber
    ORDER BY StartDate; 

--

-- CROSS JOIN = "só" JOIN -> produto cartesiano
-- existe uma convenção de sempre deixar explícito o tipo de JOIN usado

select * from employee cross join dependent;

--
--
-- JOIN com mais de 3 tabelas
--
--
DESC employee;
-- project, works_on e employee
SELECT concat(Fname,' ', Lname) AS Complete_name,
	Dno AS DeptNumber, 
    Pname AS ProjectName, 
	Pno AS ProjectNumber, 
	Plocation AS Location 
FROM employee
 	INNER JOIN works_on ON Ssn = Essn
    INNER JOIN project ON Pno = Pnumber
WHERE Pname LIKE 'Product%'
	ORDER BY Pnumber;

-- departament, dept_location, employee

SELECT Dnumber, Dname, concat(Fname,' ',Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus 
FROM departament
	INNER JOIN dept_locations USING(Dnumber)
	INNER JOIN employee ON Ssn = Mgr_ssn
	GROUP BY Dnumber;


SELECT count(*), Dnumber, Dname, concat(Fname,' ',Lname) AS Manager, Salary, round(Salary*0.05,2) AS Bonus 
FROM departament
	INNER JOIN dept_locations USING(Dnumber)
	INNER JOIN employee ON Ssn = Mgr_ssn
	GROUP BY Dnumber 
    HAVING count(*)>1;
        
SELECT Dnumber, Dname, concat(Fname,' ',Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus 
FROM departament
	INNER JOIN dept_locations 
    USING(Dnumber)
	INNER JOIN (dependent INNER JOIN employee ON Ssn = Essn) 
    ON Ssn = Mgr_ssn
	GROUP BY Dnumber;

--
--
-- OUTER JOIN
--
--

select * from employee;
select * from dependent;

select * from employee inner join dependent on Ssn = Essn;
select * from employee left join dependent on Ssn = Essn;

select * from employee left outer join dependent on Ssn = Essn;

select e.Lname as Employee, s.Lname as Manager 
	from (employee as e left outer join employee as s on e.Ssn = s.Super_ssn);


-- case statement

show databases;
use company;


show tables;

select Fname, Salary, Dno from employee;

-- desabilitar o safe mode
update employee set Salary =
		case 
			when Dno=5 then Salary+ 2000
            when Dno=4 then Salary+ 1500
            when Dno=1 then Salary+ 3000
            else Salary + 0
        end;







