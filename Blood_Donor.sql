USE cafy21573;

DROP TABLE BLOOD;
DROP TABLE DONOR;

CREATE TABLE DONOR(DONOR_NO INT PRIMARY KEY, NAME VARCHAR(10), CITY VARCHAR(10));
CREATE TABLE BLOOD(BLOOD_ID INT PRIMARY KEY, BLOODGROUP VARCHAR(10) NOT NULL, QUANTITY INT, RHFACTOR VARCHAR(10), DATE_OF_COLLECTION DATE, DONOR_NO INT, FOREIGN KEY(DONOR_NO) REFERENCES DONOR(DONOR_NO));

DESC DONOR;
DESC BLOOD;

INSERT INTO DONOR(DONOR_NO, NAME, CITY) VALUES(1, 'ADITYA', 'PUNE');
INSERT INTO DONOR(DONOR_NO, NAME, CITY) VALUES(2, 'PIYUSH', 'PUNE');
INSERT INTO DONOR(DONOR_NO, NAME, CITY) VALUES(3, 'ATHARAV', 'PUNE');
INSERT INTO DONOR(DONOR_NO, NAME, CITY) VALUES(4, 'SANKET', 'NAGAR');
INSERT INTO DONOR(DONOR_NO, NAME, CITY) VALUES(5, 'SAMAY', 'MUMBAI');

INSERT INTO BLOOD(BLOOD_ID, BLOODGROUP, QUANTITY, RHFACTOR, DATE_OF_COLLECTION, DONOR_NO) VALUES(101, 'A', 2, '+VE', '2018/12/12', 1);
INSERT INTO BLOOD(BLOOD_ID, BLOODGROUP, QUANTITY, RHFACTOR, DATE_OF_COLLECTION, DONOR_NO) VALUES(102, 'B', 2, '-VE', '2007/01/31', 2);
INSERT INTO BLOOD(BLOOD_ID, BLOODGROUP, QUANTITY, RHFACTOR, DATE_OF_COLLECTION, DONOR_NO) VALUES(103, 'AB', 1, '+VE', '2008/04/11', 3);
INSERT INTO BLOOD(BLOOD_ID, BLOODGROUP, QUANTITY, RHFACTOR, DATE_OF_COLLECTION, DONOR_NO) VALUES(104, 'A', 2, '-VE', '2007/01/31', 4);
INSERT INTO BLOOD(BLOOD_ID, BLOODGROUP, QUANTITY, RHFACTOR, DATE_OF_COLLECTION, DONOR_NO) VALUES(105, 'B', 2, '-VE', '2007/01/31', 5);

SELECT * FROM DONOR;
SELECT * FROM BLOOD;

SELECT COUNT(D.DONOR_NO) FROM DONOR D, BLOOD B
WHERE D.DONOR_NO = B.DONOR_NO AND DATE_OF_COLLECTION = "2008/04/11";  

SELECT D.NAME, D.CITY FROM DONOR D, BLOOD B
WHERE D.DONOR_NO = B.DONOR_NO AND BLOODGROUP = 'A' AND RHFACTOR = '-VE';

SELECT BLOODGROUP, SUM(QUANTITY) FROM BLOOD 
WHERE DATE_OF_COLLECTION = "2007/01/31" GROUP BY BLOODGROUP; 

SELECT B.* FROM DONOR D, BLOOD B
WHERE D.DONOR_NO = B.DONOR_NO GROUP BY DONOR_NO;

SELECT * FROM BLOOD WHERE DONOR_NO IN (SELECT DONOR_NO FROM DONOR GROUP BY DONOR_NO);