USE cafy21573;

DROP TABLE BILL;
DROP TABLE CUSTCALLINFO;
DROP TABLE CUSTOMER1;
DROP TABLE PLAN;

CREATE TABLE PLAN(PLANNO INT PRIMARY KEY, PNAME VARCHAR(20), NOOFFREECALLS INT, RATEPERCALLPERMIN DOUBLE, FREECALLTIME INT, FIXEDAMT DOUBLE);
CREATE TABLE CUSTOMER1(CUSTNO INT PRIMARY KEY, NAME VARCHAR(20), MOBILENO VARCHAR(10), PLANNO INT, FOREIGN KEY(PLANNO) REFERENCES PLAN(PLANNO));
CREATE TABLE CUSTCALLINFO(RECNO INT PRIMARY KEY, CUSTNO INT, FOREIGN KEY(CUSTNO) REFERENCES CUSTOMER1(CUSTNO), NOOFCALLS INT, TOTALTALKTIME INT, CYCLEPERIOD VARCHAR(20)); 
CREATE TABLE BILL(RECNO INT, FOREIGN KEY(RECNO) REFERENCES CUSTCALLINFO(RECNO), BILLNO INT PRIMARY KEY, FINALBILLAMT DOUBLE, CYCLEDATE DATE, BILLDUEDATE DATE, STATUS VARCHAR(10), BILLPAYDATE DATE, CUSTNO INT, FOREIGN KEY(CUSTNO) REFERENCES CUSTOMER1(CUSTNO));

DESC PLAN;
DESC CUSTOMER1;
DESC CUSTCALLINFO;
DESC BILL;

INSERT INTO PLAN(PLANNO, PNAME, NOOFFREECALLS, RATEPERCALLPERMIN, FREECALLTIME, FIXEDAMT) VALUES(101, 'PREPAID 399 PLAN', 100, 0.5, 300, 100);
INSERT INTO PLAN(PLANNO, PNAME, NOOFFREECALLS, RATEPERCALLPERMIN, FREECALLTIME, FIXEDAMT) VALUES(102, 'POSTPAID 499 PLAN', 200, 0.65, 400, 200);
INSERT INTO PLAN(PLANNO, PNAME, NOOFFREECALLS, RATEPERCALLPERMIN, FREECALLTIME, FIXEDAMT) VALUES(103, 'PREPAID 699 PLAN', 300, 0.76, 500, 300);
INSERT INTO PLAN(PLANNO, PNAME, NOOFFREECALLS, RATEPERCALLPERMIN, FREECALLTIME, FIXEDAMT) VALUES(104, 'PREPAID 799 PLAN', 400, 0.55, 600, 400);
INSERT INTO PLAN(PLANNO, PNAME, NOOFFREECALLS, RATEPERCALLPERMIN, FREECALLTIME, FIXEDAMT) VALUES(105, 'PREPAID 899 PLAN', 700, 0.48, 800, 500);

INSERT INTO CUSTOMER1(CUSTNO, NAME, MOBILENO, PLANNO) VALUES(201, 'MRS JOSHI', '3204934564', 101);
INSERT INTO CUSTOMER1(CUSTNO, NAME, MOBILENO, PLANNO) VALUES(202, 'YASH KUMAR', '5465789065', 102);
INSERT INTO CUSTOMER1(CUSTNO, NAME, MOBILENO, PLANNO) VALUES(203, 'VIVEK OBEROI', '3435678764', 103);
INSERT INTO CUSTOMER1(CUSTNO, NAME, MOBILENO, PLANNO) VALUES(204, 'AKSHAY KUMAR', '4356712344', 104);
INSERT INTO CUSTOMER1(CUSTNO, NAME, MOBILENO, PLANNO) VALUES(205, 'SALMAN KHAN', '9807634564', 105); 

INSERT INTO CUSTCALLINFO(RECNO, CUSTNO, NOOFCALLS, TOTALTALKTIME, CYCLEPERIOD) VALUES(301, 201, 98, 250, 'JAN-FEB');
INSERT INTO CUSTCALLINFO(RECNO, CUSTNO, NOOFCALLS, TOTALTALKTIME, CYCLEPERIOD) VALUES(302, 202, 150, 350, 'JAN-FEB');
INSERT INTO CUSTCALLINFO(RECNO, CUSTNO, NOOFCALLS, TOTALTALKTIME, CYCLEPERIOD) VALUES(303, 203, 280, 420, 'MAR-APR');
INSERT INTO CUSTCALLINFO(RECNO, CUSTNO, NOOFCALLS, TOTALTALKTIME, CYCLEPERIOD) VALUES(304, 204, 375, 579, 'NOV-DEC');
INSERT INTO CUSTCALLINFO(RECNO, CUSTNO, NOOFCALLS, TOTALTALKTIME, CYCLEPERIOD) VALUES(305, 205, 611, 723, 'JUN-JUL');

INSERT INTO BILL(RECNO, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, STATUS, BILLPAYDATE, CUSTNO) VALUES(301, 401, 420, '2020/01/01', '2020/02/02', 'PAID', '2020/02/03', 201);  
INSERT INTO BILL(RECNO, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, STATUS, BILLPAYDATE, CUSTNO) VALUES(302, 402, 500, '2020/01/04', '2020/02/05', 'PAID', '2020/02/06', 202);
INSERT INTO BILL(RECNO, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, STATUS, BILLPAYDATE, CUSTNO) VALUES(303, 403, 600, '2020/03/07', '2020/02/08', 'UNPAID', NULL, 203);
INSERT INTO BILL(RECNO, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, STATUS, BILLPAYDATE, CUSTNO) VALUES(304, 404, 700, '2020/11/01', '2020/12/02', 'UNPAID', NULL, 204);
INSERT INTO BILL(RECNO, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, STATUS, BILLPAYDATE, CUSTNO) VALUES(305, 405, 900, '2020/06/02', '2020/07/03', 'PAID', '2020/02/03', 205);

SELECT * FROM PLAN;
SELECT * FROM CUSTOMER1;
SELECT * FROM CUSTCALLINFO;
SELECT * FROM BILL;

/*VIEWS*/
/*A*/
DROP VIEW V5;
CREATE VIEW V5 AS SELECT NAME, BILLNO, FINALBILLAMT, CYCLEDATE, BILLDUEDATE, BILLPAYDATE FROM BILL B, CUSTOMER1 C 
WHERE C.CUSTNO = B.CUSTNO AND C.NAME = "MRS JOSHI";

/*B*/
DROP VIEW V6;
CREATE VIEW V6 AS SELECT C.CUSTNO, NAME, MOBILENO FROM CUSTOMER1 C, PLAN P 
WHERE P.PLANNO = C.PLANNO AND PNAME = "PREPAID 799 PLAN";

SELECT * FROM V5;
SELECT * FROM V6;

/*FUNCTIONS*/
/*A*/
DROP FUNCTION F5;
DELIMITER $
CREATE FUNCTION F5()
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE TOTALNOCALL INTEGER;
    SELECT SUM(NOOFCALLS) INTO TOTALNOCALL FROM CUSTCALLINFO
    WHERE CYCLEPERIOD = "JAN-FEB";
    RETURN TOTALNOCALL;
END $
DELIMITER ;
SELECT F5();

/*B*/
DROP FUNCTION F6;
DELIMITER $
CREATE FUNCTION F6(PLNAME VARCHAR(20))
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE TOTALNOCUST INTEGER;
    SELECT COUNT(C.CUSTNO) INTO TOTALNOCUST FROM  CUSTOMER1 C, PLAN P 
    WHERE P.PLANNO = C.PLANNO AND PNAME = PLNAME;
    RETURN TOTALNOCUST;
END $
DELIMITER ;
SELECT F6("PREPAID 799 PLAN");

/*CURSOR*/
/*A*/
DROP PROCEDURE P4;
DELIMITER $
CREATE PROCEDURE P4(CYCLEPERIOD1 VARCHAR(20))
BEGIN
	DECLARE DONE INT DEFAULT 0;
    DECLARE RECNO1, BILLNO1, FINALBILLAMT1, CUSTNO1 INT;
    DECLARE STATUS1 VARCHAR(20);
    DECLARE CYCLEDATE1, BILLDUEDATE1 , BILLPAYDATE1 DATE;
    DECLARE C4 CURSOR FOR SELECT B.* FROM BILL B, CUSTCALLINFO C 
    WHERE C.RECNO = B.RECNO AND CYCLEPERIOD = CYCLEPERIOD1; 
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET DONE = 1;
    OPEN C4;
    REPEAT 
    FETCH C4 INTO RECNO1, BILLNO1, FINALBILLAMT1, CYCLEDATE1, BILLDUEDATE1, STATUS1, BILLPAYDATE1, CUSTNO1;
		IF NOT DONE THEN
        SELECT RECNO1, BILLNO1, FINALBILLAMT1, CYCLEDATE1, BILLDUEDATE1, STATUS1, BILLPAYDATE1, CUSTNO1;
        END IF;
	UNTIL DONE END REPEAT;
    CLOSE C4;
END $
DELIMITER ;
CALL P4("JAN-FEB");

