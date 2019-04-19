

SELECT ROUND(45.923,2), ROUND(45.923,0), 	ROUND(45.923,-1);
SELECT TRUNCATE(45.999,2), TRUNCATE(45.923, 0), TRUNCATE(49.923,-1);

SELECT 45.923/2 as num,ceil(45.923/2),floor(45.923/2) ;

select employee_id ,first_name,salary,
FlOOR(salary/500) AS Rs500_reqd,
MOD(salary,500) As remaining_amt
FROM employees WHERE employee_id='124';

select employee_id,first_name,phone_number,
replace(phone_number,'124','xxx') AS masked_phone_num
from Employees LIMIT 10,5; # 10 =start after 10th position ,5=no of records

select employee_id,first_name,phone_number,
CONCAT(SUBSTR(phone_number,1,4), 'XXX.'),    #Extracts a string of determined length
SUBSTR(phone_number,-4) AS masked_phno
from employees LIMIT 10,10;

  select first_name,substr(first_name,-1 ) as fist from employees;
  
select employee_id,first_name,last_name,LENGTH(last_name)from employees
where SUBSTR(first_name,-1)IN('a','e','i','o','u')
And SUBSTR(last_name,-1) IN ('a','e','i','o','u');

select employee_id,UPPER(first_name),LOWER(last_name),LENGTH(last_name)from employees
where SUBSTR(first_name,-1)IN('a','e','i','o','u')
And SUBSTR(last_name,-1) IN ('a','e','i','o','u');

select employee_id,UPPER(first_name),LOWER(last_name),UPPER(CONCAT(first_name,' ',last_name)) AS FULLNAME from employees
where SUBSTR(first_name,-1)IN('a','e','i','o','u')
And SUBSTR(last_name,-1) IN ('a','e','i','o','u');

select employee_id,last_name,INSTR(last_name,'in')
from employees
WHERE INSTR(last_name,'in')>0;

select SUBSTR(job_title,INSTR(job_title,' ')+1) AS FULLNAME from jobs;


select employee_id,last_name,hire_date,
ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365, 2) AS yrs_of_exp
FROM employees LIMIT 10,10 ;

select employee_id,last_name,hire_date,
FLOOR(DATEDIFF(CURRENT_DATE(),hire_date)/365) AS yrs_of_exp
from employees
WHERE hire_date > '2000-01-01';
# string to date
SELECT STR_TO_DATE('15/11/2018', '%d/%m/%Y');

select employee_id,last_name,hire_date,
FLOOR(DATEDIFF(CURRENT_DATE(),hire_date)/365) AS yrs_of_exp
from employees
WHERE hire_date > STR_TO_DATE('31-jan-1999','%d-%b-%Y');

select employee_id,last_name,DATE_FORMAT(hire_date, '%a %d-%M-%Y') As hire_date,
FLOOR(DATEDIFF(CURRENT_DATE(),hire_date)/365) AS yrs_of_exp
from employees
WHERE hire_date > STR_TO_DATE('02-jan-2000','%d-%b-%Y');

# period_diff(,),last_day(),current_timestamp()

select employee_id,last_name,hire_date,
MOD(DATEDIFF(CURRENT_DATE(),hire_date),365)/30 AS months
FROM employees LIMIT 10,10;

select employee_id,last_name,hire_date,
YEAR(hire_date) AS year_joined,
MONTH(hire_date) AS month_joined,
DAY (hire_date),
YEAR(CURDATE())-YEAR(hire_date) AS yrs_of_exp,
LAST_DAY(hire_date)
from employees
Where hire_date > '2000-01-01';

# cast,convert
SELECT CAST('2018-10-31' AS DATE);
SELECT CONVERT('2018-10-31', DATE);
SELECT CAST(150 AS CHAR);
SELECT CONVERT(150, CHAR);


SELECT CONVERT('10', UNSIGNED)+22;

select CONCAT('year',CAST('abc'as UNSIGNED)); # unsigned is unknow integer it cannot have - values

Select CONCAT('year',2019);

select CONCAT('year',CAST(2019 as CHAR));

# case when then else ,nullif(),if,ifnull
SELECT IF(1=2, 'Y', 'N');	#-- Returns 'N'
SELECT salary, IF(salary > 10000, 'High', 'Low') AS sal_grade 
FROM Employees WHERE employee_id = 123;

SELECT IFNULL(NULL, 100);	-- Returns 100
SELECT employee_id, first_name, department_id, salary, IFNULL(commission_pct, 0)
FROM Employees WHERE department_id IN (80, 90) AND salary > 10000;

SELECT NULLIF(10, 20);	#-- Returns 10
SELECT first_name, last_name FROM Employees WHERE NULLIF(LEFT(first_name, 1), LEFT(last_name, 1)) IS NULL;

SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                   WHEN 'ST_CLERK' THEN  1.15*salary
                   WHEN 'SA_REP'   THEN  1.20*salary
       ELSE      salary END AS REVISED_SALARY
	FROM   Employees;

select city,
case country_id
     when 'IT' THEN 'Italy'
     when 'JP' THEN 'JAPAN'
     when 'CA' THEN 'CANDA'
     when 'IN' THEN 'INDIA'
     ELSE  country_id  end as country_name from locations;
     
select  employee_id,last_name,salary,department_id,commission_pct,
case 
   WHEN salary > 10000 THEN Salary *1.05
   WHEN salary >5000  THEN salary * 1.10
   WHEN commission_pct IS NULL THEN salary *1.12
   WHEN  department_id IN (10,20) THEN salary*1.15
   ELSE salary END AS salary_inc
FROM employees order by department_id;
         
 SElECT  DISTINCT department_id,job_id FROM employees
 ORDER BY department_id,job_id;
 
 SElECT  department_id,job_id FROM employees
 ORDER BY department_id,job_id;
 # avg,max,min,sum,count,stddev,variance,median
select count(salary),MIN(salary),MAX(salary),AVG(salary),SUM(salary)
FROM employees 
WHERE department_id =30;

select MIN(first_name),MAX(first_name) from employees;
select MIN(hire_date),MAX(hire_date) from employees
where department_id=30;

select Count(*),count(employee_id),count(department_id),count(commission_pct)
from employees;

select Count(*),count(employee_id),count(department_id),count(DISTINCT department_id),COUNT(commission_pct)
from employees;

select department_id, (employee_id)
from employees
order by department_id;

#groupby

select department_id, count(employee_id)
from employees
group by department_id;
#order by department_id;

select department_id, count(employee_id),SUM(salary),AVG(Salary)
from employees
WHERE department_id IS NOT NULL
group by department_id;

#HAVING clause is used to restrict groups  and it is used for agrregate values
select department_id,job_id,COUNT(employee_id) AS emp_count ,SUM(salary) AS total_sal,
ROUND(AVG(Salary))AS avg_sal,ROUND(STDDEV(salary),4) AS std_devn
from employees
WHERE department_id IS NOT NULL
group by department_id,job_id
HAVING COUNT (employee_id) >1 
AND AVG(salary) > 5000
order by department_id ;

select department_id,job_id, COUNT(employee_id) AS emp_count ,SUM(salary) AS total_sal,
 ROUND(AVG(Salary))AS avg_sal,ROUND(STDDEV(salary),4) AS std_devn
 from employees
 WHERE department_id IS NOT NULL
 group by department_id,job_id
 HAVING COUNT(employee_id) >1 
 AND AVG(salary) > 5000
 order by department_id;
 
SELECT department_id,job_id, COUNT(employee_id) AS emp_count ,
SUM(salary) AS total_sal,
ROUND(AVG(Salary),2) AS avg_sal,ROUND(STDDEV(salary),4) AS std_devn
FROM employees
WHERE department_id IS NOT NULL
AND (job_id LIKE '%CLERK' OR job_id LIKE '%MAN')
GROUP BY department_id,job_id
HAVING COUNT(employee_id) > 1 
ORDER BY department_id ;

select * FROM employees;
select  department_id, job_id FROM employees  # without distinct it has duplicates
order by department_id,job_id;

select DISTINCT department_id, job_id FROM employees  # it has no duplicates
order by department_id,job_id;

select COUNT(*),COUNT(DISTINCT employee_id),COUNT(department_id),
COUNT(DISTINCT department_id) FROM employees;

DESC employees; # it  describes the table and says which is null (yes) and not to be null (No)

# show location-id-wise count of department names;
select location_id,COUNT(department_name) FROM departments
GROUP BY location_id;
select * from locations where location_id=1700;

select department_id, count(*),
sum(salary+salary*IFNULL(commission_pct,0)) AS tot_gross_sal FROM  employees
GROUP BY department_id
HAVING SUM(salary+salary * IFNULL(commission_pct,0)) > 100000 
ORDER BY department_id;

select department_id,
SUM(salary+salary*IFNULL(commission_pct,0)) AS tot_gross_sal FROM  employees # never allow nested functions in group by in mysql
GROUP BY department_id
ORDER BY tot_gross_sal DESC LIMIT 1;

#JOINS

select employee_id, d.department_id,department_name
From employees e INNER JOIN departments d
  ON e.department_id = d.department_id
 WHERE employee_id BETWEEN 175 AND 185 ;
  
select employee_id, d.department_id,department_name,l.location_id,salary,j.job_title ,city
From employees e INNER JOIN departments d
  ON e.department_id = d.department_id
INNER JOIN Locations l
    ON d.location_id=l.location_id
INNER JOIN jobs j
	ON j.job_id=e.job_id
  WHERE salary <5000 ;
  
select e.employee_id, e.department_id,d.department_name
from employees e JOIN departments d;

# 2889 row(s) returned  i.e cartesian  (107x27) rows x col

select d.department_id,d.department_name,e.first_name,e.last_name 
from departments d INNER JOIN employees e
 ON d.manager_id = e.employee_id;        # forgein key =primary key data is same
 
 select * from departments;
 # show managers names of all departments
 
 
 #A left join returns all records from table A and any matching records from table B.
 select d.department_id,d.department_name,
 IFNULL(CONCAT(e.first_name,' ',e.last_name),'No manager') AS fullname
 FROM departments d LEFT OUTER JOIN employees e
  ON  d.manager_id = e.employee_id;
  
 #A right join returns all records from table B and any matching records from table A.
   select d.department_id,d.department_name,
 IFNULL(CONCAT(e.first_name,' ',e.last_name),'No manager') AS fullname
 FROM departments d RIGHT OUTER JOIN employees e   # only matching tables will be displayed in left side 
  ON  d.manager_id = e.employee_id;
  
  # if only join is used then it will form cartesian that will not useful. 
  
  select d.department_id, d.department_name,count(e.department_id)
  FROM departments d INNER JOIN employees e
  ON d.department_id= e.department_id
  GROUP BY d.department_id,d.department_name
  ORDER BY d.department_id;
  
   #show department-wise emp count for all dept.s
  select d.department_id, d.department_name,count(e.department_id)
  FROM departments d LEFT OUTER JOIN employees e
  ON d.department_id= e.department_id
  GROUP BY d.department_id,d.department_name
  HAVING COUNT(e.department_id) =0 # NO emp.s Working
  ORDER BY d.department_id;
 