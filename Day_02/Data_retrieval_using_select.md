# Day 2

```sql
-- Show all databases
SHOW DATABASES;

-- Use the specific database
USE techforallwithpriya;

-- Show all tables in the current database
SHOW TABLES;

-- Select all records from the employee table
SELECT * FROM employee; 

/*
Create a table by the name of courses having fields named:
"CourseID", "CourseName", "Course_duration_months", "CourseFee"
*/

CREATE TABLE Course(
    CourseID              INT AUTO_INCREMENT,
    CourseName            VARCHAR(50) NOT NULL,
    CourseDuration_Months INT NOT NULL,    
    CourseFee             INT NOT NULL,
    PRIMARY KEY (CourseID)
);

-- Show all tables to verify the creation of the Course table
SHOW TABLES;

-- Describe the structure of the Course table
DESC Course;

-- Insert course details into the Course table
INSERT INTO Course(CourseName, CourseDuration_Months, CourseFee) VALUES 
    ("The Complete Excel Mastery Course", 3, 1499),
    ("DSA for Interview Prep", 2, 4999),
    ("SQL Bootcamp", 1, 2999);

-- Select all records from the Course table
SELECT * FROM Course;

-- Create the Learners table
CREATE TABLE Learners(
    LearnerId              INT AUTO_INCREMENT,
    LearnerFirstName       VARCHAR(50) NOT NULL,
    LearnerLastName        VARCHAR(50) NOT NULL,
    LearnerPhoneNo         VARCHAR(50) NOT NULL,
    LearnerEmailID         VARCHAR(50),
    LearnerEnrollmentDate  TIMESTAMP NOT NULL,
    SelectedCourses        INT NOT NULL,
    YearsOfExperience      INT NOT NULL,
    LearnerCompany         VARCHAR(50),
    SourceOfJoining        VARCHAR(50),
    Batch_Start_Date       TIMESTAMP NOT NULL,
    Location               VARCHAR(50) NOT NULL,
    PRIMARY KEY(LearnerId),
    UNIQUE KEY(LearnerEmailID),
    FOREIGN KEY (SelectedCourses) REFERENCES Course(CourseID)
);

-- Describe the structure of the Learners table
DESC Learners;

-- Insert learner details into the Learners table
INSERT INTO Learners (
    LearnerFirstName, LearnerLastName, LearnerPhoneNo, LearnerEmailID, LearnerEnrollmentDate, SelectedCourses, YearsOfExperience, LearnerCompany, SourceOfJoining, Batch_Start_Date, Location
) VALUES
    ('Akhil', 'George', '123-456-7890', 'akhil.george.8743@gmail.comk.com', '2024-02-15', 1, 3, 'TechCorp', 'Referral', '2024-02-29', 'New York'),
    ('Rishikesh', 'Joshi', '987-654-3210', 'carjkop@gmail.com', '2024-01-02', 2, 5, 'Innovate LLC', 'Online Ad', '2024-01-16', 'San Francisco'),
    ('Madhuram', 'Ravichandran', '555-555-5555', 'ravichandran.madhuram@gmail.com', '2024-02-22', 3, 2, 'Creative Inc', 'Social Media', '2024-03-25', 'Chicago'),
    ('Jeevan', 'Hegde', '666-666-6666', 'jeevan.hegdek@yahoo.co.in', '2024-02-14', 1, 4, 'Techie Solutions', 'Word of Mouth', '2024-02-29', 'Los Angeles'),
    ('Sidish', 'Kumar', '777-777-7777', 'sidhishkumar@gmail.com', '2024-01-05', 2, 6, 'FutureTech', 'Event', '2024-01-16', 'Boston'),
    ('Naga', 'Sai Sreedhar', '888-888-8888', 'saisreedhar2001@gmail.com', '2024-02-28', 3, 1, 'NextGen Enterprises', 'Email Campaign', '2024-03-25', 'Seattle');

-- Select all records from the Learners table
SELECT * FROM Learners;

-- Data Analysis [Employee, Course, Learners]

-- 1. Give me the record of the employee getting the highest salary
# Using ORDER BY and LIMIT:
SELECT * FROM employee
ORDER BY Salary DESC
LIMIT 1;

# Using a Subquery 
SELECT * FROM employee 
WHERE Salary = (SELECT MAX(Salary) FROM employee);

-- 2. Give me the record of the employee getting the highest salary and age is bigger than 30
SELECT * FROM employee
WHERE Age > 30 
ORDER BY Salary DESC
LIMIT 1;

# 2nd Approach
SELECT * FROM employee
WHERE Age > 30
AND Salary = (SELECT MAX(Salary) FROM employee WHERE Age > 30);

-- 3. Display the number of enrollments on the website of techforallwithpriya
SELECT COUNT(*) FROM Learners;

-- 4. Display the number of enrollments for the course id = 3 [SQL Bootcamp]
SELECT COUNT(*) FROM Learners
WHERE SelectedCourses = 3;

-- 5. Count the number of learners enrolled in the month of January
SELECT COUNT(*) AS NumberOfEnrollments
FROM Learners
WHERE MONTH(LearnerEnrollmentDate) = 1
AND YEAR(LearnerEnrollmentDate) = 2024;

# Alternate
SELECT COUNT(*) AS NumberOfLearnersInJan
FROM Learners
WHERE LearnerEnrollmentDate LIKE '%-01-%';

-- 6. Update Jeevan's data with years of experience as 5 and learner company as "Amazon"
UPDATE Learners
SET YearsOfExperience = 5, LearnerCompany = 'Amazon'
WHERE LearnerId = 4;

-- 7. Count the number of distinct companies where learners are currently employed
SELECT COUNT(DISTINCT LearnerCompany) AS NumberOfCompanies
FROM Learners;
```