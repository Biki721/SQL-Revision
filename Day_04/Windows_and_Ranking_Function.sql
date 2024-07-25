USE techforallwithpriya;

SELECT * FROM Employee;
-- For each location, what is the count of each employee and avg salary of the employee in those location
SELECT FirstName, LastName, Employee.Location, TotalEmployee, Avg_Salary
FROM Employee
JOIN
(SELECT Location, COUNT(*) AS TotalEmployee, AVG(Salary) AS Avg_Salary
FROM Employee
GROUP BY Location) AS Temp
ON Employee.Location = temp.Location;


-- optimize the above queries via window function   
-- { Whenever we need both aggregated and non-aggregated columns in our operations, 
-- using the PARTITION BY clause with window functions is often a more optimized approach 
-- than using the GROUP BY command with JOINs.} 
SELECT FirstName, LastName, Location,
COUNT(Location) OVER (PARTITION BY Location) AS Total,
AVG(Salary) OVER (PARTITION BY Location) AS Avg_Salary
FROM Employee;


INSERT INTO Employee(FirstName, LastName, Age, Salary, Location) VALUES 
('Jeevan', 'Hedge', 27, 200000, "NOIDA"),
('Sidhish', 'Kumar', 25, 200000, "Bengaluru");

-- Difference between ROW_NUMBER(), RANK(), DENSE_RANK()  

SELECT FirstName, LastName, Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Priority_Emp
FROM Employee;

SELECT FirstName, LastName, Salary,
RANK() OVER (ORDER BY Salary DESC) AS Priority_Emp
FROM Employee;

SELECT FirstName, LastName, Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS Priority_Emp
FROM Employee;

-- GIVE THE RECORD OF THE EMPLOYEE HAVIND SECOND HIGHEST SALARY
SELECT * FROM (SELECT FirstName, LastName, Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS Priority_Emp
FROM Employee) as Temp
WHERE Priority_Emp = 2;

-- GIVE THE RECORD OF THE 1st EMPLOYEE HAVIND SECOND HIGHEST SALARY

SELECT * FROM (SELECT FirstName, LastName, Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Priority_Emp
FROM Employee) AS Temp
WHERE Priority_Emp = 2;

-- Specify the details of highest salary in each location

SELECT * FROM 
(SELECT FirstName, LastName, Salary, Location,
ROW_NUMBER() OVER (PARTITION BY Location ORDER BY Salary DESC) AS Priority_Emp
FROM Employee) as temp
WHERE Priority_Emp = 1;


CREATE TABLE ScoreTable(
	Id INT AUTO_INCREMENT,
    Score DECIMAL(10,2),
    PRIMARY KEY (Id)
    );

DESC ScoreTable;

INSERT INTO ScoreTable(Score) VALUES 
			(3.50),
            (3.65),
            (4.00),
            (3.85),
            (4.00),
            (3.65);

SELECT * FROM ScoreTable;

SELECT Score, ROW_NUMBER() OVER (ORDER BY Score DESC) AS RankNo 
FROM ScoreTable;

SELECT Score, RANK() OVER (ORDER BY Score) AS "rank"
FROM ScoreTable;

SELECT Score, DENSE_RANK() OVER (ORDER BY Score) AS RankNo
FROM ScoreTable;

