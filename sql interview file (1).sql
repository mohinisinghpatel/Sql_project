use project;

create table Dept (deptno int primary key,dname varchar(250),loc varchar(250));
insert into Dept values	(10,"OPERATIONS","BOSTON"),
(20,"RESEARCH","DALLAS"),
(30,"SALES","CHICAGO"),
(40,"ACCOUNTING","NEW YORK");

create Table employee ( Empno int default null ,
ename varchar(250),
job varchar(250),
mgr int default null,
hiredate date,
sal int not null,
comm int default null,
deptno int,
constraint fk_deptno foreign key(deptno) references dept(deptno)
);

insert into employee value (7369,"Smith","CLERK",7902,"1890-12-17",800,0,20);
insert into employee value (7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600,300,30);
insert into employee value(7521,"WARD","SALESMAN",7698,"1981-02-22",1250,500,30);
insert into employee value(7566,"JONES","MANAGER",7839,"1981-04-22",2975,null,20);
insert into employee value(7654,"MARTHIN","SALESMAN",7698,"1981-09-28",1250,1400,30),
(7698,"BLAKE","MANAGER",7839,"1981-05,01",2850,null,30),
(7782,"CLARK","MANAGER",7839,"1981-06-09",2450,null,10),
(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000,null,20),
(7839,"KING","PRESIDENT",null,"1981-11-17",5000,null,10),
(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500,0.00,30),
(7876,"ADAMS","CLERK",7788,"1987-05-23",1100,null,20),
(7900,"JAMES","CLERK",7698,"1981-12-03",950,null,30),
(7902,"FORD","ANALYST",7566,"1981-12-03",3000,null,20),
(7934,"MILLER","CLERK",7782,"1982-01-23",1300,null,10);


SELECT * from dept;
select ename,sal from employee where sal >=1000;
select * from employee where hiredate <"1981-10-01";
select * from employee where substring(ename,2,1)="i";
select ename, sal as "basic salary",sal * 0.4 as "Allowances",
sal * 0.1 as "P .f" , sal +(sal * 0.4) - (sal * 0.1) as "Net salary" from employee;


select Empno, ename ,sal from employee order by sal asc ;
select count(job) from employee where job = "organization";
select sum(sal) from employee where job = "SALESMAN";
select dept.deptno ,dept.dname,employee.job,avg(employee.sal) as "average monthly salary" 
from dept join employee on dept.deptno=employee.deptno 
group by dept.deptno,dept.dname,employee.job;
select employee.ename as empname,employee.sal,dept.dname as deptname
from employee join dept on employee.deptno = dept.deptno;

create table jobgrades(
grade char(1),
lowest_sal int,
highest_sal int);

insert into jobgrades value
("A",0,999),("B",1000,1999),("C",2000,2999),("D",3000,3999),("E",4000,5000);

select employee.ename as last_name,employee.sal,jobgrades.grade from employee
join jobgrades on employee.sal 
between jobgrades.lowest_sal and jobgrades.highest_sal;
select ename ,(sal+comm) as totalsalary from employee;
select ename,sal ,empno from employee where empno %2 <>0;

SELECT Ename AS Empname,RANK() OVER (ORDER BY Sal DESC) AS Salary_Rank,
RANK() OVER (PARTITION BY Deptno ORDER BY Sal DESC) AS Dept_Salary_Rank
FROM Employee;
select ename as empname ,sal from employee order by sal desc limit 3;

WITH MaxSalaryPerDept AS (
    SELECT Deptno, MAX(Sal) AS MaxSalary
    FROM Employee
    GROUP BY Deptno)
SELECT employee.Ename AS Empname, dept.dname AS Department
FROM Employee
JOIN Dept ON employee.Deptno = dept.Deptno
JOIN MaxSalaryPerDept  ON employee.Deptno =MaxSalaryPerDept.Deptno 
AND employee.Sal = MaxSalaryPerDept.MaxSalary;











