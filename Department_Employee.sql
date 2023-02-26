USE cafy21573;

DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;

CREATE TABLE DEPARTMENT(DEPTNO INT PRIMARY KEY, DNAME VARCHAR(30), LOC VARCHAR(30));
CREATE TABLE EMPLOYEE(EMPNO INT PRIMARY KEY, ENAME VARCHAR(30), SALARY INT, DESIGNATION VARCHAR(30), COMM INT, DEPTNO INT, FOREIGN KEY(DEPTNO) REFERENCES DEPARTMENT(DEPTNO), DOJ DATE);

DESC DEPARTMENT;
DESC EMPLOYEE;

INSERT INTO DEPARTMENT(DEPTNO,DNAME,LOC) VALUES(12943,'IT','PUNE');
INSERT INTO DEPARTMENT(DEPTNO,DNAME,LOC) VALUES(12567,'ACCOUNTS','NASHIK');
INSERT INTO DEPARTMENT(DEPTNO,DNAME,LOC) VALUES(13245,'SUPPORT','BANGLORE');
INSERT INTO DEPARTMENT(DEPTNO,DNAME,LOC) VALUES(18790,'TESTING','HYDERABAD');
INSERT INTO DEPARTMENT(DEPTNO,DNAME,LOC) VALUES(12314,'SECURITY','PUNE');

INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(7369,'ADTIYA',20000,'DEVELOPER',1000,12943,'2018-12-12');
INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(1232,'AJAY',15000,'ACCOUNTANT',750,12567,'2020-3-30');
INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(6543,'PIYUSH',20000,'DEVELOPER',1000,12943,'2019-2-21');
INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(6524,'SOMNATH',17000,'ASSOCIATE',800,13245,'2018-4-23');
INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(1500,'ATHARAV',25000,'SENIOR ASSOCIATE',2000,18790,'2020-5-15');
INSERT INTO EMPLOYEE(EMPNO,ENAME,SALARY,DESIGNATION,COMM,DEPTNO,DOJ) VALUES(5467,'ABHINAV',10000,'SECURITY GUARD',500,12314,'2021-6-24');

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

SELECT MAX(SALARY), MIN(SALARY), AVG(SALARY) FROM EMPLOYEE GROUP BY DESIGNATION;

SELECT ENAME FROM EMPLOYEE 
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPARTMENT 
WHERE LOC = "PUNE");

SELECT * FROM EMPLOYEE 
WHERE DESIGNATION = "ACCOUNTANT" AND DEPTNO IN (SELECT DEPTNO FROM DEPARTMENT 
WHERE LOC = "NASHIK"); 

SELECT E.ENAME FROM EMPLOYEE E, DEPARTMENT D 
WHERE D.DEPTNO = E.DEPTNO GROUP BY D.DEPTNO;

SELECT ENAME FROM EMPLOYEE WHERE DOJ<="2018-12-12";

SELECT ENAME FROM EMPLOYEE WHERE DESIGNATION IN (SELECT DESIGNATION FROM EMPLOYEE WHERE EMPNO = 7369);