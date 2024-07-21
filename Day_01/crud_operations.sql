SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS techforallwithpriya;
USE techforallwithpriya;
SELECT DATABASE();

CREATE TABLE employee(
	EID		INT PRIMARY KEY,
    FirstName	varchar(50)	NOT NULL,
    LastName	varchar(50)	NOT NULL,
    Age		INT	NOT NULL,
    Salary		INT NOT NULL,
    location	varchar(50) NOT NULL
);

CREATE TABLE employee(
	EID		INT AUTO_INCREMENT,
    FirstName	varchar(50)	NOT NULL,
    LastName	varchar(50)	NOT NULL,
    Age		INT	NOT NULL,
    Salary		INT NOT NULL,
    Location	varchar(50) NOT NULL,
    PRIMARY KEY (EID)
);
DROP TABLE employee;
DESCRIBE employee;
DESC employee; 
SHOW TABLES;

INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Priya', 'Bhatiya', 27, 200000, 'Bengaluru');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Akhil', 'George', 26, 100000, 'Gurugram');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Kaneesha', 'Brownlee', 27, 300000, 'London');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Megha', 'Meka', 24, 50000, 'America');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Naga', 'Sai', 30, 150000, 'Bengaluru');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Prabhutva', 'Kakkar', 35, 70000, 'Noida');
INSERT INTO employee(FirstName, LastName, Age, Salary, Location) VALUES ('Yashswi', 'Gandhak', 29, 90000, 'Delhi');
SELECT * FROM employee;

-- Give me the employe details having salary more than 100000

SELECT * FROM employee
WHERE Salary > 100000;

SELECT FirstName, LastName FROM employee
WHERE Salary > 100000;


# Give me the records of the employee having age more than 25

SELECT * FROM employee
WHERE Age> 25;

/*
Update the lastname of Priya with Bhatt
*/

UPDATE employee SET LastName = "Bhatt"
WHERE EID = 1;

# Delete the employee whose EID is 4

DELETE FROM employee
WHERE EID = 4;







