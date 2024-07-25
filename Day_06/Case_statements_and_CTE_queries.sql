USE techforallwithpriya;
CREATE TABLE Course_Update(
CourseID INT AUTO_INCREMENT,
CourseName varchar(50) NOT NULL,
CourseDuration_Months DECIMAL(3,1) NOT NULL,
CourseFee INT NOT NULL,
Changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
PRIMARY KEY(CourseID));

DROP TABLE Course_Update;

INSERT INTO Course_Update(CourseName,CourseDuration_Months,CourseFee) Values
("The Complete Excel Mastery Course",2.5,1499),
("DSA For Interview Preparation",2,4999),
("SQL Bootcamp",1,2999),
("Foundations of Machine Learning",3.5,4999);

SELECT * FROM Course_Update;
INSERT INTO Course_Update(CourseName,CourseDuration_Months,CourseFee) Values("Statistics for Data Science",1.5,3999);

-- CASE statements in SQL
-- create a new column named "CourseFeeStatus"
/*
	CourseFee > 3999 > Expensive Course
    CourseFee > 1499 > Moderate Course
    Else cheap Course
*/

SELECT CourseID, CourseName, CourseFee,
CASE
	WHEN CourseFee > 3999 THEN 'Expensive Course'
    WHEN CourseFee > 1499 THEN 'Moderate Course'
    ELSE 'Cheap Course'
END AS CourseFeeStatus
FROM course_update;

-- CASE Expressions in SQL 
-- CourseType: Premium Course, Plus Course, Regular Course

SELECT CourseID, CourseName, CourseFee, 
	CASE CourseFee
		WHEN 4999 THEN 'Premium Course'
        WHEN 3999 THEN 'Plus Course'
        ELSE 'Regular Course'
	END AS CourseType
FROM course_update;

-- Create a new table "orders" in the techforallwithpriya data
-- OrderID -> PRIMARY KEY [Auto_Increment]
-- Order_Date
-- Order_Student_ID
-- ORDER_Status -> Complete, Pending, Closed 

CREATE TABLE Orders(
OrderID INT AUTO_INCREMENT,
Order_Date TIMESTAMP NOT NULL, 
Order_Learner_Id INT NOT NULL, 
OrderStatus VARCHAR(30) NOT NULL,
PRIMARY KEY(OrderID),
FOREIGN KEY(Order_Learner_Id) REFERENCES Learners(LearnerId));

SHOW TABLES;

DESC Orders;	

DROP TABLE Orders;

SELECT * FROM Learners;
-- Insertion of the records inside the orders table
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-21',1,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',6,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-02-22',3,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-15',4,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-16',7,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-13',8,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-22',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-25',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-11',7,'CLOSED');


SELECT * FROM Orders;

-- Total orders per student
-- Order_Learner_Id, Total_Orders

SELECT temp.Order_learner_Id, l.LearnerFirstName, l.LearnerLastname, temp.Total_Orders
FROM Learners l
JOIN
(SELECT Order_Learner_Id, COUNT(*) As Total_Orders
FROM ORDERS
GROUP BY Order_learner_Id) AS temp
ON l.learnerId = temp.Order_Learner_Id;

/*
Order_Learner_Id, LearnerFirstName, LearnerLastName, Total_Orders,
Avg_Orders_Entire_Student -> AVG(SUM(Total_Orders))
*/

SELECT temp.Order_learner_Id, l.LearnerFirstName, l.LearnerLastname, temp.Total_Orders, AVG(SUM(temp.Total_Orders)) OVER() AS Avg_Orders_Entire_Student
FROM Learners l
JOIN
(SELECT Order_Learner_Id, COUNT(*) As Total_Orders
FROM ORDERS
GROUP BY Order_learner_Id) AS temp
ON l.learnerId = temp.Order_Learner_Id
GROUP BY temp.Order_Learner_Id;


SELECT 
    temp.Order_learner_Id, 
    l.LearnerFirstName, 
    l.LearnerLastName, 
    temp.Total_Orders, 
    AVG(temp.Total_Orders) OVER() AS Avg_Orders_Entire_Student
FROM Learners l
JOIN (
    SELECT Order_Learner_Id, COUNT(*) AS Total_Orders
    FROM ORDERS
    GROUP BY Order_Learner_Id
) AS temp
ON l.learnerId = temp.Order_Learner_Id
GROUP BY temp.Order_learner_Id, l.LearnerFirstName, l.LearnerLastName, temp.Total_Orders;

