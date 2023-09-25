--- 175
CREATE TABLE Person (
	PersonId SERIAL PRIMARY KEY,
	FirstName VARCHAR,
	LastName VARCHAR
);


CREATE TABLE Address (
    AddressId SERIAL PRIMARY KEY,
    PersonId INT,
    City VARCHAR,
    State VARCHAR,
    FOREIGN KEY (PersonId) REFERENCES Person(PersonId)
);

-- Insert data into Person table
INSERT INTO Person (PersonId, FirstName, LastName)
VALUES
    (1,'John', 'Doe'),
    (2,'Jane', 'Smith'),
    (3,'Michael', 'Johnson');

-- Insert data into Address table
INSERT INTO Address (AddressId, PersonId, City, State)
VALUES
    (1,1, 'New York', 'NY'),
    (2,2, 'Los Angeles', 'CA'),
    (3,3, 'Chicago', 'IL');

SELECT
	P.FirstName,
	P.LastName,
	A.City,
	A.State
FROM
	Person P
LEFT JOIN
	Address A ON P.PersonId = A.PersonId;

-- 176
-- Create Employee table
CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Salary INT
);

-- Insert data into Employee table
INSERT INTO Employee (Id, Salary)
VALUES
    (1, 100),
    (2, 200),
    (3, 300);

-- Query to get the second highest salary
SELECT DISTINCT Salary AS SecondHighestSalary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

-- 177
SELECT DISTINCT Salary AS NthHighestSalary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

-- 178
CREATE TABLE Scores (
	Id INT PRIMARY KEY,
	Score DECIMAL(4,2)
);

INSERT INTO Scores (Id, Score)
VALUES
    (1, 3.50),
    (2, 3.65),
    (3, 4.00),
    (4, 3.85),
    (5, 4.00),
    (6, 3.65);

-- Query to rank scores with ties
SELECT
    Score,
    DENSE_RANK() OVER (ORDER BY Score DESC) AS Ranking
FROM Scores
ORDER BY Score DESC;

-- 180
CREATE TABLE ConsecutiveNumbers (
	Id INT PRIMARY KEY,
	Num INT
);

-- Insert data into ConsecutiveNumbers table
INSERT INTO ConsecutiveNumbers (Id, Num)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 1),
    (6, 2),
    (7, 2);

SELECT DISTINCT Num
FROM (
	SELECT 
		Num,
		LEAD(Num, 1) OVER (ORDER BY Id) AS NextNum,
		LAG(Num, 1) OVER (ORDER BY Id) AS PrevNum
	FROM ConsecutiveNumbers
) AS NumberSequence
WHERE Num = NextNum AND Num = PrevNum;

-- 181
-- Create Employee table
DROP TABLE Employee;

CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR,
    Salary INT,
    ManagerId INT
);

-- Insert data into Employee table
INSERT INTO Employee (Id, Name, Salary, ManagerId)
VALUES
    (1, 'Joe', 70000, 3),
    (2, 'Henry', 80000, 4),
    (3, 'Sam', 60000, NULL),
    (4, 'Max', 90000, NULL);

SELECT E1.Name AS Employee
FROM Employee E1
JOIN Employee E2 ON E1.ManagerId = E2.Id
WHERE E1.Salary > E2.Salary;

-- 182
-- Create Person table
DROP TABLE Person CASCADE;
CREATE TABLE Person (
    Id INT PRIMARY KEY,
    Email VARCHAR
);

-- Insert data into Person table
INSERT INTO Person (Id, Email)
VALUES
    (1, 'a@b.com'),
    (2, 'c@d.com'),
    (3, 'a@b.com');

SELECT Email, COUNT(*) AS Count
FROM Person
GROUP BY Email
HAVING COUNT(*) > 1;

-- 183
-- Create Customers and Orders tables
CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    Name VARCHAR
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY,
    CustomerId INT
);

-- Insert data into Customers table
INSERT INTO Customers (Id, Name)
VALUES
    (1, 'Joe'),
    (2, 'Henry'),
    (3, 'Sam'),
    (4, 'Max');

-- Insert data into Orders table
INSERT INTO Orders (Id, CustomerId)
VALUES
    (1, 3),
    (2, 1);

-- Query to find customers who never ordered anything
SELECT C.Id, C.Name
FROM Customers C
LEFT JOIN Orders O ON C.Id = O.CustomerId
WHERE O.Id IS NULL;

-- 196
drop table Person CASCADE;
CREATE TABLE Person (
    Id SERIAL PRIMARY KEY,
    Email VARCHAR(255)
);

-- Insert data in Person table
INSERT INTO Person (Email) VALUES
    ('john@example.com'),
    ('bob@example.com'),
    ('john@example.com');

DELETE FROM Person P1
WHERE Id > (
	SELECT MIN(Id)
	FROM Person P2
	WHERE P1.Email = P2.Email
);
SELECT * FROM Person;

-- 197
CREATE TABLE Weather (
    Id INT PRIMARY KEY,
    RecordDate DATE,
    Temperature INT
);

INSERT INTO Weather (Id, RecordDate, Temperature) 
VALUES
    (1, '2015-01-01', 10),
    (2, '2015-01-02', 25),
    (3, '2015-01-03', 20),
    (4, '2015-01-04', 30);
	
SELECT DISTINCT Id
FROM (
	SELECT Id,
	RecordDate,
	Temperature,
	LAG(Temperature,1) OVER (ORDER BY RecordDate) previous_temperature
	FROM Weather
) AS numbercomparison
WHERE Temperature > previous_temperature
ORDER BY Id ASC;

-- 511
CREATE TABLE Activity (
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) 
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
	
SELECT player_id, event_date
FROM (
	SELECT player_id,
	event_date,
	games_played,
	RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rank
	FROM Activity
) AS PLAYER_RANKING
WHERE rank = 1;

-- 512

DROP TABLE Activity;
CREATE TABLE Activity (
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

WITH RankedActivity AS (
    SELECT
        player_id,
        device_id,
        RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk
    FROM Activity
)
SELECT player_id, device_id
FROM RankedActivity
WHERE rnk = 1;

-- 534
DROP TABLE Activity CASCADE;
CREATE TABLE Activity (
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity 
(player_id, device_id, event_date, games_played) 
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (1, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

WITH cumulative_games AS (
    SELECT
        player_id,
        device_id,
		event_date,
        SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
    FROM Activity
)
SELECT player_id, event_date, games_played_so_far
FROM cumulative_games;

-- 570 
DROP TABLE Employee CASCADE;
CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Department VARCHAR(255),
    ManagerId INT
);

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES
    (101, 'John', 'A', NULL),
    (102, 'Dan', 'A', 101),
    (103, 'James', 'A', 101),
    (104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),
    (106, 'Ron', 'B', 101);

SELECT
    m.Id AS ManagerId,
    m.Name AS ManagerName,
    COUNT(e.Id) AS ReportCount
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
GROUP BY m.Id, m.Name
HAVING COUNT(e.Id) >= 5;

-- 577
DROP TABLE Employee CASCADE;
CREATE TABLE Employee (
    empId INT PRIMARY KEY,
    name VARCHAR(255),
    supervisor INT,
    salary INT
);

INSERT INTO Employee (empId, name, supervisor, salary) VALUES
    (1, 'John', 3, 1000),
    (2, 'Dan', 3, 2000),
    (3, 'Brad', NULL, 4000),
    (4, 'Thomas', 3, 4000);

CREATE TABLE Bonus (
    empId INT PRIMARY KEY,
    bonus INT
);

INSERT INTO Bonus (empId, bonus) VALUES
    (2, 500),
    (4, 2000);

SELECT
    e.name,
    b.bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- 584
CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    referee_id INT
);

INSERT INTO customer (id, name, referee_id) 
VALUES
    (1, 'Will', NULL),
    (2, 'Jane', NULL),
    (3, 'Alex', 2),
    (4, 'Bill', NULL),
    (5, 'Zack', 1),
    (6, 'Mark', 2);

-- 586
DROP TABLE orders CASCADE;
CREATE TABLE orders (
    order_number int PRIMARY KEY,
    customer_number int,
    order_date date,
    required_date date,
    shipped_date date,
    status char(15),
    comment char(200)
);

INSERT INTO orders (order_number, customer_number, order_date, required_date, shipped_date, status, comment) 
VALUES
    (1, 1, '2017-04-09', '2017-04-13', '2017-04-12', 'Closed', NULL),
    (2, 2, '2017-04-15', '2017-04-20', '2017-04-18', 'Closed', NULL),
    (3, 3, '2017-04-16', '2017-04-25', '2017-04-20', 'Closed', NULL),
    (4, 3, '2017-04-18', '2017-04-28', '2017-04-25', 'Closed', NULL);

SELECT customer_number
FROM orders
GROUP BY customer_number
HAVING COUNT(*) = (
    SELECT MAX(order_count) FROM (
        SELECT customer_number, COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_number
    ) AS max_order_counts
);

-- 595
CREATE TABLE World (
    name VARCHAR(255),
    continent VARCHAR(255),
    area INT,
    population INT,
    gdp INT
);

INSERT INTO World (name, continent, area, population, gdp) VALUES
    ('Afghanistan', 'Asia', 652230, 25500100, 20343000),
    ('Albania', 'Europe', 28748, 2831741, 12960000),
    ('Algeria', 'Africa', 2381741, 37100000, 188681000),
    ('Andorra', 'Europe', 468, 78115, 3712000),
    ('Angola', 'Africa', 1246700, 20609294, 100990000);

SELECT name, population, area 
FROM World
WHERE area > 3000000 or population > 25000000;

-- 596

CREATE TABLE courses (
    student VARCHAR(255),
    class VARCHAR(255)
);

INSERT INTO courses (student, class) VALUES
    ('A', 'Math'),
    ('B', 'English'),
    ('C', 'Math'),
    ('D', 'Biology'),
    ('E', 'Math'),
    ('F', 'Computer'),
    ('G', 'Math'),
    ('H', 'Math'),
    ('I', 'Math');

SELECT class
FROM courses
GROUP BY class
HAVING count(*) >= 5;

-- 597
CREATE TABLE friend_request (
    sender_id INT,
    send_to_id INT,
    request_date DATE
);

INSERT INTO friend_request (sender_id, send_to_id, request_date) VALUES
    (1, 2, '2016-06-01'),
    (1, 3, '2016-06-01'),
    (1, 4, '2016-06-01'),
    (2, 3, '2016-06-02'),
    (3, 4, '2016-06-09');

CREATE TABLE request_accepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES
    (1, 2, '2016-06-03'),
    (1, 3, '2016-06-08'),
    (2, 3, '2016-06-08'),
    (3, 4, '2016-06-09'),
    (3, 4, '2016-06-10');

------------ REMAINING SOLUTION -------------




-- 603
DROP TABLE cinema CASCADE;
CREATE TABLE cinema (
    seat_id SERIAL PRIMARY KEY,
    free BIT
);
INSERT INTO cinema (free) VALUES
    (B'1'),
    (B'0'),
    (B'1'),
    (B'1'),
    (B'1');

-- 607
CREATE TABLE salesperson (
    sales_id INT PRIMARY KEY,
    name VARCHAR(255),
    salary INT,
    commission_rate INT,
    hire_date DATE
);

CREATE TABLE company (
    com_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255)
);
DROP TABLE ORDERS CASCADE;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    sales_id INT,
    amount INT
);

INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date)
VALUES
    (1, 'John', 100000, 6, '2006-04-01'),
    (2, 'Amy', 120000, 5, '2010-05-01'),
    (3, 'Mark', 65000, 12, '2008-12-25'),
    (4, 'Pam', 25000, 25, '2005-01-01'),
    (5, 'Alex', 50000, 10, '2007-02-03');

INSERT INTO company (com_id, name, city)
VALUES
    (1, 'RED', 'Boston'),
    (2, 'ORANGE', 'New York'),
    (3, 'YELLOW', 'Boston'),
    (4, 'GREEN', 'Austin');

INSERT INTO orders (order_id, order_date, com_id, sales_id, amount)
VALUES
    (1, '2014-01-01', 3, 4, 100000),
    (2, '2014-02-01', 4, 5, 5000),
    (3, '2014-03-01', 1, 1, 50000),
    (4, '2014-04-01', 1, 4, 25000);

SELECT DISTINCT s.name
FROM salesperson s
LEFT JOIN orders o ON s.sales_id = o.sales_id AND o.com_id = (
    SELECT com_id FROM company WHERE name = 'RED'
)
WHERE o.com_id IS NULL;

-- 608
CREATE TABLE tree (
    id INT PRIMARY KEY,
    p_id INT
);
INSERT INTO tree (id, p_id) VALUES
    (1, NULL),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2);

WITH NodeTypes AS (
    SELECT
        id,
        CASE
            WHEN p_id IS NULL THEN 'Root'
            WHEN id IN (SELECT DISTINCT p_id FROM tree WHERE p_id IS NOT NULL) THEN 'Inner'
            ELSE 'Leaf'
        END AS Type
    FROM tree
)
SELECT id, Type
FROM NodeTypes
ORDER BY id;

-- 610
CREATE TABLE triangle (
    x INT,
    y INT,
    z INT
);

INSERT INTO triangle (x, y, z) VALUES
    (13, 15, 30),
    (10, 20, 15);

SELECT x, y, z,
       CASE
           WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM triangle;

-- 612
DROP TABLE point_2d CASCADE;
CREATE TABLE point_2d (
    x INT,
    y INT
);

INSERT INTO point_2d (x, y) VALUES
    (-1, -1),
    (0, 0),
    (-1, -2);

SELECT
    TO_CHAR(MIN(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 'FM9990.00') AS shortest
FROM
    point_2d p1,
    point_2d p2
WHERE
    (p1.x, p1.y) <> (p2.x, p2.y);

-- 613
CREATE TABLE point (
    x INT
);

INSERT INTO point (x) VALUES
    (-1),
    (0),
    (2);

SELECT
    MIN(x_lead - x) AS shortest
FROM
    (SELECT x, LEAD(x) OVER (ORDER BY x) AS x_lead FROM point) AS subquery;

DROP TABLE point CASCADE;
CREATE TABLE point (
    id SERIAL PRIMARY KEY,
    x INT
);
INSERT INTO point (x) VALUES
    (-1),
    (0),
    (2);

SELECT
    MIN(x_lead - x) AS shortest
FROM
    (SELECT x, LEAD(x) OVER (ORDER BY x) AS x_lead FROM point) AS subquery;

-- 619
drop table my_numbers CASCADE;
CREATE TABLE my_numbers (
    num INT
);

INSERT INTO my_numbers (num) VALUES
    (8),
    (8),
    (3),
    (3),
    (1),
    (4),
    (5),
    (6);

SELECT MAX(num) AS num
FROM my_numbers
GROUP BY num
HAVING COUNT(num) = 1
ORDER BY num DESC
LIMIT 1;

-- 620
DROP TABLE cinema CASCADE;
CREATE TABLE cinema (
    id INT PRIMARY KEY,
    movie VARCHAR(255),
    description VARCHAR(255),
    rating DECIMAL(3, 1)
);

INSERT INTO cinema (id, movie, description, rating) VALUES
    (1, 'War', 'great 3D', 8.9),
    (2, 'Science fiction', 'fiction', 8.5),
    (3, 'irish', 'boring', 6.2),
    (4, 'Ice song', 'Fantacy', 8.6),
    (5, 'House card', 'Interesting', 9.1);

SELECT id, movie, description, rating
FROM cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

-- 626
CREATE TABLE seat (
    id INT PRIMARY KEY,
    student VARCHAR(255)
);

INSERT INTO seat (id, student) VALUES
    (1, 'Abbot'),
    (2, 'Doris'),
    (3, 'Emerson'),
    (4, 'Green'),
    (5, 'Jeames');

SELECT
    CASE
        WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM seat) THEN
            LEAD(student, 1) OVER (ORDER BY id)
        WHEN id % 2 = 0 THEN
            LAG(student, 1) OVER (ORDER BY id)
        ELSE
            student
    END AS student
FROM seat
ORDER BY id;

-- 627

CREATE TABLE salary (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    sex CHAR(1),
    salary INT
);


INSERT INTO salary (name, sex, salary) VALUES
    ('A', 'm', 2500),
    ('B', 'f', 1500),
    ('C', 'm', 5500),
    ('D', 'f', 500);

UPDATE salary
SET sex = CASE
    WHEN sex = 'm' THEN 'f'
    WHEN sex = 'f' THEN 'm'
END;

select * from salary;

-- 1045
DROP TABLE Customer;
CREATE TABLE Customer (
    customer_id INT,
    product_key INT
);

CREATE TABLE Product (
    product_key INT PRIMARY KEY
);

INSERT INTO Customer (customer_id, product_key) VALUES
    (1, 5),
    (2, 6),
    (3, 5),
    (3, 6),
    (1, 6);

INSERT INTO Product (product_key) VALUES
    (5),
    (6);

SELECT c.customer_id
FROM Customer c
JOIN Product p ON c.product_key = p.product_key
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(*) FROM Product);

-- 1050
CREATE TABLE ActorDirector (
    actor_id INT,
    director_id INT,
    timestamp INT,
    PRIMARY KEY (timestamp)
);

INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES
    (1, 1, 0),
    (1, 1, 1),
    (1, 1, 2),
    (1, 2, 3),
    (1, 2, 4),
    (2, 1, 5),
    (2, 1, 6);

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;

-- 1068.
drop table Product CASCADE;
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


INSERT INTO Product (product_id, product_name) VALUES
    (100, 'Nokia'),
    (200, 'Apple'),
    (300, 'Samsung');

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
    (1, 100, 2008, 10, 5000),
    (2, 100, 2009, 12, 5000),
    (7, 200, 2011, 15, 9000);

SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id;

-- 1069.
DROP TABLE Product CASCADE;
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);

DROP TABLE Sales CASCADE;
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Product (product_id, product_name) VALUES
    (100, 'Nokia'),
    (200, 'Apple'),
    (300, 'Samsung');

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
    (1, 100, 2008, 10, 5000),
    (2, 100, 2009, 12, 5000),
    (7, 200, 2011, 15, 9000);

SELECT s.product_id, SUM(s.quantity) AS total_quantity
FROM Sales s
GROUP BY s.product_id;

-- 1070.
DROP TABLE Product CASCADE;
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);
DROP TABLE Sales CASCADE;
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


INSERT INTO Product (product_id, product_name) VALUES
    (100, 'Nokia'),
    (200, 'Apple'),
    (300, 'Samsung');

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
    (1, 100, 2008, 10, 5000),
    (2, 200, 2009, 12, 5000),
    (3, 200, 2011, 15, 9000);


SELECT
    product_id,
    MIN(year) AS first_year,
    SUM(quantity) AS quantity,
    price
FROM Sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
)
GROUP BY product_id, price;

-- 1075.
CREATE TABLE Project (
    project_id int,
    employee_id int,
    PRIMARY KEY (project_id, employee_id)
);

DROP TABLE Employee CASCADE;
CREATE TABLE Employee (
    employee_id int PRIMARY KEY,
    name varchar,
    experience_years int
);

INSERT INTO Project (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

INSERT INTO Employee (employee_id, name, experience_years) VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 1),
    (4, 'Doe', 2);

SELECT
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- 1076.
DROP TABLE Project CASCADE;
CREATE TABLE Project (
    project_id int,
    employee_id int,
    PRIMARY KEY (project_id, employee_id)
);
DROP TABLE Employee;
CREATE TABLE Employee (
    employee_id int PRIMARY KEY,
    name varchar,
    experience_years int
);

INSERT INTO Project (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

INSERT INTO Employee (employee_id, name, experience_years) VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 1),
    (4, 'Doe', 2);

SELECT project_id
FROM (
    SELECT project_id, ROW_NUMBER() OVER (ORDER BY COUNT(employee_id) DESC) AS rnk
    FROM Project
    GROUP BY project_id
) AS ranked
WHERE rnk = 1;

-- 1077
DROP TABLE Project CASCADE;
CREATE TABLE Project (
    project_id int,
    employee_id int,
    PRIMARY KEY (project_id, employee_id)
);
DROP TABLE Employee;
CREATE TABLE Employee (
    employee_id int PRIMARY KEY,
    name varchar,
    experience_years int
);

INSERT INTO Project (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

INSERT INTO Employee (employee_id, name, experience_years) VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);

SELECT p.project_id, e.employee_id
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
WHERE (p.project_id, e.experience_years) IN (
    SELECT project_id, MAX(experience_years)
    FROM Project p1
    JOIN Employee e1 ON p1.employee_id = e1.employee_id
    GROUP BY project_id
);

-- 1082.
DROP TABLE Product CASCADE;
CREATE TABLE Product (
    product_id int PRIMARY KEY,
    product_name varchar,
    unit_price int
);
DROP TABLE Sales CASCADE;
CREATE TABLE Sales (
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int
);

INSERT INTO Product (product_id, product_name, unit_price) VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);

INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);

SELECT seller_id
FROM (
    SELECT seller_id, SUM(price) AS total_price,
           RANK() OVER (ORDER BY SUM(price) DESC) AS rnk
    FROM Sales
    GROUP BY seller_id
) AS ranked
WHERE rnk = 1;

-- 1083
DROP TABLE Product CASCADE;
CREATE TABLE Product (
    product_id int PRIMARY KEY,
    product_name varchar,
    unit_price int
);
DROP TABLE Sales CASCADE;
CREATE TABLE Sales (
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int
);

INSERT INTO Product (product_id, product_name, unit_price) VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);

INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 1, 3, '2019-06-02', 1, 800),
    (3, 3, 3, '2019-05-13', 2, 2800);

SELECT DISTINCT buyer_id
FROM Sales
WHERE product_id = (SELECT product_id FROM Product WHERE product_name = 'S8')
  AND buyer_id NOT IN (
    SELECT buyer_id
    FROM Sales
    WHERE product_id = (SELECT product_id FROM Product WHERE product_name = 'iPhone')
);

-- 1084
DROP TABLE Product CASCADE;
CREATE TABLE Product (
    product_id int PRIMARY KEY,
    product_name varchar,
    unit_price int
);
DROP TABLE Sales CASCADE;
CREATE TABLE Sales (
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int
);

INSERT INTO Product (product_id, product_name, unit_price) VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);

INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);

SELECT DISTINCT p.product_id, p.product_name
FROM Product p
LEFT JOIN Sales s ON p.product_id = s.product_id
WHERE s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
  AND p.product_id NOT IN (
    SELECT product_id
    FROM Sales
    WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
);

-- 1112
CREATE TABLE Enrollments (
    student_id int,
    course_id int,
    grade int
);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
    (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);

SELECT e.student_id, e.course_id, e.grade
FROM (
    SELECT student_id, MAX(grade) AS max_grade
    FROM Enrollments
    GROUP BY student_id
) max_grades
JOIN Enrollments e ON max_grades.student_id = e.student_id AND max_grades.max_grade = e.grade
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments e2
    WHERE e2.student_id = e.student_id
    AND e2.grade = e.grade
    AND e2.course_id < e.course_id
)
ORDER BY e.student_id;

-- 1113.
CREATE TABLE Actions (
    user_id int,
    post_id int,
    action_date date,
    action varchar,
    extra varchar
);

INSERT INTO Actions (user_id, post_id, action_date, action, extra)
VALUES
    (1, 1, '2019-07-01', 'view', NULL),
    (1, 1, '2019-07-01', 'like', NULL),
    (1, 1, '2019-07-01', 'share', NULL),
    (2, 4, '2019-07-04', 'view', NULL),
    (2, 4, '2019-07-04', 'report', 'spam'),
    (3, 4, '2019-07-04', 'view', NULL),
    (3, 4, '2019-07-04', 'report', 'spam'),
    (4, 3, '2019-07-02', 'view', NULL),
    (4, 3, '2019-07-02', 'report', 'spam'),
    (5, 2, '2019-07-04', 'view', NULL),
    (5, 2, '2019-07-04', 'report', 'racism'),
    (5, 5, '2019-07-04', 'view', NULL),
    (5, 5, '2019-07-04', 'report', 'racism');

SELECT extra AS report_reason, COUNT(*) AS report_count
FROM Actions
WHERE action = 'report' AND action_date = '2019-07-04'
GROUP BY extra
HAVING COUNT(*) > 0;

-- 1126.
CREATE TABLE Events (
    business_id int,
    event_type varchar,
    occurrences int,
    PRIMARY KEY (business_id, event_type)
);

INSERT INTO Events (business_id, event_type, occurrences)
VALUES
    (1, 'reviews', 7),
    (3, 'reviews', 3),
    (1, 'ads', 11),
    (2, 'ads', 7),
    (3, 'ads', 6),
    (1, 'page views', 3),
    (2, 'page views', 12);

WITH EventTypeAvg AS (
    SELECT event_type, AVG(occurrences) AS avg_occurrences
    FROM Events
    GROUP BY event_type
)
SELECT DISTINCT e.business_id
FROM Events e
JOIN EventTypeAvg et ON e.event_type = et.event_type
WHERE e.occurrences > et.avg_occurrences;

-- 1141
DROP TABLE Activity CASCADE;
CREATE TABLE Activity (
    user_id int,
    session_id int,
    activity_date date,
    activity_type varchar
);

INSERT INTO Activity (user_id, session_id, activity_date, activity_type)
VALUES
    (1, 1, '2019-07-20', 'open_session'),
    (1, 1, '2019-07-20', 'scroll_down'),
    (1, 1, '2019-07-20', 'end_session'),
    (2, 4, '2019-07-20', 'open_session'),
    (2, 4, '2019-07-21', 'send_message'),
    (2, 4, '2019-07-21', 'end_session'),
    (3, 2, '2019-07-21', 'open_session'),
    (3, 2, '2019-07-21', 'send_message'),
    (3, 2, '2019-07-21', 'end_session'),
    (4, 3, '2019-06-25', 'open_session'),
    (4, 3, '2019-06-25', 'end_session');

SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
HAVING COUNT(DISTINCT user_id) > 0;

-- 1142.
DROP TABLE Activity CASCADE;
CREATE TABLE Activity (
    user_id int,
    session_id int,
    activity_date date,
    activity_type varchar
);

INSERT INTO Activity (user_id, session_id, activity_date, activity_type)
VALUES
    (1, 1, '2019-07-20', 'open_session'),
    (1, 1, '2019-07-20', 'scroll_down'),
    (1, 1, '2019-07-20', 'end_session'),
    (2, 4, '2019-07-20', 'open_session'),
    (2, 4, '2019-07-21', 'send_message'),
    (2, 4, '2019-07-21', 'end_session'),
    (3, 2, '2019-07-21', 'open_session'),
    (3, 2, '2019-07-21', 'send_message'),
    (3, 2, '2019-07-21', 'end_session'),
    (3, 5, '2019-07-21', 'open_session'),
    (3, 5, '2019-07-21', 'scroll_down'),
    (3, 5, '2019-07-21', 'end_session'),
    (4, 3, '2019-06-25', 'open_session'),
    (4, 3, '2019-06-25', 'end_session');

SELECT ROUND(AVG(sessions_per_user)::numeric, 2) AS average_sessions_per_user
FROM (
    SELECT user_id, COUNT(DISTINCT session_id) AS sessions_per_user
    FROM Activity
    WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
    GROUP BY user_id
) AS user_sessions;

-- 1148.
CREATE TABLE Views (
    article_id int,
    author_id int,
    viewer_id int,
    view_date date
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date)
VALUES
    (1, 3, 5, '2019-08-01'),
    (1, 3, 6, '2019-08-02'),
    (2, 7, 7, '2019-08-01'),
    (2, 7, 6, '2019-08-02'),
    (4, 7, 1, '2019-07-22'),
    (3, 4, 4, '2019-07-21'),
    (3, 4, 4, '2019-07-21');

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

-- 1164.
-- DROP TABLE Products CASCADE;
CREATE TABLE Products (
    product_id int,
    new_price int,
    change_date date
);

INSERT INTO Products (product_id, new_price, change_date)
VALUES
    (1, 20, '2019-08-14'),
    (2, 50, '2019-08-14'),
    (1, 30, '2019-08-15'),
    (1, 35, '2019-08-16'),
    (2, 65, '2019-08-17'),
    (3, 20, '2019-08-18');

SELECT
    product_id,
    COALESCE(MAX(CASE WHEN change_date <= '2019-08-16' THEN new_price END), 10) AS price
FROM Products
GROUP BY product_id
ORDER BY product_id;


-- 1173.
CREATE TABLE Delivery (
    delivery_id int PRIMARY KEY,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');

SELECT
    ROUND(
        (COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END)::numeric / COUNT(*)) * 100,
        2
    ) AS immediate_percentage
FROM Delivery;

-- 1174
DROP TABLE Delivery CASCADE;
CREATE TABLE Delivery (
    delivery_id int PRIMARY KEY,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 2, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-12'),
    (4, 3, '2019-08-24', '2019-08-24'),
    (5, 3, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13'),
    (7, 4, '2019-08-09', '2019-08-09');

SELECT
    ROUND(
        (COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END)::numeric /
         COUNT(*)) * 100,
        2
    ) AS immediate_percentage
FROM (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
) AS first_orders
JOIN Delivery ON first_orders.customer_id = Delivery.customer_id AND
                 first_orders.first_order_date = Delivery.order_date;

-- 1179
CREATE TABLE Department (
    id int,
    revenue int,
    month varchar
);

INSERT INTO Department (id, revenue, month)
VALUES
    (1, 8000, 'Jan'),
    (2, 9000, 'Jan'),
    (3, 10000, 'Feb'),
    (1, 7000, 'Feb'),
    (1, 6000, 'Mar');

SELECT
    id,
    MAX(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    MAX(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    MAX(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
    MAX(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
    MAX(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
    MAX(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
    MAX(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
    MAX(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
    MAX(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
    MAX(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
    MAX(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
    MAX(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;

-- 1193.
CREATE TABLE Transactions (
    id int PRIMARY KEY,
    country varchar,
    state varchar,
    amount int,
    trans_date date
);

INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES
    (121, 'US', 'approved', 1000, '2018-12-18'),
    (122, 'US', 'declined', 2000, '2018-12-19'),
    (123, 'US', 'approved', 2000, '2019-01-01'),
    (124, 'DE', 'approved', 2000, '2019-01-07');

SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
ORDER BY month, country;

-- 1204
CREATE TABLE Queue (
    person_id int PRIMARY KEY,
    person_name varchar,
    weight int,
    turn int
);

INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES
    (5, 'George Washington', 250, 1),
    (3, 'John Adams', 350, 2),
    (6, 'Thomas Jefferson', 400, 3),
    (2, 'Will Johnliams', 200, 4),
    (4, 'Thomas Jefferson', 175, 5),
    (1, 'James Elephant', 500, 6);

SELECT person_name
FROM Queue
WHERE (
    SELECT SUM(weight)
    FROM Queue AS Q
    WHERE Q.turn <= Queue.turn
) <= 1000
ORDER BY turn DESC
LIMIT 1;

-- 1211.
-- Create the Queries table
CREATE TABLE Queries (
    query_name varchar,
    result varchar,
    position int,
    rating int
);

-- Insert data into the Queries table
INSERT INTO Queries (query_name, result, position, rating)
VALUES
    ('Dog', 'Golden Retriever', 1, 5),
    ('Dog', 'German Shepherd', 2, 5),
    ('Dog', 'Mule', 200, 1),
    ('Cat', 'Shirazi', 5, 2),
    ('Cat', 'Siamese', 3, 3),
    ('Cat', 'Sphynx', 7, 4);

-- Write the optimized query
SELECT query_name,
       ROUND(AVG(1.0 * rating / position), 2) AS quality,
       ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;

-- 1212.
-- Create the Teams table
CREATE TABLE Teams (
    team_id int PRIMARY KEY,
    team_name varchar
);

-- Insert data into the Teams table
INSERT INTO Teams (team_id, team_name)
VALUES
    (10, 'Leetcode FC'),
    (20, 'NewYork FC'),
    (30, 'Atlanta FC'),
    (40, 'Chicago FC'),
    (50, 'Toronto FC');

-- Create the Matches table
CREATE TABLE Matches (
    match_id int PRIMARY KEY,
    host_team int,
    guest_team int,
    host_goals int,
    guest_goals int
);

-- Insert data into the Matches table
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES
    (1, 10, 20, 3, 0),
    (2, 30, 10, 2, 2),
    (3, 10, 50, 5, 1),
    (4, 20, 30, 1, 0),
    (5, 50, 30, 1, 0);

-- Write the optimized query to calculate team scores
SELECT t.team_id,
       t.team_name,
       SUM(CASE
               WHEN m.host_team = t.team_id AND m.host_goals > m.guest_goals THEN 3
               WHEN m.host_team = t.team_id AND m.host_goals = m.guest_goals THEN 1
               WHEN m.guest_team = t.team_id AND m.guest_goals > m.host_goals THEN 3
               WHEN m.guest_team = t.team_id AND m.guest_goals = m.host_goals THEN 1
               ELSE 0
           END) AS num_points
FROM Teams t
LEFT JOIN Matches m ON t.team_id = m.host_team OR t.team_id = m.guest_team
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id;

-- 1225.
-- Create the Failed table
CREATE TABLE Failed (
    fail_date date PRIMARY KEY
);

-- Insert data into the Failed table
INSERT INTO Failed (fail_date)
VALUES
    ('2018-12-28'),
    ('2018-12-29'),
    ('2019-01-04'),
    ('2019-01-05');

-- Create the Succeeded table
CREATE TABLE Succeeded (
    success_date date PRIMARY KEY
);

-- Insert data into the Succeeded table
INSERT INTO Succeeded (success_date)
VALUES
    ('2018-12-30'),
    ('2018-12-31'),
    ('2019-01-01'),
    ('2019-01-02'),
    ('2019-01-03'),
    ('2019-01-06');

-- Write the optimized query to generate the report
WITH CombinedDates AS (
    SELECT fail_date AS event_date, 'failed' AS period_state FROM Failed
    UNION ALL
    SELECT success_date AS event_date, 'succeeded' AS period_state FROM Succeeded
)
, OrderedDates AS (
    SELECT event_date,
           period_state,
           ROW_NUMBER() OVER (ORDER BY event_date) - 
           ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY event_date) AS grp
    FROM CombinedDates
    WHERE event_date BETWEEN '2019-01-01' AND '2019-12-31'
)
SELECT period_state,
       MIN(event_date) AS start_date,
       MAX(event_date) AS end_date
FROM OrderedDates
GROUP BY period_state, grp
ORDER BY start_date;

-- 1241.
-- Create the Submissions table
CREATE TABLE Submissions (
    sub_id int,
    parent_id int
);

-- Insert data into the Submissions table
INSERT INTO Submissions (sub_id, parent_id)
VALUES
    (1, Null),
    (2, Null),
    (1, Null),
    (12, Null),
    (3, 1),
    (5, 2),
    (3, 1),
    (4, 1),
    (9, 1),
    (10, 2),
    (6, 7);

-- Write the optimized query to find the number of comments per each post
SELECT s.sub_id AS post_id,
       COALESCE(COUNT(DISTINCT c.sub_id), 0) AS number_of_comments
FROM Submissions s
LEFT JOIN Submissions c ON s.sub_id = c.parent_id
WHERE s.parent_id IS NULL
GROUP BY s.sub_id
ORDER BY s.sub_id;

-- 1251.
-- Create Prices table
CREATE TABLE Prices (
    product_id int,
    start_date date,
    end_date date,
    price int,
    PRIMARY KEY (product_id, start_date, end_date)
);

-- Insert data into Prices table
INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

-- Create UnitsSold table
CREATE TABLE UnitsSold (
    product_id int,
    purchase_date date,
    units int
);

-- Insert data into UnitsSold table
INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);

-- Write the optimized SQL query
SELECT p.product_id,
       ROUND(SUM(u.units * p.price * 1.0) / SUM(u.units), 2) AS average_price
FROM Prices p
JOIN UnitsSold u ON p.product_id = u.product_id
               AND u.purchase_date >= p.start_date
               AND u.purchase_date <= p.end_date
GROUP BY p.product_id;

-- 1264.
-- Create Friendship table
CREATE TABLE Friendship (
    user1_id int,
    user2_id int,
    PRIMARY KEY (user1_id, user2_id)
);

-- Insert data into Friendship table
INSERT INTO Friendship (user1_id, user2_id)
VALUES
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 3),
    (2, 4),
    (2, 5),
    (6, 1);

-- Create Likes table
DROP TABLE Likes CASCADE;
CREATE TABLE Likes (
    user_id int,
    page_id int,
    PRIMARY KEY (user_id, page_id)
);

-- Insert data into Likes table
INSERT INTO Likes (user_id, page_id)
VALUES
    (1, 88),
    (2, 23),
    (3, 24),
    (4, 56),
    (5, 11),
    (6, 33),
    (2, 77),
    (3, 77),
    (6, 88);

-- Write the optimized SQL query
SELECT DISTINCT l.page_id AS recommended_page
FROM Likes l
LEFT JOIN Friendship f1 ON f1.user2_id = l.user_id
LEFT JOIN Friendship f2 ON f2.user1_id = l.user_id
WHERE (f1.user1_id = 1 OR f2.user2_id = 1) AND 
    l.page_id NOT IN (
        SELECT page_id 
        FROM Likes 
        WHERE user_id = 1
);

-- 1270.
-- Create Employees table
DROP TABLE Employees CASCADE;
CREATE TABLE Employees (
    employee_id int PRIMARY KEY,
    employee_name varchar,
    manager_id int
);

-- Insert data into Employees table
INSERT INTO Employees (employee_id, employee_name, manager_id)
VALUES
    (1, 'Boss', 1),
    (3, 'Alice', 3),
    (2, 'Bob', 1),
    (4, 'Daniel', 2),
    (7, 'Luis', 4),
    (8, 'Jhon', 3),
    (9, 'Angela', 8),
    (77, 'Robert', 1);

-- Write the optimized SQL query
WITH RECURSIVE DirectReports AS (
    SELECT employee_id
    FROM Employees
    WHERE manager_id = 1
    AND employee_id <> 1
)
SELECT *
FROM (
    SELECT employee_id
    FROM DirectReports
    
    UNION ALL
    
    SELECT employee_id
    FROM Employees 
    WHERE manager_id IN (SELECT employee_id FROM DirectReports)
    
    UNION ALL
    
    SELECT employee_id
    FROM Employees
    WHERE manager_id IN (
        SELECT e.employee_id
        FROM Employees e 
        WHERE manager_id IN (SELECT employee_id FROM DirectReports)
    )
) AS EmployeeHierarchy;


-- 1280
CREATE TABLE Students (
    student_id int PRIMARY KEY,
    student_name varchar
);

CREATE TABLE Subjects (
    subject_name varchar PRIMARY KEY
);

CREATE TABLE Examinations (
    student_id int,
    subject_name varchar
);

INSERT INTO Students (student_id, student_name)
VALUES (1, 'Alice'),
       (2, 'Bob'),
       (13, 'John'),
       (6, 'Alex');

INSERT INTO Subjects (subject_name)
VALUES ('Math'),
       ('Physics'),
       ('Programming');

INSERT INTO Examinations (student_id, subject_name)
VALUES (1, 'Math'),
       (1, 'Physics'),
       (1, 'Programming'),
       (2, 'Programming'),
       (1, 'Physics'),
       (1, 'Math'),
       (13, 'Math'),
       (13, 'Programming'),
       (13, 'Physics'),
       (2, 'Math'),
       (1, 'Math');

SELECT s.student_id,
       s.student_name,
       sub.subject_name,
       COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;


-- 1285.
CREATE TABLE Logs (
    log_id int PRIMARY KEY
);

INSERT INTO Logs (log_id)
VALUES (1),
       (2),
       (3),
       (7),
       (8),
       (10);

WITH RankedLogs AS (
    SELECT log_id,
           log_id - ROW_NUMBER() OVER (ORDER BY log_id) AS group_id
    FROM Logs
)
SELECT MIN(log_id) AS start_id,
       MAX(log_id) AS end_id
FROM RankedLogs
GROUP BY group_id
ORDER BY start_id;


-- 1294.
CREATE TABLE Countries (
    country_id int PRIMARY KEY,
    country_name varchar
);

INSERT INTO Countries (country_id, country_name)
VALUES (2, 'USA'),
       (3, 'Australia'),
       (7, 'Peru'),
       (5, 'China'),
       (8, 'Morocco'),
       (9, 'Spain');
	   
DROP TABLE Weather CASCADE;
CREATE TABLE Weather (
    country_id int,
    weather_state int,
    day date,
    PRIMARY KEY (country_id, day)
);

INSERT INTO Weather (country_id, weather_state, day)
VALUES (2, 15, '2019-11-01'),
       (2, 12, '2019-10-28'),
       (2, 12, '2019-10-27'),
       (3, -2, '2019-11-10'),
       (3, 0, '2019-11-11'),
       (3, 3, '2019-11-12'),
       (5, 16, '2019-11-07'),
       (5, 18, '2019-11-09'),
       (5, 21, '2019-11-23'),
       (7, 25, '2019-11-28'),
       (7, 22, '2019-12-01'),
       (7, 20, '2019-12-02'),
       (8, 25, '2019-11-05'),
       (8, 27, '2019-11-15'),
       (8, 31, '2019-11-25'),
       (9, 7, '2019-10-23'),
       (9, 3, '2019-12-23');

SELECT c.country_name,
       CASE
           WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
           WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
           ELSE 'Warm'
       END AS weather_type
FROM Countries c
LEFT JOIN Weather w ON c.country_id = w.country_id
WHERE EXTRACT(YEAR FROM w.day) = 2019 AND EXTRACT(MONTH FROM w.day) = 11
GROUP BY c.country_id, c.country_name
ORDER BY c.country_name;

-- 1303.
DROP TABLE Employee CASCADE;
CREATE TABLE Employee (
    employee_id int PRIMARY KEY,
    team_id int
);

INSERT INTO Employee (employee_id, team_id)
VALUES (1, 8),
       (2, 8),
       (3, 8),
       (4, 7),
       (5, 9),
       (6, 9);
	   
SELECT e.employee_id, t.team_size
FROM Employee e
JOIN (
    SELECT team_id, COUNT(*) AS team_size
    FROM Employee
    GROUP BY team_id
) t ON e.team_id = t.team_id
ORDER BY e.employee_id;

-- 1308.
DROP TABLE Scores CASCADE;
CREATE TABLE Scores (
    player_name varchar,
    gender varchar,
    day date,
    score_points int,
    PRIMARY KEY (gender, day)
);

INSERT INTO Scores (player_name, gender, day, score_points)
VALUES ('Aron', 'F', '2020-01-01', 17),
       ('Alice', 'F', '2020-01-07', 23),
       ('Bajrang', 'M', '2020-01-07', 7),
       ('Khali', 'M', '2019-12-25', 11),
       ('Slaman', 'M', '2019-12-30', 13),
       ('Joe', 'M', '2019-12-31', 3),
       ('Jose', 'M', '2019-12-18', 2),
       ('Priya', 'F', '2019-12-31', 23),
       ('Priyanka', 'F', '2019-12-30', 17);

SELECT gender, day, SUM(score_points) OVER(PARTITION BY gender ORDER BY day) AS total
FROM Scores
ORDER BY gender, day;

-- 1321.
DROP TABLE Customer CASCADE;
CREATE TABLE Customer (
    customer_id int,
    name varchar,
    visited_on date,
    amount int,
    PRIMARY KEY (customer_id, visited_on)
);

INSERT INTO Customer (customer_id, name, visited_on, amount)
VALUES (1, 'Jhon', '2019-01-01', 100),
       (2, 'Daniel', '2019-01-02', 110),
       (3, 'Jade', '2019-01-03', 120),
       (4, 'Khaled', '2019-01-04', 130),
       (5, 'Winston', '2019-01-05', 110),
       (6, 'Elvis', '2019-01-06', 140),
       (7, 'Anna', '2019-01-07', 150),
       (8, 'Maria', '2019-01-08', 80),
       (9, 'Jaze', '2019-01-09', 110),
       (1, 'Jhon', '2019-01-10', 130),
       (3, 'Jade', '2019-01-10', 150);

SELECT c1.visited_on,
       SUM(c2.amount) AS amount,
       ROUND(AVG(c2.amount)::numeric, 2) AS average_amount
FROM (
    SELECT visited_on, SUM(amount) AS amount
    FROM customer
    GROUP BY visited_on
) c1
JOIN (
    SELECT visited_on, SUM(amount) AS amount
    FROM customer
    GROUP BY visited_on
) c2
ON c1.visited_on - c2.visited_on BETWEEN 0 AND 6
GROUP BY c1.visited_on
HAVING COUNT(c2.amount) = 7

-- 1322
-- Create the Ads table
CREATE TABLE Ads (
    ad_id int,
    user_id int,
    action varchar,
    PRIMARY KEY (ad_id, user_id)
);

-- Insert data into the Ads table
INSERT INTO Ads (ad_id, user_id, action)
VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');

-- Write the optimized query to calculate CTR
SELECT ad_id,
       CASE
           WHEN total_clicks + total_views = 0 THEN 0
           ELSE ROUND(total_clicks::numeric / (total_clicks + total_views) * 100, 2)
       END AS ctr
FROM (
    SELECT ad_id,
           SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) AS total_clicks,
           SUM(CASE WHEN action = 'Viewed' THEN 1 ELSE 0 END) AS total_views
    FROM Ads
    WHERE action != 'Ignored'
    GROUP BY ad_id
) AS subquery
ORDER BY ctr DESC, ad_id;

-- 1327.
-- Create Products table
DROP TABLE Products CASCADE;
CREATE TABLE Products (
    product_id int PRIMARY KEY,
    product_name varchar,
    product_category varchar
);

-- Insert data into Products table
INSERT INTO Products (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
    (3, 'HP', 'Laptop'),
    (4, 'Lenovo', 'Laptop'),
    (5, 'Leetcode Kit', 'T-shirt');

-- Create Orders table
DROP TABLE Orders CASCADE;
CREATE TABLE Orders (
    product_id int,
    order_date date,
    unit int
);

-- Insert data into Orders table
INSERT INTO Orders (product_id, order_date, unit)
VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);

-- Query to get the names of products with >= 100 units ordered in Feb 2020 and their amount
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100
ORDER BY unit DESC;

-- 1336.
-- Create Visits table
CREATE TABLE Visits (
    user_id int,
    visit_date date,
    PRIMARY KEY (user_id, visit_date)
);

-- Insert data into Visits table
INSERT INTO Visits (user_id, visit_date)
VALUES
    (1, '2020-01-01'),
    (2, '2020-01-02'),
    (12, '2020-01-01'),
    (19, '2020-01-03'),
    (1, '2020-01-02'),
    (2, '2020-01-03'),
    (1, '2020-01-04'),
    (7, '2020-01-11'),
    (9, '2020-01-25'),
    (8, '2020-01-28');

-- Create Transactions table
DROP TABLE Transactions CASCADE;
CREATE TABLE Transactions (
    user_id int,
    transaction_date date,
    amount int
);

-- Insert data into Transactions table
INSERT INTO Transactions (user_id, transaction_date, amount)
VALUES
    (1, '2020-01-02', 120),
    (2, '2020-01-03', 22),
    (7, '2020-01-11', 232),
    (1, '2020-01-04', 7),
    (9, '2020-01-25', 33),
    (9, '2020-01-25', 66),
    (8, '2020-01-28', 1),
    (9, '2020-01-25', 99);

WITH RECURSIVE a AS (
    SELECT v.user_id, v.visit_date, COUNT(amount) AS trans_counts
    FROM Visits v
    LEFT JOIN Transactions t ON v.user_id = t.user_id AND v.visit_date = t.transaction_date
    GROUP BY v.user_id, v.visit_date
),
b AS (
    SELECT 0 AS transactions_count
    UNION ALL
    SELECT transactions_count + 1 
    FROM b 
    WHERE transactions_count < (SELECT MAX(trans_counts) FROM a)
)
SELECT transactions_count, COUNT(a.trans_counts) AS visits_count
FROM b
LEFT JOIN a ON b.transactions_count = a.trans_counts
GROUP BY transactions_count;


























