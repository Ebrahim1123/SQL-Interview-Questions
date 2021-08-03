Create table empl 
(  
     id int,  
     FirstName varchar(50),  
     LastName varchar(20),  
     Location varchar(20),  
     Gender varchar(50),  
     Salary int  
)

Insert into empl values (1,'Chittaranjan', 'Swain','Odisha', 'Male', 80000),
(2,'Chandin', 'Swain', 'Pune','Female', 76000),  
(3,'Mitu', 'Pradhan','Delhi', 'Male', 55000),  
 (4,'Jeni', 'Swain','Chennai', 'Female', 76000),  
 (5,'Adyashree', 'Swain','UK', 'Female', 49000),  
 (6,'Ram', 'Kumar','US', 'Male', 39000),  
 (7,'Jitendra', 'Gouad','Hydrabad', 'Male', 35000),  
 (8,'Dibas', 'Hembram','Bangalore', 'Male', 55000),
 (1,'Chittaranjan', 'Swain','Odisha', 'Male', 80000),
 (1,'Chittaranjan', 'Swain','Odisha', 'Male', 80000),
 (2,'Chandin', 'Swain', 'Pune','Female', 76000);

 --1)display the duplicates records
 select count(*) as 'Number of records',* from empl
 group by id,FirstName,LastName,Location,Gender,Salary;

--2)delete the duplicates records
with cte as (
select *,
row_number() over(partition by id,FirstName,LastName,Location,Gender,Salary order by salary) as rnk
from empl
) delete from cte where rnk > 1; 

select * from empl;

--3)Find employees who earn more than the avg salary 
select FirstName from empl where salary > (select avg(Salary) from empl)

--4)Increase the salary of employees by 5%
UPDATE empl
SET salary= salary + (salary * 5 / 100)

--5)Find emp whose first name Begins with C
select FirstName from empl where FirstName like 'c%';

--Find emp whose first name ends with e
select FirstName from empl where FirstName like '%e'

--Find emp whose first name contains ch
select FirstName from empl where FirstName like '%ch%'


--6)Print the even ids of employess
select * from empl where id%2 = 0; 


select * from empl where mod(id,2)=0; --MySQL

--7)Find the Employee who is earning the Highest salary
select max(salary) from emp1;

--This query will return only the max salary won't display the name of emp who is earning this,
--to get emp name as well as other records we will use subquery/cte


select *from empl where salary=(select Max(salary) from empl);

with cte as(
select *,
rank() over( order by salary desc) as rnk
from empl)
select * from cte where rnk =1 ;


--8)Find 2nd Highest salary

--using cte
with cte as
(select *,
dense_rank() over(order by salary desc) as rank
from empl)
select * from cte
where rank =2 ;-- change rank if you want to find 3rd,4th salary 

--using subquery
select max(salary) from empl where salary not in 
(select max(salary) from empl )

select salary from empl order by Salary desc limit 1 offset 1; 
--MySQL,Just increase the offset if you want to find 3rd,4th highest salary etc.

select salary from empl;
CREATE TABLE department(
    ID int,
    SALARY int,
    NAME Varchar(20),
    DEPT_ID Varchar(255));

INSERT INTO department VALUES (1, 34000, 'ANURAG', 'UI DEVELOPERS');
INSERT INTO department VALUES (2, 33000, 'harsh', 'BACKEND DEVELOPERS');
INSERT INTO department VALUES (3, 36000, 'SUMIT', 'BACKEND DEVELOPERS');
INSERT INTO department VALUES (4, 36000, 'RUHI', 'UI DEVELOPERS');
INSERT INTO department VALUES (5, 37000, 'KAE', 'UI DEVELOPERS');

select * from department;

--9)Emoplyee with highest salary  by dept
select DEPT_ID,max(salary) from department 
group by DEPT_ID;

--Top 2 Emoplyee with highest salaries in each dept
with cte as
(
select *,
DENSE_RANK() over(partition by DEPT_ID order by salary desc) as Highest_salary
from department)
select * from cte where Highest_salary < 3 ;

CREATE TABLE employeess(
    EMPLOYEE_ID int,
    e_NAME Varchar(20),
    Salary int,
	ManagerId int);

INSERT INTO EMPLOYEESS VALUES (1, 'ANURAG',70000,3);
INSERT INTO EMPLOYEESS VALUES (2, 'harsh',80000,4);
INSERT INTO EMPLOYEESS VALUES (3, 'SUMIT',60000,null);
INSERT INTO EMPLOYEESS VALUES (4, 'RUHI',90000,null);

select * from employeess;

--10)Find employees who are earning more than there manager
SELECT emp.*  FROM employeess AS emp
join employeess AS man on emp.ManagerId = man.EMPLOYEE_ID
WHERE emp.Salary > man.Salary;

  
       
