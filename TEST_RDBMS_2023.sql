select sysdate from dual;

select * from nls_database_parameters where parameter='NLS_CHARACTERSET';

SELECT * FROM NLS_DATABASE_PARAMETERS;	

Select owner, table_name, comments from ALL_TAB_COMMENTS ;

create table student(
id int PRIMARY KEY,
name varchar(30),
gpa decimal(3,2)
);

desc student;

drop table student;

alter table student add department varchar(30);

alter table student drop COLUMN department;

--In SQL, double quotes are used to mark identifiers, not string constants. "Veera"
insert into student(id,name,gpa) values (1,'Veera',6.5);
INSERT INTO student(id,name,gpa) VALUES (3,'Anitha',8.5);
INSERT INTO student(id,name,gpa) VALUES (4,'Arul',8.2);
INSERT INTO student(id,name,gpa) VALUES(5,'Ashwin',7.6); 
commit;

CREATE TABLE employee (
emp_id INT PRIMARY KEY,
ename VARCHAR(30),
job_desc VARCHAR(20),
salary INT );

desc employee;

INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(1,'Ram','ADMIN',1000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(2,'Harini','MANAGER',2500000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(3,'George','SALES',2000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(4,'Ramya','SALES',1300000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(5,'Meena','HR',2000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(6,'Ashok','MANAGER',3000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(7,'Abdul','HR',2000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(8,'Ramya','ENGINEER',1000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(9,'Raghu','CEO',8000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(10,'Arvind','MANAGER',2800000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(11,'Akshay','ENGINEER',1000000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(12,'John','ADMIN',2200000);
INSERT INTO employee(EMP_ID,ENAME,JOB_DESC,SALARY) VALUES(13,'Abinaya','ENGINEER',2100000);
commit;

SELECT * FROM employee;

SELECT * FROM employee
WHERE ename = 'Ramya'; 

SELECT emp_id,ename,salary FROM employee
WHERE salary>2000000; 

SELECT emp_id,ename,salary FROM employee
WHERE salary<2600000 AND job_desc = 'MANAGER'; 

SELECT * FROM employee
WHERE job_desc='ADMIN' OR job_desc='HR'; -- though this works next command is a much better choice

SELECT * FROM employee
WHERE job_desc IN ('ADMIN','HR'); 

SELECT * FROM employee
WHERE job_desc NOT IN ('MANAGER','CEO');

SELECT *
FROM employee
WHERE salary BETWEEN 2000000 AND 3000000
FETCH FIRST 5 ROWS ONLY; --limits the records shown 

SELECT * FROM employee
FETCH FIRST 5 ROWS ONLY;  -- Different syntax in oracle/sql server

SELECT * FROM employee
WHERE ename LIKE 'A%'; -- filters name starting with A

SELECT * FROM employee
WHERE ename LIKE 'R%a'; -- filters name starting WITH R AND ending with a

SELECT * FROM employee
WHERE ename LIKE '%a%'; -- filters name containing I

SELECT * FROM employee
WHERE ename LIKE '_a%'; -- filters name with i as second character

UPDATE employee
SET job_desc = "Analyst"
WHERE emp_id=1;

DELETE FROM employee; -- deletes all rows

DELETE from employee
WHERE emp_id = 12;

SELECT DISTINCT job_desc FROM employee; -- shows only distinct values without duplicates

SELECT * FROM employee
ORDER BY salary; -- order by salary asc

SELECT * FROM employee
ORDER BY salary ASC; -- order by salary asc

SELECT * FROM employee
ORDER BY salary DESC; -- order by salary desc

SELECT * FROM employee
WHERE job_desc="MANAGER"
ORDER BY salary DESC; -- order the manager salaries in desc order

SELECT * FROM employee
ORDER BY job_desc,ename; -- first sorts by job_desc and then by ename

SELECT * FROM employee
ORDER BY (CASE job_desc -- specific order
WHEN 'CEO' THEN 1
WHEN 'MANAGER' THEN 2
WHEN 'HR' THEN 3
WHEN 'ANALYST' THEN 4
WHEN 'SALES' THEN 5
ELSE 100 END);

--FUNCTIONS
--AGGREGATE FUNCTIONS

SELECT * FROM employee;
select count(*) from employee;
select count(1) from employee;

--Math functions
select AVG(salary) "Average" from employee;
select AVG(salary) "Average" from employee WHERE job_desc='MANAGER';
select SUM(salary) "SUM" from employee WHERE job_desc='ANALYST';
select * from employee where salary = (SELECT max(salary) from employee);
select min(salary) MIN_SAL from employee;

--String functions
select upper(e.ename) Name,e.* from employee e;
select lower(e.ename) Name,e.* from employee e;
select ename,LENGTH(ename) char_length from employee;
SELECT ename, 'Rs.' || TO_CHAR(salary, 'FM999,999,999') AS sal_deci FROM employee; --FOR FORMAT USE -> TO_CHAR
SELECT ename, SUBSTR(job_desc, 1, 4) FROM employee; --to get left 4 values
SELECT ename, SUBSTR(job_desc, LENGTH(job_desc) - 3) FROM employee; --to get right 4 values

--Using Date
select * from employee;
alter table employee add joining_date date;
desc employee;
update employee set joining_date = sysdate;
update employee set joining_date = '16-06-23' WHERE job_desc= 'MANAGER';
UPDATE employee SET joining_date = TO_DATE('2012-10-05', 'YYYY-MM-DD') WHERE job_desc= 'CEO';
commit;
select SYSDATE + 1 from dual;
SELECT TRUNC(SYSDATE) FROM DUAL;
select current_timestamp from dual;
SELECT TRUNC(current_timestamp) AS truncated_date FROM dual;
SELECT TO_CHAR(current_timestamp, 'HH24:MI:SS') AS current_time FROM dual;
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') FROM DUAL;
SELECT TRUNC(SYSDATE) - TO_DATE('2020-01-01', 'YYYY-MM-DD') AS DAYS FROM DUAL;
SELECT TRUNC(SYSDATE) AS "start date",
       TRUNC(SYSDATE) + INTERVAL '1' DAY AS "one day later",
       TRUNC(SYSDATE) + INTERVAL '7' DAY AS "one week later",
       ADD_MONTHS(TRUNC(SYSDATE), 1) AS "one month later",
       ADD_MONTHS(TRUNC(SYSDATE), 12) AS "one year later"
FROM DUAL;

rollback;

--Constraints
select * from employee;
drop table employee;

select ename, 'Rs.' || to_char(salary,'FM999,999,999') sal_deci from employee;

CREATE SEQUENCE emp_id_seq
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCYCLE
  CACHE 10;

SELECT emp_id_seq.CURRVAL FROM dual;

CREATE TABLE employee (
  emp_id INT DEFAULT emp_id_seq.NEXTVAL PRIMARY KEY,
  ename VARCHAR(30) NOT NULL,
  job_desc VARCHAR(20) DEFAULT 'unassigned',
  salary INT CHECK (salary > 100000),
  pan VARCHAR(13) UNIQUE
);

INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('Ram','ADMIN',1000000);
INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('Harini','MANAGER',2500000);
INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('George','SALES',2000000);
INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('Ramya','SALES',1300000);
INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('Meena','HR',2000000);
INSERT INTO employee(ENAME,JOB_DESC,SALARY) VALUES('Ashok','MANAGER',3000000);
commit;

--FOREIGN KEY 

CREATE SEQUENCE branch_id
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCYCLE
  CACHE 10
  ;

create table branch (
branch_id int default branch_id.nextval primary key,
branch_name varchar(20)not null,
branch_addr varchar(20)
);

-- create employee table with branch_id as foreign key. It refers to the branch_id of branch table.
create table employee(
emp_id int primary key,
emp_name varchar(20),
job_desc varchar(20),
salary int,
branch_id int,
constraint FK_branch_id foreign key(branch_id) references branch(branch_id)
);

ALTER table employee drop constraint FK_branch_id;

--Index
--Index are used for fast lookups. Speeds up select query but delays insert/update. Also take up more memory.

select index_name from dba_indexes where table_name = 'employee';
select index_name from all_ind_columns where table_name = 'employee';

CREATE INDEX name_index ON employee(emp_name); -- creates a new index

DROP INDEX name_index; -- drop index

--On Delete

CREATE SEQUENCE emp_id
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCYCLE
  CACHE 10
  ;
  
CREATE TABLE employee (
emp_id INT default emp_id.nwxtval primary key,
ename VARCHAR(30) NOT NULL,
job_desc VARCHAR(20),
salary INT,
branch_id INT,
CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id) 
ON DELETE CASCADE -- on deleting a row in branch table, the corresponding entries in employee table will be deleted
);

CREATE TABLE employee (
emp_id  INT default emp_id.nwxtval primary key,
ename VARCHAR(30) NOT NULL,
job_desc VARCHAR(20),
salary INT,
branch_id INT,
CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id) 
ON DELETE SET NULL -- on deleting a row in branch table, the branchid corresponding entries in employee table will be made null
);

--Joins
--Joins are used to join columns from two tables
drop table employee;
drop table branch;

CREATE TABLE branch (
branch_id INT default branch_id.nextval primary key,
br_name VARCHAR(30) NOT NULL,
addr VARCHAR(200) );

CREATE TABLE employee (
emp_id INT default emp_id.nextval primary key,
ename VARCHAR(30) NOT NULL,
job_desc VARCHAR(20),
salary INT,
branch_id INT,
CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

INSERT INTO branch(br_name,addr) VALUES('Chennai','16 ABC Road');
INSERT INTO branch(br_name,addr) VALUES('Coimbatore','120 15th Block');
INSERT INTO branch(br_name,addr) VALUES('Mumbai','25 XYZ Road');
INSERT INTO branch(br_name,addr) VALUES('Hydrabad','32 10th Street');

INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Ram','ADMIN',1000000,2);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Harini','MANAGER',2500000,2);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('George','SALES',2000000,1);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Ramya','SALES',1300000,2);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Meena','HR',2000000,3);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Ashok','MANAGER',3000000,1);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Abdul','HR',2000000,1);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Ramya','ENGINEER',1000000,2);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Raghu','CEO',8000000,3);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Arvind','MANAGER',2800000,3);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Akshay','ENGINEER',1000000,1);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('John','ADMIN',2200000,1);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Abinaya','ENGINEER',2100000,2);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Vidya','ADMIN',2200000,NULL);
INSERT INTO employee(ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES('Ranjani','ENGINEER',2100000,NULL);

select * from branch;
select * from employee;

--Inner join (using table name alias we're getting Only matching rows)

select emp.emp_id,emp.ename,emp.job_desc,emp.salary,br.br_name
from employee emp
inner join branch br 
on emp.branch_id = br.branch_id
order by emp_id;

-- below query gives same result without using join keyword
select emp.emp_id,emp.ename,emp.job_desc,emp.salary,br.br_name
from employee emp, branch br
where emp.branch_id = br.branch_id
order by emp_id;

-- Right join is matched rows + all other rows in right table
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
RIGHT JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- Left join is matched rows with all other rows in left table 
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
LEFT JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

select * from employee;
select * from branch;

-- Cross join joins each row of first table with every other row of second table
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
CROSS JOIN branch;
 
DROP TABLE employee; -- drop and freshly create

CREATE TABLE branch (
branch_id INT PRIMARY KEY AUTO_INCREMENT,
br_name VARCHAR(30) NOT NULL,
addr VARCHAR(200) );

CREATE TABLE employee (
emp_id INT PRIMARY KEY AUTO_INCREMENT,
ename VARCHAR(30) NOT NULL,
job_desc VARCHAR(20),
salary INT,
branch_id INT,
CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

INSERT INTO branch VALUES(1,"Chennai","16 ABC Road");
INSERT INTO branch VALUES(2,"Coimbatore","120 15th Block");
INSERT INTO branch VALUES(3,"Mumbai","25 XYZ Road");
INSERT INTO branch VALUES(4,"Hydrabad","32 10th Street");

INSERT INTO employee VALUES(1,'Ram','ADMIN',1000000,2);
INSERT INTO employee VALUES(2,'Harini','MANAGER',2500000,2);
INSERT INTO employee VALUES(3,'George','SALES',2000000,1);
INSERT INTO employee VALUES(4,'Ramya','SALES',1300000,2);
INSERT INTO employee VALUES(5,'Meena','HR',2000000,3);
INSERT INTO employee VALUES(6,'Ashok','MANAGER',3000000,1);
INSERT INTO employee VALUES(7,'Abdul','HR',2000000,1);
INSERT INTO employee VALUES(8,'Ramya','ENGINEER',1000000,2);
INSERT INTO employee VALUES(9,'Raghu','CEO',8000000,3);
INSERT INTO employee VALUES(10,'Arvind','MANAGER',2800000,3);
INSERT INTO employee VALUES(11,'Akshay','ENGINEER',1000000,1);
INSERT INTO employee VALUES(12,'John','ADMIN',2200000,1);
INSERT INTO employee VALUES(13,'Abinaya','ENGINEER',2100000,2);
INSERT INTO employee VALUES(14,'Vidya','ADMIN',2200000,NULL);
INSERT INTO employee VALUES(15,'Ranjani','ENGINEER',2100000,NULL);

SELECT * FROM employee;
SELECT * FROM branch;

--Relational operators
-- =,<=,>,>= | (!=,<>,^=) ->  same
select * from employee where salary ^= '1000000';

--Operational operators
select * from employee where job_desc = 'MANAGER' and salary >= '2500000';
select * from employee where job_desc = 'MANAGER' or salary >= '2500000';

--Special operators
select * from employee where emp_id between '3' and '12';
select * from employee where emp_id not between '3' and '12';
select * from employee where emp_id in ('3','12');
select * from employee where job_desc not in ('SALES','MANAGER');
select * from employee where emp_id not in ('3','12');
select * from employee where branch_id is null;
select * from employee where branch_id is not null;

--Like operators
select * from employee where ename like '%R%';
select * from employee where ename like '%R'; --end letter
select * from employee where ename like 'R%';--start letter
select * from employee where ename like '_a%';--wild card, second letter have letter 'a'
select * from employee where ename like '_____'; --name having 5 letters
select * from employee where ename not like '_____'; --name not having 5 letters

--Grouping and Having
select * from employee;
select job_desc,count(emp_id) from employee group by job_desc order by job_desc asc;
SELECT job_desc,COUNT(emp_id) AS count FROM employee GROUP BY job_desc HAVING COUNT(emp_id)>1 ORDER BY job_desc;
SELECT job_desc,COUNT(emp_id) AS count FROM employee GROUP BY job_desc HAVING COUNT(emp_id)>1 ORDER BY COUNT(emp_id) DESC ;
SELECT job_desc,COUNT(emp_id) AS count FROM employee WHERE salary>1500000 GROUP BY job_desc HAVING COUNT(emp_id)>1 ORDER BY COUNT(emp_id) DESC;
select job_desc,count(emp_id) from employee where salary > 1500000 group by job_desc order by job_desc asc;

select job_desc,count(*) from employee group by job_desc having count(*) > 2 ;
select job_desc,avg(salary) from employee group by job_desc having avg(salary) > 2000;
select job_desc,12*avg(salary) from employee group by job_desc;

--NVL
select ename,job_desc,NVL(Branch_id,0) from employee where job_desc = 'ENGINEER';

--NVL2
select branch_id,NVL2(Branch_id,'APPLICABLE','NOT-APPLICABLE') from employee e;

--DECODE
select ename,job_desc,decode(job_desc,'ADMIN',5,'MANAGER',4,2) as decoded from employee;

--CASE
SELECT
    ename,
    job_desc,
    case job_desc
    when  'MANAGER' then 2 
    when 'ENGINEER' then 3 
    else 6
    end as cases
    from employee;

--Column Functions

--1.Aggregate/Group functons ->SUM,AVG,MIN,MAX,COUNT,COUT(*)
select sum(salary) from employee;
select job_desc,sum(salary) from employee group by job_desc;

select AVG(salary) from employee;
select job_desc,AVG(salary) from employee group by job_desc;

select MAX(salary) MAX from employee where job_desc = 'MANAGER' ;
select MIN(salary) MIN from employee where job_desc = 'ENGINEER';

select job_desc,count(*) from employee group by job_desc;
select job_desc,count(*) from employee group by job_desc having count(*) > 2; --count(1),count(job_desc) ->all are same
select job_desc,count(distinct job_desc) from employee group by job_desc;

--2.Arithmetic
select abs(-12.52) from dual;
select MOD(15,0) from dual;
select power(4,2) from dual;
select power(-4,2) from dual;
select sqrt(23) from dual;
select floor(sqrt(23)) from dual;
select round(-12.5289,2) from dual;
select TRUNC(-12.5289,2) from dual;

--3.String or Character
concat(||)
select ename || '-' || job_desc "emp-job_desc" from employee;
select concat(ename,job_desc) from employee;

select upper(ename) || '-' || lower(job_desc) || '-' || INITCAP(job_desc)  "emp-job_desc" from employee;

select RPAD(ename,8,'*') from employee;
select LPAD(ename,8,'*') from employee;

select ename,length(ename) from employee;

select instr('INDIA','D') from dual; --to find letter position
select substr('INDIA',3,2) from dual; -- D as 1st and I as second

select ename from employee where soundex(ename) = soundex('Ram'); --its looklike 'like'

--4.Date
select sysdate from dual;
select add_months(to_date('25-06-23'),6) from dual;
select add_months(to_date(sysdate),-2) from dual;
select last_day(to_date('25-06-23')) from dual;
select months_between (to_date('25-06-23'),to_date('25-01-23')) from dual;
select least (to_date('25-06-23'),to_date('25-01-23'),to_date('25-01-22')) from dual;
select to_char(sysdate, 'MM-YYYY') from dual;
select current_timestamp from dual;
select localtimestamp from dual;
select systimestamp from dual;

-- inner join: only matching rows
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
INNER JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- below query gives same result without using join keyword
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee,branch
WHERE employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- using table name alias
SELECT e.emp_id,e.ename,e.job_desc,b.br_name
FROM employee AS e
INNER JOIN branch AS b
ON e.branch_id=b.branch_id
ORDER BY e.emp_id;

-- Right join is matched rows + all other rows in right table
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
RIGHT JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- Left join is matched rows with all other rows in left table 
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
LEFT JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- Full outer join combines row from bot the tables 
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
full outer JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

-- Cross join joins each row of first table with every other row of second table
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
CROSS JOIN branch;

-- displays the employee count in each branch
SELECT b.br_name,COUNT(e.emp_id)
FROM branch as b
JOIN employee as e
ON b.branch_id = e.branch_id
GROUP BY e.branch_id;

--Union
--union combines two table having equal number of columns and matching datatypes
CREATE SEQUENCE client_id
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCYCLE
  CACHE 10
  ;

-- create client table similar to branch table
CREATE TABLE clients (
client_id INT default client_id.nextval PRIMARY KEY ,
location VARCHAR(30) NOT NULL,
addr VARCHAR(200) );

INSERT INTO clients(LOCATION,ADDR) VALUES('NewYork','25 10th Block');
INSERT INTO clients(LOCATION,ADDR) VALUES('Coimbatore','120 15th Block');
INSERT INTO clients(LOCATION,ADDR) VALUES('London','21 ABC Road');

-- combines the two tables removing duplicates
SELECT * FROM branch
UNION 
SELECT * FROM clients;

-- combines the two tables without removing duplicates
SELECT * FROM branch
UNION ALL
SELECT * FROM clients;

--Subqueries, Exists, Any, All
--Subqueries combine more than 2 queries.

-- Displays employee list in Chennai Branch
SELECT * FROM employee
WHERE branch_id = (SELECT branch_id
FROM branch
WHERE br_name='Chennai');

-- Displays the employees with min salary
SELECT * FROM employee
WHERE salary = (SELECT MIN(salary)
FROM employee);

-- displays the branches containing atleast one admin
SELECT branch.branch_id,branch.br_name,branch.*
FROM branch
WHERE EXISTS 
( SELECT * FROM employee
WHERE job_desc='ADMIN' AND branch.branch_id = employee.branch_id);

-- displays the branch info in which any employee gets more than 25L
SELECT branch_id,br_name
FROM branch
WHERE branch_id = ANY
(SELECT branch_id FROM employee
WHERE salary>2500000);

-- displays employees not working in chennai or coimbatore
SELECT * FROM employee 
WHERE branch_id != ALL ( SELECT branch_id FROM branch
WHERE br_name IN ('Chennai','Coimbatore'));


--VIEW
CREATE VIEW emp_br
AS
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
INNER JOIN branch
ON employee.branch_id=branch.branch_id
ORDER BY emp_id;

SELECT * FROM emp_br; -- selecting all rows from view

DROP VIEW emp_br; -- delete view

CREATE OR REPLACE VIEW emp_br  -- modify view
AS 
SELECT employee.emp_id,employee.ename,employee.job_desc,branch.br_name
FROM employee
INNER JOIN branch
ON employee.branch_id=branch.branch_id;

select * from emp_br order by 1 desc;

--MERGE TABLE
CREATE TABLE employee_temp (
emp_id INT ,
ename VARCHAR(30) NOT NULL,
job_desc VARCHAR(20),
salary INT,
branch_id INT
);

select * from employee;
select * from employee_temp;

INSERT INTO employee_temp(emp_id,ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES(2,'Ram','ADMIN',2000000,2);
INSERT INTO employee_temp(emp_id,ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES(17,'Harini','MANAGER',2500000,2);
INSERT INTO employee_temp(emp_id,ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES(18,'George','SALES',2000000,1);
INSERT INTO employee_temp(emp_id,ENAME,JOB_DESC,SALARY,BRANCH_ID) VALUES(19,'Ramya','SALES',1300000,2);
commit;

MERGE INTO employee e
USING employee_temp t ON ( e.emp_id = t.emp_id )
WHEN MATCHED THEN UPDATE
SET e.job_desc = t.job_desc,
    e.salary = t.salary,
    e.branch_id = t.branch_id

WHEN NOT MATCHED THEN
INSERT
VALUES
    ( t.emp_id,
      t.ename,
      t.job_desc,
      t.salary,
      t.branch_id );

--SYNONYMS
create synonym employee_synonym for employee;
select * from employee_synonym;

--INDEX
create index emp_name_idx on employee(ename);

--PL/SQl -> Procedural Language extension to the Structured Query Language

--ADVANTAGES:
--Support for SQL
--Improved performance
--High productivity, Portability
--Integeration with Oracle

--Features:
--we can define variables and constraints
--we can use control statements, loops,cursors etc.,
--Excpetion Handling
--We can write modular applications by using subprograms. the diff.types of sub pgm is prc,pkgs and functions.

--Structural of a PL/SQL Block

--DECLARE (optional section)
--Declarative section
--PL/SQL variables,types,cursors and local sub pgms are defined here.

--BEGIN
--Execcutable section
--Mandatory section

--EXCEPTION
--Optional section

--END;

--TWO Types of PL/SQL Blocks

--Anonymous block
DECLARE
    v_ename    VARCHAR2(10) := 'Veera';
    v_job_desc VARCHAR2(10) := 'Engineer';
    v_salary   NUMBER(10) := 1256423;
    V_BRACH_ID NUMBER(10) := 2 ; 
BEGIN
    INSERT INTO employee (
        ename,
        job_desc,
        salary,
        branch_id
    ) VALUES (
        v_ename,
        v_job_desc,
        v_salary,
        v_brach_id
    );

END;

select * from employee;

--Labled block
<<blk_addnewemployee>>
DECLARE
    v_ename    VARCHAR2(10) := 'Sakthivel';
    v_job_desc VARCHAR2(10) := 'Developer';
    v_salary   NUMBER(10) := 1258423;
    V_BRACH_ID NUMBER(10) := 3 ; 
BEGIN
    INSERT INTO employee (
        ename,
        job_desc,
        salary,
        branch_id
    ) VALUES (
        v_ename,
        v_job_desc,
        v_salary,
        v_brach_id
    );

END blk_addnewemployee;

/*write a PL/SQL code to update the salary of an employee number 3 to 2500001,if it is not null.otherwise raise his commision by 10%*/

DECLARE
    v_empno  NUMBER(10) := 3;
    v_salary NUMBER(12,2);
BEGIN
SELECT
    salary
INTO v_salary
FROM
    employee
WHERE
    emp_id = v_empno;

if v_salary is NULL THEN
UPDATE employee
SET
    salary = 2500001
WHERE
    emp_id = v_empno;
    
ELSE 
v_salary := v_salary *.1; 
UPDATE employee
SET
    salary = v_salary
WHERE
    emp_id = v_empno;

END IF;
end;

--PL/SQL control structures and types

--Conditional constructs
--CASE expression
--Iterative constructs
    --Loop
    --While loop
    --For loop
--Sequential Constructs
    --GOTO
    --NULL
    
--Conditional constructs
--it's check the valiidty of a condition and accordingly execute the set of statements.

select * from employee ;

alter table employee add class varchar2(10) null;

DECLARE
    v_empsal NUMBER(10);
    v_class  VARCHAR2(10);
BEGIN
    SELECT
        salary
    INTO v_empsal
    FROM
        employee
    WHERE
        emp_id = 21;

    IF ( v_empsal < 250000 ) THEN
        v_class := 'LOW';
    ELSIF (
        v_empsal >= 250000
        AND v_empsal < 1300000
    ) THEN
        v_class := 'MEDIUM';
    ELSE
        v_class := 'HIGH';
    END IF;

    UPDATE employee
    SET
        class = v_class
    WHERE
        emp_id = 21;

END;

--Iterative constructs
--Used to execute set of statements repititively
--To find natural numbers 1...10
--Simple loop
DECLARE
    v_sum     NUMBER(2) := 0;
    v_counter NUMBER(2) := 1;
BEGIN
    LOOP
    v_sum := v_sum + v_counter;
    v_counter := v_counter + 1;
    EXIT WHEN v_counter >= 10;
    end loop;
DBMS_OUTPUT.PUT_LINE(V_SUM); 
END ;

--While loop
DECLARE
    v_sum     NUMBER(2) := 0;
    v_counter NUMBER(2) := 1;
BEGIN
    while v_counter < 10 LOOP
    v_sum := v_sum + v_counter;
    v_counter := v_counter + 1;
    end loop;
DBMS_OUTPUT.PUT_LINE(V_SUM); 
END ;

--For loop syntax-1
DECLARE
    v_sum NUMBER(2) := 0;
BEGIN
for v_counter IN 1..10
LOOP
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    v_sum := v_sum + v_counter;
END LOOP;
DBMS_OUTPUT.PUT_LINE(V_SUM);
end;

--For loop syntax-2
DECLARE
    v_sum NUMBER(2) := 0;
BEGIN
for v_counter IN REVERSE 1..10
LOOP
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    v_sum := v_sum + v_counter;
END LOOP;
DBMS_OUTPUT.PUT_LINE(V_SUM);
end;


--Exception Handling
--it's a errors or warnings ina PL/SQL pgm.
--By using this we can handle errors durin execution.
--PL/SQL implements error handling using exception and exception handlers

--Types
--Predefined exception -> usually default exceptions provided by oracle like ORA--00001
--User defined exceptions -> defined by developer in declaration part
select * from employee;

DECLARE
    v_maxno CONSTANT NUMBER(2) := 18;
    v_curno NUMBER(2) := 54;
    e_too_many_emp exception;
BEGIN
        SELECT
          COUNT(emp_id)
          INTO v_curno
          FROM
          employee;
IF v_curno > v_maxno THEN
raise e_too_many_emp;
    else 
        dbms_output.put_line('No.of records in employee table within a limit');
    end if;
exception
    WHEN e_too_many_emp THEN
        raise_application_error(-20001,'No.of records in employee table exceeds a limit');
END;

select * from employee;

--PL/SQL Subpgm
--STORED PROCEDURES
--ADVANTAGES
--Reduce n/w traffic
--Centralized business logic
--Secure

--DISADVANTAGES
--High Resource usage 
--Hard to maintain
--Difficult to troubleshoot

CREATE or replace PROCEDURE getemployeetotalsal
    (empid IN NUMBER) 
    IS
          total_salary number(12,2);
      BEGIN
          select salary into total_salary from employee where emp_id = empid;
          dbms_output.put_line( 'Total salary ' || total_salary);
    end getemployeetotalsal;
    /

--To call created stored procedure    
set SERVEROUTPUT ON;
execute getemployeetotalsal(21); --1256423

--Proocedure -2
create or replace PROCEDURE day_task (day VARCHAR2) AS 
BEGIN 
    IF day = 'MONDAY' THEN
    dbms_output.put_line('Checking log files');
    ELSIF DAY = 'TUESDAY' THEN
    dbms_output.put_line('no files');
    else 
    dbms_output.put_line('No TASK');
    end if;
END day_task ;
/

set serveroutput on;
execute day_task('TUESDAY');

--Functions
CREATE FUNCTION getTotalSal
           (empno IN number) 
          RETURN number
          IS
             total_salary number(12,2);
          BEGIN
               select salary into total_salary from employee where emp_id = empno;
               return total_salary;
          END getTotalSal;
          /
--To call function
select getTotalSal(21) "Total salary" from dual;

--Function - 2
CREATE FUNCTION square
           (number1 number) 
          RETURN number
          IS
          BEGIN
             return number1*number1;
          END square;

select square(3) from dual;

--Procedures and Functions IN/OUT parameters modes - 1
create or replace PROCEDURE prc_in_and_out
       (name in varchar2,welcome_msg out varchar2)
      IS
          
      BEGIN
          welcome_msg := 'Welcome_Msg: ' || name ;
          dbms_output.put_line(welcome_msg);
      END prc_in_and_out;c
      /
--To view procedure prc_in_and_out with IN and OUT parameter            
DECLARE
welcome_msg varchar2(100);
BEGIN
prc_in_and_out('VEERA',:welcome_msg)
END;

--Procedures and Functions IN/OUT parameters modes - 2
CREATE OR REPLACE PROCEDURE swap_number
       (X IN OUT NUMBER,
       Y IN OUT NUMBER) 
      IS
          t number;
      BEGIN
          t := x;
          x := y;
          y := t;
      END swap_number;
      /
--To view procedure swap_number with IN and OUT parameter       
DECLARE
a number := 3;
b number := 5;
BEGIN
swap_number(a,b);
dbms_output.put_line('a : ' || to_char(a));
dbms_output.put_line('b : ' || to_char(b));
END;

--CURSORS
--Insensitive cursors uses a temporary copy of data.
--Asenstive cursors points the actual data

      
--To view 'show error'
--dba_errors,user_errors,all_errors
SELECT
    *
FROM
    dba_errors
WHERE
    owner = 'TEST_USER_AVS'
    AND name = 'ADD_DEPT'
ORDER BY
    2 DESC;
    
        

      