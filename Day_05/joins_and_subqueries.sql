
USE techforallwithpriya;

Select * From Learners;
SELECT * FROM Course;

-- 1. Which courses have the highest enrollment rates?

SELECT CourseName FROM Course
WHERE CourseID = 
(SELECT SelectedCourses FROM
(SELECT SelectedCourses, Count(*) AS HighestEnrolled
FROM Learners
GROUP BY SelectedCourses
ORDER BY HighestEnrolled DESC
LIMIT 1) as temp);

SELECT CourseName FROM Course
WHERE CourseID = (
	SELECT SelectedCourses FROM Learners
    GROUP BY SelectedCourses
    ORDER BY COUNT(*)  DESC
    LIMIT 1
);
 
SELECT CourseName FROM Course
JOIN(
	SELECT SelectedCourses FROM Learners
	GROUP BY SelectedCourses
    ORDER BY COUNT(*)  DESC
    LIMIT 1
) AS temp
ON Course.CourseID = temp.SelectedCourses;

-- 2. How many learners are enrolled in each course?

SELECT * FROM learners;
SELECT CourseName, temp.learnersEnrolled  FROM Course
JOIN
(SELECT SelectedCourses, COUNT(*) AS learnersEnrolled
FROM Learners
GROUP BY SelectedCourses) AS temp
ON Course.CourseID= temp.SelectedCourses;

-- alternate
 
SELECT DISTINCT 
    Course.CourseName, 
    COUNT(Learners.SelectedCourses) OVER (PARTITION BY Learners.SelectedCourses) AS learnersEnrolled
FROM Course
JOIN Learners ON Course.CourseID = Learners.SelectedCourses;

-- 3. What is the total revenue generated from the course fees?
SELECT * FROM Course;
SELECT SUM(Course.CourseFee *temp.LearnersEnrolled) AS Totalrevenue  FROM Course
JOIN
(SELECT SelectedCourses, COUNT(*) AS learnersEnrolled
FROM Learners
GROUP BY SelectedCourses) AS temp
ON Course.CourseID= temp.SelectedCourses;



UPDATE Learners
SET Location = 'Bengaluru'
WHERE LearnerId = 4 OR LearnerId = 5;

-- 4. Which locations contribute the most to course revenue?
SELECT * FROM Learners;

Select l.location, SUM(c.CourseFee) AS HighestRevenue
FROM Learners l
JOIN COURSE c 
ON l.SelectedCourses=c.CourseId
GROUP BY l.location
ORDER BY HighestRevenue DESC
LIMIT 1;


-- 5.Which course contributes the most to the learner's enrollment?

SELECT * FROM Learners;

SELECT CourseName,temp.contributes FROM Course
JOIN
(SELECT SelectedCourses, Count(*) AS contributes FROM Learners
GROUP BY SelectedCourses
ORDER BY contributes DESC
LIMIT 1) as temp
ON CourseId = temp.SelectedCourses;


SELECT c.CourseName, COUNT(l.LearnerId) AS EnrollmentCount
FROM Learners l
JOIN Course c ON l.SelectedCourses = c.CourseID
GROUP BY c.CourseName
ORDER BY EnrollmentCount DESC
LIMIT 1;

-- 6. Rank learners based on their enrollment date within each course.

SELECT l.learnerFirstName, l.learnerEnrollmentDate, c.CourseName,
ROW_NUMBER() OVER (PARTITION BY l.SelectedCourses ORDER BY l.learnerEnrollmentDate) AS 'rank'
FROM Learners l
JOIN Course c ON l.SelectedCourses = c.CourseId;


SELECT 
    l.LearnerFirstName, 
    l.learnerEnrollmentDate,
    c.CourseName,
    ROW_NUMBER() OVER (PARTITION BY l.SelectedCourses ORDER BY l.learnerEnrollmentDate) AS 'Rank'
FROM Learners l
JOIN Course c ON l.SelectedCourses = c.CourseId;


-- 7.Compare each employee’s salary with the average salary in their location.

Select * From Employee;
SELECT e.EID, e.FirstName, e.Location, temp.AvgSalary, e.Salary-temp.AvgSalary AS SalaryDifference FROM Employee e
JOIN
(SELECT location, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Location) AS temp
ON e.location = temp.location;


