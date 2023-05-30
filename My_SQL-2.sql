create database salman;
use salman;
create table StudentDetails(
	StudentId int,
    StudentNames varchar(20),
    Age tinyint,
    Gender varchar(20)
);
select * from StudentDetails;
alter table StudentDetails add CourseId int;
alter table StudentDetails add CouresFee int;
insert into StudentDetails values(1,'salman',23,'male',1,50000);
insert into StudentDetails values(2,'jhony',23,'male',2,55000);
insert into StudentDetails values(3,'arjun',22,'male',2,55000);
insert into StudentDetails values(4,'fayis',23,'male',3,58000);
update studentDetails set CourseId = 1 where StudentId = 4;
truncate table StudentDetails;
delete from StudentDetails where StudentId = 4;
select * from StudentDetails;
drop table StudentDetails;

set autocommit = 0;
start transaction;
select * from StudentDetails;
delete from StudentDetails where StudentId = 3;
rollback;
alter table StudentDetails drop CouresFee;
select * from StudentDetails;

create table CourseDetails(
	CourseId tinyint,
    CourseName varchar(20),
    CourseFee int
);
insert into CourseDetails values(1,'SQL',20000),(2,'PowerBI',18000);
select * from CourseDetails;
drop table CourseDetails;
create database Bank;
use Bank;
create table AccountDetails(
	AccountId int primary key,
    Name char(20) not null,
    Age tinyint check(Age>18),
    AccountType varchar(20),
    CurrentBalance int default(0)    
);
insert into AccountDetails values(1,'Hari',22,'Savings',default);
insert into AccountDetails values(2,'Adhil',23,'Savings',default);
insert into AccountDetails values(3,'Benjo',22,'Savings',default);
insert into AccountDetails values(4,'Jibin',22,'Savings',default);
select * from AccountDetails;
drop table AccountDetails;
CREATE TABLE TransactionDetails(
	TransactionId INT PRIMARY KEY auto_increment,
    AccountId INT,
    TransactionTime DATETIME DEFAULT(NOW()),
    TransactionAmount INT,
    TransactionType VARCHAR(10) CHECK(TransactionType='Credit' OR TransactionType='Debit'),
    FOREIGN KEY(AccountId) REFERENCES AccountDetails(AccountId)
);
INSERT INTO TransactionDetails(TransactionId, AccountId, TransactionAmount, TransactionType) VALUES(1,1,10000,'Credit'),(2,2,2000,'Debit'),(3,3,3000,'Credit');
SELECT * FROM TransactionDetails;
drop table Transactiondetails;

# inner join
select AD.AccountId, AD.Name, TD.TransactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
join TransactionDetails as TD
on AD.AccountId = TD.AccountId;

# outer join
select AD.AccountId, AD.Name, TD.TransactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
left join TransactionDetails as TD
on AD.AccountId = TD.AccountId;

select AD.AccountId, AD.Name, TD.TransactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
Right join TransactionDetails as TD
on AD.AccountId = TD.AccountId;

select AD.AccountId, AD.Name , TD.TransactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
Right join TransactionDetails as TD
on AD.AccountId = TD.AccountId
union
select AD.AccountId, AD.Name, TD.transactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
Left join TransactionDetails as TD
on AD.AccountId = TD.AccountId;

select AD.AccountId, AD.Name , TD.TransactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
Right join TransactionDetails as TD
on AD.AccountId = TD.AccountId
union all
select AD.AccountId, AD.Name, TD.transactionId, TD.TransactionAmount, TD.TransactionTime from AccountDetails as AD
Left join TransactionDetails as TD
on AD.AccountId = TD.AccountId;

# cross join
select * from AccountDetails, TransactionDetails;

# self join
create table EmployeeDetails(
	EmployeeId tinyint,
    EmployeeName char(20),
    ManagerId tinyint
);
insert into EmployeeDetails values(1,'Salman',null),(2,'Raji',1),(3,'Jhon',2),(4,'Habeebi',3);
select E1.EmployeeId, E1.EmployeeName, E2.EmployeeName as ManagerName
from EmployeeDetails as E1
join EmployeeDetails as E2
on E1.EmployeeId = E2.ManagerId;
drop table EmployeeDetails;
select * from EmployeeDetails;

select * from AccountDetails;
select AccountId, Name, Age from AccountDetails;
select count(*) as countofrecords from AccountDetails;
select sum(CurrentBalance) as sumofrecords from AccountDetails;
select * from CourseDetails;
insert into CourseDetails values(3,'SQL',25000);
insert into CourseDetails values(4,'Excel',15000);

select sum(CourseFee) as sumofrecords from CourseDetails;
select count(*) as countofrecords from TransactionDetails;
select sum(CourseFee) as sumofrecords from CourseDetails where CourseName = 'SQL';
select count(CourseName) as CountOfCourseSQL from CourseDetails where CourseName = 'SQL';

select count(TransactionType) as CountOfCredited from TransactionDetails where TransactionType = 'Credit';
select * from AccountDetails;
select count(CurrentBalance) as CountOfCurrentBalance from AccountDetails where CurrentBalance = 0;
select * from AccountDetails where Name = 'Adhil';

select AccountType, count(*) as CountOfRecords from AccountDetails group by AccountType;
select CourseName, count(*) from CourseDetails group by CourseName;
select * from CourseDetails;
select CourseName, count(CourseFee) as CountOfCourseFee from CourseDetails group by CourseName;
select CourseName, count(CourseFee) as CountOfCourseFee from CourseDetails group by CourseName order by CourseName ASC;
select CourseName, CourseFee from CourseDetails order by CourseName ASC;
select * from CourseDetails;