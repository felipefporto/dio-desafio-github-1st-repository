-- funções e cláusulas de agrupamento

SELECT * FROM employee;
SELECT count(*) FROM employee;

SELECT count(*) FROM employee, departament
	WHERE Dno=Dnumber AND Dname = 'Research';

SELECT Dno, count(*), round(AVG(Salary),2) FROM employee
	GROUP BY Dno;

SELECT Dno, count(*) AS Number_of_employees, round(AVG(Salary),2) AS Salary_avg FROM employee
	GROUP BY Dno;
    
SELECT Pnumber, Pname, count(*)
	FROM project, works_on
    WHERE Pnumber = Pno
    GROUP BY Pnumber, Pname;

SELECT count(DISTINCT Salary) FROM employee;
SELECT sum(Salary) AS total_sal, 
	max(Salary) AS Max_sal, 
	min(Salary) AS Mini_sal, 
	round(AVG(Salary),2) AS Avg_sal 
FROM employee;


-- join será abordado no curso 5
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM (employee JOIN departament ON Dno = Dnumber)
WHERE Dname = 'Research';


SELECT Lname, Fname
FROM employee
WHERE ( SELECT count(*)
		FROM dependent
		WHERE Ssn = Essn) >= 2;
  
--
-- group by
--
	
show tables;
select Pnumber, Pname, count(*) as Number_of_register, round(avg(Salary),2) as AVG_Salary
	from project, works_on, employee
	where Pnumber = Pno and Ssn = Essn
    group by Pnumber, Pname;

select Pnumber, Pname, count(*) as Number_of_register, round(avg(Salary),2) as AVG_Salary
	from project, works_on, employee
	where Pnumber = Pno and Ssn = Essn
    group by Pnumber
    order by avg(Salary) desc;
    

--
--
-- group by e having
--
--

select Pnumber, Pname, count(*)
from project, works_on
where Pnumber = Pno
group by Pnumber, Pname
having count(*) > 2;

select Salary, Dno from employee;
select Dno, count(*)
	from employee 
	where Salary > 30000
    group by Dno
    having count(*)>=2;

select Dno as Department, count(*) as NumberOfEmployess from employee
	where Salary>20000 
		and Dno in (select Dno from employee
					group by Dno
					having count(*)>=2)
	group by Dno;