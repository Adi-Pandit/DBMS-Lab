USE cafy21573;

DROP TABLE AGENT_TICKET;
DROP TABLE TICKET;
DROP TABLE AGENT;

CREATE TABLE AGENT(AGENTCODE INT PRIMARY KEY, AGENTNAME VARCHAR(30));
CREATE TABLE TICKET(TCODE INT PRIMARY KEY, PASSENGERNAME VARCHAR(30), NUMBEROFTICKETS INT, BOOKINGDATE DATE, AGENTCODE INT, FOREIGN KEY(AGENTCODE) REFERENCES AGENT(AGENTCODE));
CREATE TABLE AGENT_TICKET(AGENTCODE INT, FOREIGN KEY(AGENTCODE) REFERENCES AGENT(AGENTCODE), TCODE INT, FOREIGN KEY(TCODE) REFERENCES TICKET(TCODE));

DESC AGENT;
DESC TICKET;
DESC AGENT_TICKET;

INSERT INTO AGENT(AGENTCODE, AGENTNAME) VALUES(101, 'KANISHK');
INSERT INTO AGENT(AGENTCODE, AGENTNAME) VALUES(102, 'ADITYA');
INSERT INTO AGENT(AGENTCODE, AGENTNAME) VALUES(103, 'Mr.XXX');
INSERT INTO AGENT(AGENTCODE, AGENTNAME) VALUES(104, 'PIYUSH');
INSERT INTO AGENT(AGENTCODE, AGENTNAME) VALUES(105, 'ATHARAV');

INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(201, 'VAIDEHI', 4, '2020/2/27', 101);
INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(202, 'MRUNMAI', 3, '2020/3/21', 102);
INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(203, 'SHOUNAK', 5, '2020/5/5', 103);
INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(204, 'SHUBHAM', 2, '2020/1/6', 104);
INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(205, 'ANAMIKA', 4, '2020/4/10', 105);
INSERT INTO TICKET(TCODE, PASSENGERNAME, NUMBEROFTICKETS, BOOKINGDATE, AGENTCODE) VALUES(206, 'ABHINAV', 5, '2020/5/11', 103);

INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(101, 201);
INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(102, 202);
INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(103, 203);
INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(104, 204);
INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(105, 205);
INSERT INTO AGENT_TICKET(AGENTCODE, TCODE) VALUES(103, 206);

SELECT * FROM AGENT;
SELECT * FROM TICKET;
SELECT * FROM AGENT_TICKET;

SELECT TCODE, PASSENGERNAME, AGENTNAME FROM AGENT A, TICKET T
WHERE A.AGENTCODE = T.AGENTCODE AND NUMBEROFTICKETS<5;

SELECT SUM(NUMBEROFTICKETS) FROM AGENT A, TICKET T 
WHERE A.AGENTCODE = T.AGENTCODE AND AGENTNAME = "Mr.XXX";

SELECT A.AGENTCODE, AGENTNAME, T.TCODE FROM  AGENT A, TICKET T, AGENT_TICKET AT
WHERE A.AGENTCODE = AT.AGENTCODE AND T.TCODE = AT.TCODE AND AGENTNAME LIKE '%K';

SELECT * FROM TICKET ORDER BY BOOKINGDATE DESC; 