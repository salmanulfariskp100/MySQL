CREATE DATABASE excelr;

USE excelr;

CREATE TABLE StudentDetails(
		StudentId INT,
        StudentNames CHAR(20)
);

SELECT * FROM StudentDetails;



DROP TABLE StudentDetails;

CREATE TABLE StudentDetails(
	StudentId INT,
    StudentNames CHAR(20),
    Age TINYINT,
    Gender VARCHAR(10)
);
SELECT * FROM StudentDetails;
INSERT INTO StudentDetails VALUES(1,'CHITTI',20,'MALE',1);
INSERT INTO StudentDetails VALUES(2,'HARI',20,'MALE',2);
INSERT INTO StudentDetails VALUES(3,'SALMAN',20,'MALE',1);
ALTER TABLE StudentDetails ADD CourseId TINYINT;
SELECT * FROM StudentDetails;

TRUNCATE TABLE StudentDetails;
SELECT * FROM StudentDetails;

UPDATE StudentDetails SET CourseId = 1 WHERE StudentId = 1;
UPDATE StudentDetails SET CourseId = 1 WHERE StudentId = 2;
SELECT * FROM StudentDetails;
UPDATE StudentDetails SET CourseId = 3 WHERE StudentId = 3;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM StudentDetails WHERE StudentId = 1; 

INSERT INTO StudentDetails VALUES(1,'CHITTI',20,'MALE',1);
INSERT INTO StudentDetails VALUES(2,'HARI',20,'MALE',2);
INSERT INTO StudentDetails VALUES(3,'SALMAN',20,'MALE',1);
SELECT * FROM StudentDetails;

SET AutoCommit = 0;
START Transaction;
SELECT * FROM StudentDetails;
DELETE FROM StudentDetails WHERE StudentId = 3;
SELECT * FROM StudentDetails;
ROLLBACK; 

# FOR UNDO THE DELETED ROW
SET Autocommit = 0;
DELETE FROM StudentDetails WHERE StudentId = 2;
SELECT * FROM StudentDetails;
ROLLBACK;

CREATE TABLE CourseDetails(
	CourseId TINYINT,
    CourseName VARCHAR(20),
    CourseFee INT
);
DROP TABLE CourseDetails;
INSERT INTO CourseDetails VALUES(1,'SQL',12000),(2,'PowerBi',10000),(3,'Excel',5000);
SELECT * FROM CourseDetails;
SET Autocommit = 0;
DELETE FROM CourseDetails WHERE CourseId = 2;
SELECT * FROM CourseDetails;
ROLLBACK;


CREATE DATABASE BankDetails;
USE BankDetails;
CREATE TABLE AccountDetails(
	AccountId INT PRIMARY KEY,
    Name CHAR(30) NOT NULL,
    Age TINYINT CHECK(Age>18),
    AccountType VARCHAR(20),
    CurrentBalance INT DEFAULT(0)
);
SELECT * FROM AccountDetails;
DROP TABLE AccountDetails;
INSERT INTO AccountDetails VALUES(1,'Salman',23,'Savings',DEFAULT);
INSERT INTO AccountDetails(AccountId,Name,Age,AccountType) VALUES(1,'Salman',23,'Savings');
INSERT INTO AccountDetails VALUES(2,'Jhony',22,'Savings',DEFAULT);
INSERT INTO AccountDetails VALUES(3,'Arjun',23,'Current',DEFAULT);
#or
INSERT INTO AccountDetails VALUES(1,'Salman',23,'Savings',DEFAULT),(2,'Jhony',22,'Savings',DEFAULT),(3,'Arjun',23,'Current',DEFAULT);
SELECT * FROM AccountDetails;
SELECT COUNT(Name) AS CountsOfNames FROM AccountDetails;
SELECT COUNT(*) AS NumberOfRows FROM AccountDetails WHERE Age='22';
SELECT COUNT(Age) AS CountsOfAge FROM AccountDetails;

CREATE TABLE TransactionDetails(
	TransactionId INT PRIMARY KEY auto_increment,
    AccountId INT,
    TransactionTime DATETIME DEFAULT(NOW()),
    TransactionAmount INT,
    TransactionType VARCHAR(10) CHECK(TransactionType='Credit' OR TransactionType='Debit'),
    FOREIGN KEY(AccountId) REFERENCES AccountDetails(AccountId)
);
DROP TABLE TransactionDetails;
INSERT INTO TransactionDetails(TransactionId,AccountId, TransactionAmount, TransactionType) VALUES(1,1,10000,'Credit');
SELECT * FROM TransactionDetails;
DELETE FROM AccountDetails WHERE AccountId=1;
DROP TABLE TransactionDetails;
CREATE TABLE TransactionDetails(
	TransactionId INT PRIMARY KEY auto_increment,
    AccountId INT,
    TransactionTime DATETIME DEFAULT(NOW()),
    TransactionAmount INT,
    TransactionType VARCHAR(10) CHECK(TransactionType='Credit' OR TransactionType='Debit'),
    FOREIGN KEY(AccountId) REFERENCES AccountDetails(AccountId)
);
INSERT INTO TransactionDetails(AccountId, TransactionAmount, TransactionType) VALUES(1,10000,'Credit'),(2,13000,'Credit'),(2,1340,'DEBIT'),(1,500,'credit');
SELECT * FROM TransactionDetails; 

DROP TABLE CourseDetails;
CREATE TABLE CourseDetails(
	StudentId INT PRIMARY KEY,
	CourseId TINYINT,
    CourseName VARCHAR(20),
    CourseFee INT
);
INSERT INTO CourseDetails VALUES(1,10,'SQL',12000),(2,11,'PowerBi',10000);
SELECT * FROM CourseDetails;
DROP TABLE CourseDetails;

DROP TABLE StudentDetails;
CREATE TABLE StudentDetails(
	StudentId INT auto_increment,
    StudentNames CHAR(20),
    Age TINYINT,
    Gender VARCHAR(10),
    FOREIGN KEY(StudentId) REFERENCES CourseDetails(StudentId)
);
INSERT INTO StudentDetails(StudentNames, Age, Gender) VALUES('CHITTI',20,'MALE');
INSERT INTO StudentDetails(StudentNames, Age, Gender) VALUES('HARI',20,'MALE');
INSERT INTO StudentDetails(StudentNames, Age, Gender) VALUES('SALMAN',20,'MALE');
SELECT * FROM StudentDetails;
SELECT * FROM CourseDetails;

# Joints
DROP TABLE StudentDetails;

CREATE TABLE StudentDetails(
	StudentId INT,
    StudentNames CHAR(20),
    Age TINYINT,
    Gender VARCHAR(10)
);
use bank;
INSERT INTO StudentDetails VALUES(1,'CHITTI',20,'MALE',1);
INSERT INTO StudentDetails VALUES(2,'HARI',20,'MALE',2);
INSERT INTO StudentDetails VALUES(3,'SALMAN',20,'MALE',1);
INSERT INTO StudentDetails VALUES(4,'FAYIS','22','MALE',3);
INSERT INTO StudentDetails VALUES(1,'CHITTI',20,'MALE',1),(2,'HARI',20,'MALE',2),(3,'SALMAN',20,'MALE',1),(4,'FAYIS','22','MALE',3);
ALTER TABLE StudentDetails ADD CourseId TINYINT;
SELECT * FROM StudentDetails;

SELECT StudentId, StudentNames FROM StudentDetails;
SELECT Studentnames, age FROM studentdetails;


CREATE TABLE CourseDetails(
	CourseId TINYINT,
    CourseName VARCHAR(20),
    CourseFee INT
);
DROP TABLE CourseDetails;
INSERT INTO CourseDetails VALUES(1,'SQL',12000),(2,'PowerBi',10000);
SELECT * FROM CourseDetails;
SELECT * FROM StudentDetails;
SELECT * FROM AccountDetails;
SELECT * FROM TransactionDetails;

# Inner Joints
SELECT SD.StudentId, SD.StudentNames, CD.CourseId, CD.CourseName, CD.CourseFee FROM StudentDetails as SD
JOIN CourseDetails as CD
ON SD.CourseId = CD.StudentId;
SELECT AD.AccountId, AD.Name, AD.CurrentBalance, AD.AccountType, AD.Age, TD.TransactionId FROM AccountDetails as AD
JOIN TransactionDetails AS TD
ON TD.AccountId = TD.AccountId;
SELECT * FROM AccountDetails;

SELECT SD.STUDENTID, SD.STUDENTNAMES, CD.COURSEID, CD.COURSENAME, CD.COURSEFEE FROM STUDENTDETAILS AS SD
JOIN COURSEDETAILS AS CD
ON SD.STUDENTID = CD.COURSEID;
# outer Joints
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
LEFT JOIN CourseDetails as CD
ON SD.StudentId = CD.CourseId;

INSERT INTO CourseDetails VALUES(4,'Tablue',10000);
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
RIGHT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId;

SELECT SD.StudentId,SD.StudentNames,SD.CourseId,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
LEFT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId;

# UNION will not allow duplicates
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
LEFT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId
UNION
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
RIGHT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId;

# for allow duplicates also we need to put UNION ALL
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
LEFT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId
UNION ALL
SELECT SD.StudentId,SD.StudentNames,CD.CourseId,CD.courseName,CD.CourseFee FROM StudentDetails as SD
RIGHT JOIN CourseDetails as CD
ON SD.CourseId = CD.CourseId;

# Cross Joints
SELECT * FROM StudentDetails, CourseDetails; 

# Self Joints
use bank;
CREATE TABLE SelfJoint(
	EmployeeId INT,
    EmployeeName CHAR(20),
    ManagerId INT
);
DROP TABLE SelfJoint;
INSERT INTO SelfJoint VALUES(1,'Billgates',null);
INSERT INTO SelfJoint VALUES(2,'Peter',1);
INSERT INTO SelfJoint VALUES(3,'Luis',2);
INSERT INTO SelfJoint VALUES(4,'Salman',2);
SELECT * FROM SelfJoint;

CREATE TABLE Manager(
	ManagerId INT,
    ManagerName CHAR(20)
);
DROP TABLE Manager;
INSERT INTO Manager VALUES(1,'Billgates'),(2,'Peter');
SELECT * FROM Manager;
SELECT SJ.ManagerId,M.ManagerName FROM SelfJoint as SJ
JOIN Manager as M
ON SJ.ManagerId = M.ManagerId;

# OR
SELECT E1.EmployeeId,E1.EmployeeName,E2.EmployeeName as ManagerName
FROM SelfJoint as E1
Join SelfJoint as E2
ON E1.ManagerId = E2.EmployeeId;
SELECT * FROM SelfJoint;
# COUNT, SUM, FILTER, GroupBy, HAVING, ORDER
USE BankDetails;
SELECT * FROM AccountDetails;
SELECT AccountId, Name, Age FROM AccountDetails;
SELECT COUNT(*) AS CountOfRecords FROM AccountDetails;
SELECT COUNT(Name) AS CountOfRecords FROM AccountDetails;
SELECT SUM(CurrentBalance) AS Total FROM AccountDetails;
SELECT MIN(CurrentBalance) AS MinimumBalance FROM AccountDetails;
SELECT MAX(CurrentBalance) AS MaximumBalance FROM AccountDetails;
SELECT DISTINCT(AccountId) FROM AccountDetails;
SELECT * FROM AccountDetails WHERE CurrentBalance = 0;

# WHERE - Filter
SELECT * FROM AccountDetails WHERE AccountType = 'Savings';
SELECT COUNT(*) AS CountOfCurrentAccount FROM AccountDetails WHERE AccountType = 'Current';
SELECT COUNT(*) AS CountOfSavingsRecords FROM AccountDetails WHERE AccountType = 'Savings';
SELECT COUNT(Name) AS CountOfCurrentRecords FROM AccountDetails WHERE AccountType = 'Current';
SELECT SUM(CurrentBalance) AS Total FROM AccountDetails WHERE AccountType = 'Current';

# Group By
SELECT AccountType, COUNT(*) FROM AccountDetails GROUP BY AccountType;
SELECT AccountType, COUNT(*) AS CountOfRecords FROM AccountDetails GROUP BY AccountType ORDER BY AccountType; # order by defaultly Ascending order
SELECT AccountType, COUNT(*) AS CountOfRecords FROM AccountDetails GROUP BY AccountType ORDER BY AccountType DESC;
SELECT Age, COUNT(*) AS CountOfRecords FROM AccountDetails GROUP BY Age;
SELECT * FROM  AccountDetails;
SELECT Name, SUM(CurrentBalance) as TotalBalance FROM AccountDetails GROUP BY Name;

SELECT * FROM CourseDetails;
use bank;
SELECT * FROM StudentDetails;
SELECT CourseId, COUNT(*) AS CountOfStudents FROM CourseDetails GROUP BY CourseId;
SELECT CourseId, COUNT(*) AS CountOfStudents FROM StudentDetails GROUP BY CourseId;
SELECT CourseId, COUNT(*) AS CountOfStudents FROM StudentDetails GROUP BY CourseId ORDER BY CourseId ASC;
SELECT CourseId, COUNT(*) AS CountOfStudents FROM StudentDetails GROUP BY CourseId ORDER BY CourseId DESC;


# Using HAVING greater than Function
SELECT AccountType, COUNT(*) AS CountOfAccounds FROM AccountDetails GROUP BY AccountType HAVING CountOfAccounds>1;
SELECT Name, SUM(CurrentBalance) AS TotalBalance FROM AccountDetails GROUP BY Name HAVING TotalBalance < 1000;

SELECT * FROM AccountDetails;
INSERT INTO AccountDetails VALUES(4,'Raji','Current',300,22);
INSERT INTO AccountDetails VALUES(5,'Adhil',22,'Current',0);
SELECT AccountType, COUNT(*) AS CountOfAccounds FROM AccountDetails GROUP BY AccountType HAVING CountOfAccounds>1 ORDER BY AccountType DESC;
SELECT * FROM AccountDetails;
SELECT * FROM TransactionDetails;
INSERT INTO TransactionDetails(AccountId, TransactionAmount, TransactionType) VALUES(2,2000,'Credit');


# SUB QUERIES
use bankdetails;
CREATE TABLE AccountDetails(
	AccountId INT PRIMARY KEY,
    Name CHAR(30) NOT NULL,
    Age TINYINT CHECK(Age>18),
    AccountType VARCHAR(20),
    CurrentBalance INT DEFAULT(0)
);
DROP TABLE AccountDetails;
INSERT INTO AccountDetails VALUES(1,'Salman',23,'Savings',100),
								 (2,'Jhony',22,'Savings',2000),
								 (3,'Noufal',24,'Savings',8000),
								 (4,'Faisu',22,'Current',2400),
								 (5,'Apan',25,'Savings',12000),
                                 (6,'Arjun',23,'Current',500),
                                 (7,'Shaz',23,'Current',10000),
                                 (8,'Sudu',23,'Current',4000),
                                 (9,'Jhony',23,'Current',900),
                                 (10,'Fayis',23,'Current',7500);
SELECT * FROM AccountDetails;
CREATE TABLE TransactionDetails(
	TransactionId INT PRIMARY KEY auto_increment,
    AccountId INT,
    TransactionTime DATETIME DEFAULT(NOW()),
    TransactionAmount INT,
    TransactionType VARCHAR(10) CHECK(TransactionType='Credit' OR TransactionType='Debit')
);
DROP TABLE Transactiondetails;
INSERT INTO TransactionDetails(AccountId,TransactionAmount,TransactionType) VALUES(1,10000,'Credit'),(2,300,'Debit'),(3,500,'Credit'),(2,1000,'Credit'),(1,4500,'Debit');
SELECT * FROM TransactionDetails;

SELECT A.AccountId, A.Name, A.CurrentBalance, T.TransactionTime, TransactionAmount FROM AccountDetails AS A
Join TransactionDetails AS T
ON A.AccountId = T.AccountId;

SELECT DISTINCT(AccountId) FROM TransactionDetails;
SELECT * FROM AccountDetails WHERE AccountId IN (SELECT DISTINCT(AccountId) FROM TransactionDetails);
SELECT * FROM AccountDetails WHERE AccountId IN (SELECT DISTINCT(TransactionId) FROM TransactionDetails);
SELECT * FROM AccountDetails WHERE AccountId IN (SELECT DISTINCT(AccountId) FROM AccountDetails);
SELECT * FROM AccountDetails WHERE CurrentBalance HAVING Currentbalance > 1000;
SELECT * FROM TransactionDetails WHERE AccountId IN(SELECT DISTINCT(AccountId) FROM TransactionDetails);


# LIST OF TOP HIGHEST CURRENT BALANCE 5 ID'S
SELECT * FROM AccountDetails;
SELECT CurrentBalance FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 5;
# Then Finding 5th Current Balance By Using Derived Table
SELECT * FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 5;
SELECT CurrentBalance FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 5;
# SELECT MIN(CurrentBalance) FROM AccountDetails WHERE AccountId IN (SELECT CurrentBalance FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 5); -> Limit function cannot use in Subquery
SELECT MIN(CurrentBalance) FROM (SELECT CurrentBalance FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 5) AS FifthHighestBalance;

SELECT CurrentBalance FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 8;
SELECT MIN(CurrentBalance) FROM (SELECT * FROM AccountDetails ORDER BY CurrentBalance DESC LIMIT 7) AS 7thBalance;

# DATE DIFFERENCE
SELECT DATEDIFF(Now(),'1999-07-02');
SELECT TIMESTAMPDIFF(Month,'1999-07-02',Now());
SELECT TIMESTAMPDIFF(Year,'1999-07-02',Now());
SELECT TIMESTAMPDIFF(Day,'1999-07-02',Now());
SELECT TIMESTAMPDIFF(Year,'1999-07-02',Now()),TIMESTAMPDIFF(Month,'1999-07-02',Now()),TIMESTAMPDIFF(Day,'1999-07-02',Now());
SELECT TIMESTAMPDIFF(Year,'2000-03-16',Now()) AS Year,TIMESTAMPDIFF(Month,'2000-03-16',Now()) AS Month,TIMESTAMPDIFF(Day,'2000-03-16',Now()) AS Day;


# Transaction Details about last 6 months of AccountId 1
SELECT * FROM TransactionDetails WHERE AccountId = 1 AND TIMESTAMPDIFF(Month,Transactiontime,Now())<=6;
# Transaction Details of last 1 days
SELECT * FROM TransactionDetails WHERE AccountId = 1 AND TIMESTAMPDIFF(Day,Transactiontime,Now())<=1;
# Transaction Details of last 3 Hour
SELECT * FROM TransactionDetails WHERE TIMESTAMPDIFF(Hour,TransactionTime,Now())<=3;
SELECT * FROM TransactionDetails WHERE TIMESTAMPDIFF(Second,TransactionTime,Now())<=30000;


# VIEW
CREATE VIEW AccountsOfTransactions AS
SELECT * FROM AccountDetails WHERE AccountId IN (SELECT DISTINCT(AccountId) FROM TransactionDetails);
SELECT * FROM AccountsOfTransactions;
CREATE VIEW Last7DaysTransactions AS
SELECT * FROM TransactionDetails WHERE TIMESTAMPDIFF(DAY, TransactionTime, Now())<=7;
SELECT * FROM Last7DaysTransactions;

SELECT * FROM TransactionDetails;
SELECT * FROM AccountsOfTransactions;
DROP VIEW AccountsOfTransactions;
SET SQL_SAFE_UPDATES = 0;
UPDATE AccountsOfTransactions SET CurrentBalance = 1000 WHERE AccountId = 1; 
SELECT * FROM AccountsOfTransactions; # it will be updated in  VIEW

# While updating in Base Table it will also updated in VIEW
UPDATE AccountDetails SET CurrentBalance = 999 WHERE AccountId = 5; 
SELECT * FROM AccountsOfTransactions; 
SELECT * FROM AccountDetails;
DELETE FROM AccountDetails WHERE AccountId = 5;
DELETE FROM AccountsOfTransactions WHERE AccountId = 5;
INSERT INTO AccountDetails VALUES(5,'Jibin',23,'Savings',800);
SELECT * FROM AccountsOfTransactions;
SELECT * FROM AccountDetails;
INSERT INTO TransactionDetails(AccountId,TransactionAmount,TransactionType) VALUES(5,1500,'Credit');
SELECT * FROM TransactionDetails;

# Non-Updatable Views(if no.of columns of Base Table & Views Table are not equal)
SELECT SUM(CurrentBalance) as Total FROM AccountDetails;
SELECT * FROM AccountsOfTransactions;
ALTER TABLE AccountDetails DROP COLUMN Age;
SELECT * FROM AccountDetails;
SELECT * FROM AccountsOfTransactions; 
ALTER TABLE AccountDetails ADD Age INT;
INSERT INTO AccountDetails(Age) VALUES (22), (23), (22), (22), (21), (24), (23), (22);
SET SQL_SAFE_UPDATES = 0;
UPDATE AccountDetails
SET `Age` = CASE `AccountId`
                WHEN 1 THEN 22
                WHEN 2 THEN 22 
                WHEN 3 THEN 24 
                WHEN 4 THEN 22
                WHEN 5 THEN 23
                WHEN 6 THEN 20
                WHEN 7 THEN 20
                WHEN 8 THEN 21 
                WHEN 9 THEN 25
                WHEN 10 THEN 23
                WHEN 11 THEN 21
                WHEN 15 THEN 22
           END
WHERE `AccountId` IN (1,2,3,4,5,6,7,8,9,10,11,15);
SELECT * FROM AccountDetails;

use bank;
CREATE VIEW TotalBankBalance AS
SELECT SUM(CurrentBalance) AS TotalBankBalance FROM AccountDetails;
SELECT * FROM TotalBankBalance;
UPDATE TotalBankBalance SET CurrentBalance = 1000 WHERE AccountId = 1; # It showing an error
SELECT * FROM TotalBankBalance;
DROP VIEW TotalBankBalance;
SELECT * FROM AccountDetails;

# Using Variables in View it will be error
use bankdetails;
CREATE VIEW LastSixMonthTrans AS
SELECT * FROM TransactionDetails WHERE AccountId = 1 AND TIMESTAMPDIFF(Month,Transactiontime,Now())<=6;
SELECT * FROM LastSixMonthTrans x=1;
SELECT * FROM LastSixMonthTrans;
DROP VIEW LastSixMonthTrans;

# INDEX
CREATE INDEX AcIdIndex ON AccountDetails(AccountId);
SELECT * FROM AccountDetails USE INDEX(AcIdIndex);
# Clustered Index (AccountId is a Primary Key Column)
CREATE UNIQUE INDEX AccountIndex ON AccountDetails(AccountId);
SELECT * FROM AccountDetails USE INDEX(AccountIndex);
CREATE UNIQUE INDEX AccountIndex1 USING HASH ON AccountDetails(AccountId);
SELECT * FROM AccountDetails USE INDEX(AccountIndex1);
CREATE UNIQUE INDEX CurrentBalanceIndex USING BTREE ON AccountDetails(CurrentBalance);
SELECT * FROM AccountDetails USE INDEX(CurrentBalanceIndex) WHERE CurrentBalance=1000;

# Non-Clustered Index
CREATE INDEX AccountTypeIndex ON AccountDetails(AccountType);
SELECT * FROM AccountDetails USE INDEX(AccountTypeIndex);
SELECT * FROM AccountDetails;

SELECT * FROM TransactionDetails;
CREATE INDEX TtypeIndex ON TransactionDetails(TransactionType);

# Apply INDEX on VIEW
SELECT * FROM AccountsOfTransactions;
CREATE UNIQUE INDEX AOTIndex USING BTREE ON AccountsOfTransactions(AccountId); #it will not work because the view function used the DISTINCT function
SELECT * FROM AccountDetails USE INDEX(AOTIndex);

SELECT * FROM LastSixMonthTrans;
CREATE UNIQUE INDEX Last6Mtrans USING BTREE ON LastSixMonthTrans(TransactionId); #error showing it should be a base table

# Triggers
SELECT * FROM AccountDetails;
UPDATE AccountDetails SET CurrentBalance =0;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM AccountDetails;
SELECT * FROM TransactionDetails;
DELIMITER $$
CREATE TRIGGER BalanceUpdater
AFTER INSERT ON TransactionDetails FOR EACH ROW
BEGIN
	DECLARE var_LatestTransactionId INT;
    DECLARE var_AccountId INT;
    DECLARE var_TransactionType CHAR(10);
    DECLARE var_TransactionAmount INT;
    DECLARE var_CurrentBalance INT;
    SELECT Max(TransactionId) AS LatestTransactionId INTO var_LatestTransactionId FROM TransactionDetails;
    SELECT AccountId, Transactiontype, TransactionAmount INTO var_AccountId, var_TransactionType, var_TransactionAmount
           FROM TransactionDetails WHERE TransactionId = var_LatestTransactionId;
	SELECT CurrentBalance INTO var_CurrentBalance FROM AccountDetails WHERE AccountId = var_AccountId;
     
    IF var_TransactionType = 'Credit' THEN
		UPDATE AccountDetails SET CurrentBalance = CurrentBalance + var_TransactionAmount WHERE AccountId = var_AccountId;
    ELSE
		IF var_TransactionAmount < var_CurrentBalance THEN
			UPDATE AccountDetails SET CurrentBalance = CurrentBalance - var_TransactionAmount WHERE AccountId = var_AccountId;
        ELSE
			UPDATE AccountDetails SET CurrentBalance = CurrentBalance WHERE AccountId = var_AccountId;
		END IF;
	END IF;
END;
DROP TRIGGER BalanceUpdater;
DELIMITER ;
INSERT INTO TransactionDetails(AccountId, TransactionType, TransactionAmount) VALUES (1,'Credit', 1000);
INSERT INTO TransactionDetails(AccountId, TransactionType, TransactionAmount) VALUES (1,'Debit', 500);
INSERT INTO TransactionDetails(AccountId, TransactionType, TransactionAmount) VALUES (2,'Debit', 200000);
SELECT * FROM AccountDetails;
SELECT * FROM TransactionDetails;

# Update Account Status Problem
ALTER TABLE AccountDetails ADD COLUMN AccountStatus CHAR(10) DEFAULT('Active');
SELECT * FROM AccountDetails;
# Checking The TRIGGER after Adding a new column AccountStatus
INSERT INTO TransactionDetails(AccountId, TransactionType, TransactionAmount) VALUES (3,'Credit', 2000);


 