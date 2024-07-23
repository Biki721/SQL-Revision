SHOW DATABASES;
USE techforallwithpriya;

SHOW TABLES;

SELECT * FROM Learners;

-- Count of the number of students who joined the course via LinkedIn, Youtube, Community

SELECT SourceOfJoining, COUNT(*) AS CountJoinedPlatform 
FROM Learners
GROUP BY SourceOfJoining;

SELECT Location, SourceOfJoining, COUNT(*) AS CountJoinedPlatform 
FROM Learners
GROUP BY Location, SourceOfJoining;

-- Corresponding to each course, how mqny students have enrolled

SELECT SelectedCourses, COUNT(*) AS Students
FROM Learners
GROUP BY SelectedCourses;


-- Corrresponding to individual source of joining, give the maximum years of experience any person holds
SELECT * FROM Learners;


SELECT  SourceOfJoining, MAX(YearsOfExperience) AS MaxExperience
FROM Learners
group by SourceOfJoining 
ORDER BY MaxExperience DESC;

# For minimum years of Experience
SELECT  SourceOfJoining, MIN(YearsOfExperience) AS MinExperience
FROM Learners
group by SourceOfJoining 
ORDER BY MinExperience DESC;

-- Corrresponding to individual source of joining, give the average years of experience any person holds
-- It makes sense as per the industry purpose

SELECT  SourceOfJoining, AVG(YearsOfExperience) AS AvgExperience
FROM Learners
group by SourceOfJoining 
ORDER BY AvgExperience DESC;

-- Insert two more enrrolments in the learner table
INSERT INTO Learners (
    LearnerFirstName, LearnerLastName, LearnerPhoneNo, LearnerEmailID, LearnerEnrollmentDate, SelectedCourses, YearsOfExperience, LearnerCompany, SourceOfJoining, Batch_Start_Date, Location
) VALUES
    ('Sidhish', 'Kumar', '1232567810', 'sidhish@gmail.com', '2024-02-15', 1, 3, 'TechCorp', 'LinkedIn', '2024-02-29', 'Gurugram'),
    ('Kaneesha', 'Mishra', '9826343210', 'kaneesha@gmail.com', '2024-01-02', 2, 5, 'Innovate LLC', 'LinkedIn', '2024-01-16', 'Bengaluru');

-- Display the records of those learners who have joined the course via more than 1 source of joining

SELECT SourceOfJoining, COUNT(*) AS LearnersJoined
FROM Learners
GROUP BY SourceOfJoining
HAVING LearnersJoined > 1;




-- Display the count of those students who joined via LinkedIn

SELECT * FROM Learners;

SELECT SourceOfJoining, COUNT(*) AS StudentsJoined
FROM Learners
WHERE SourceOfJoining='LinkedIn'
GROUP BY SourceOfJoining;

-- Notes:- Never use WHERE after Group By, we can use WHERE before GROUP BY, AND HAVING after GROUP BY
  

SELECT SourceOfJoining, COUNT(*) AS StudentsJoined
FROM Learners
GROUP BY SourceOfJoining
HAVING SourceOfJoining='LinkedIn';

-- Display the course which does not include 'Excel'


SELECT * FROM Course;

SELECT * FROM Course
WHERE NOT CourseName LIKE '%Excel%';

SELECT * FROM Course
WHERE CourseName NOT LIKE '%Excel%';

-- Display the records of those students who have less than 4 years of experience and Source of joining is youtube

SELECT * 
FROM Learners
WHERE YearsOfExperience < 4
AND SourceOfJoining = 'LinkedIn';


-- Display the records of those students who have years of experience between 1 to 3 years

SELECT *
FROM Learners
WHERE YearsOfExperience >= 1 AND YearsOfExperience <=3;

#Alternate

SELECT * 
FROM Learners
WHERE YearsOfExperience BETWEEN 1 AND 3;
 

-- Display the records of those students who have less than 4 years of experience OR Source of joining is youtube
SELECT * 
FROM Learners
WHERE YearsOfExperience < 4
OR SourceOfJoining = 'LinkedIn';

-- ALTER Command in SQL
DESC employee;
ALTER TABLE employee 
ADD COLUMN jobPosition VARCHAR(50);

ALTER TABLE employee 
MODIFY COLUMN FirstName VARCHAR(40);

ALTER TABLE employee
DROP COLUMN jobPosition;

-- TRUNCATE Commands in SQL
-- DELETE vs TRUNCATE Command in SQL --> Research





