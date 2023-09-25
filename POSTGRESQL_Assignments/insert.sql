-- Create Worker table
CREATE TABLE Worker (
    WORKER_ID SERIAL PRIMARY KEY,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE TIMESTAMP,
    DEPARTMENT CHAR(25)
);

-- Insert data into Worker table
INSERT INTO Worker
    (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
    ('Monika', 'Arora', 100000, '2020-02-14 09:00:00', 'HR'),
    ('Niharika', 'Verma', 80000, '2011-06-14 09:00:00', 'Admin'),
    ('Vishal', 'Singhal', 300000, '2020-02-14 09:00:00', 'HR'),
    ('Amitabh', 'Singh', 500000, '2020-02-14 09:00:00', 'Admin'),
    ('Vivek', 'Bhati', 500000, '2011-06-14 09:00:00', 'Admin'),
    ('Vipul', 'Diwan', 200000, '2011-06-14 09:00:00', 'Account'),
    ('Satish', 'Kumar', 75000, '2020-01-14 09:00:00', 'Account'),
    ('Geetika', 'Chauhan', 90000, '2011-04-14 09:00:00', 'Admin');

-- Create Bonus table
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE TIMESTAMP,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- Insert data into Bonus table
INSERT INTO Bonus
    (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES
    (1, 5000, '2020-02-16'),
    (2, 3000, '2011-06-16'),
    (3, 4000, '2020-02-16'),
    (1, 4500, '2020-02-16'),
    (2, 3500, '2011-06-16');

-- Create Title table
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM TIMESTAMP,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- Insert data into Title table
INSERT INTO Title
    (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM)
VALUES
    (1, 'Manager', '2016-02-20 00:00:00'),
    (2, 'Executive', '2016-06-11 00:00:00'),
    (8, 'Executive', '2016-06-11 00:00:00'),
    (5, 'Manager', '2016-06-11 00:00:00'),
    (4, 'Asst. Manager', '2016-06-11 00:00:00'),
    (7, 'Executive', '2016-06-11 00:00:00'),
    (6, 'Lead', '2016-06-11 00:00:00'),
    (3, 'Lead', '2016-06-11 00:00:00');
	
SELECT * FROM Worker;
SELECT * FROM Bonus;
SELECT * FROM Title;
