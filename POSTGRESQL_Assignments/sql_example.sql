-- CREATE TABLE loan_data
CREATE TABLE loan_data (
    LoanNr_ChkDgt INT PRIMARY KEY,
    Name TEXT,
    City TEXT,
    State TEXT,
    Zip TEXT,
    Bank TEXT,
    BankState TEXT,
    NAICS INT,
    ApprovalDate DATE,
    ApprovalFY INT,
    Term INT,
    NoEmp INT,
    NewExist INT,
    FranchiseCode INT,
    LowDoc TEXT,
    DisbursementDate DATE
);

select * from loan_data;

-- 1.Views and Materialized Views
-- 1.1
CREATE VIEW high_approval_loans AS
SELECT *
FROM loan_data
WHERE ApprovalFY > 100000;

-- 1.2
CREATE MATERIALIZED VIEW state_loan_counts AS
SELECT State, COUNT(*) AS loan_count
FROM loan_data
GROUP BY State;

-- 1.3
CREATE VIEW local_bank_loans AS
SELECT ld.*
FROM loan_data ld
JOIN (
    SELECT DISTINCT BankState
    FROM loan_data
) AS bank_states ON ld.BankState = bank_states.BankState;

-- 1.4
CREATE MATERIALIZED VIEW bank_loan_counts AS
SELECT Bank, COUNT(*) AS loan_count
FROM loan_data
GROUP BY Bank;

-- 1.5
CREATE VIEW long_term_loans AS
SELECT ld.*
FROM loan_data ld
JOIN (
    SELECT AVG(Term) AS avg_term
    FROM loan_data
) AS avg_terms ON ld.Term > avg_terms.avg_term;

-- 2. Sub-queries
-- 2.1
SELECT Name
FROM loan_data
WHERE State IN (SELECT State FROM loan_data GROUP BY State HAVING COUNT(*) > 2);

-- 2.2
SELECT DISTINCT City
FROM loan_data
WHERE BankState = 'IN' AND Bank IN (SELECT Bank FROM loan_data WHERE BankState = 'IN' GROUP BY Bank HAVING COUNT(*) > 0);

-- 2.3
SELECT Name
FROM loan_data
WHERE State IN (SELECT State FROM loan_data GROUP BY State HAVING COUNT(*) > 0);

-- 2.4
SELECT DISTINCT State
FROM loan_data
WHERE (SELECT AVG(Term) FROM loan_data WHERE BankState = loan_data.State) > (SELECT AVG(Term) FROM loan_data);

-- 2.5
SELECT DISTINCT City
FROM loan_data
WHERE Term > (SELECT AVG(Term) FROM loan_data WHERE City = loan_data.City);

-- 3. CTE
-- 3.1
WITH bank_loan_counts AS (
    SELECT Bank, COUNT(*) AS loan_count
    FROM loan_data
    GROUP BY Bank
)
SELECT Bank, loan_count
FROM bank_loan_counts
WHERE loan_count > 1;

-- 3.2
WITH state_avg_term AS (
    SELECT State, AVG(Term) AS avg_term
    FROM loan_data
    GROUP BY State
)
SELECT State, avg_term
FROM state_avg_term
ORDER BY avg_term DESC
LIMIT 3;

-- 3.3
WITH city_avg_term AS (
    SELECT City, AVG(Term) AS avg_term
    FROM loan_data
    GROUP BY City
)
SELECT City
FROM city_avg_term
WHERE avg_term > 120;

-- 3.4
WITH bank_state_count AS (
    SELECT Bank, COUNT(DISTINCT BankState) AS state_count
    FROM loan_data
    GROUP BY Bank
)
SELECT Bank
FROM bank_state_count
WHERE state_count >= 3;

-- 3.5
WITH naics_avg_term AS (
    SELECT NAICS, AVG(Term) AS avg_term
    FROM loan_data
    GROUP BY NAICS
)
SELECT NAICS
FROM naics_avg_term
WHERE avg_term > 90;

-- 4. Aggregate window functions
-- 4.1
SELECT State, COUNT(*) AS loan_count,
       SUM(COUNT(*)) OVER (ORDER BY COUNT(*) DESC) AS running_total
FROM loan_data
GROUP BY State
ORDER BY loan_count DESC;

-- 4.2
SELECT DISTINCT ApprovalFY,
       AVG(Term) OVER (PARTITION BY ApprovalFY) AS avg_term_per_year
FROM loan_data;

-- 4.3
SELECT DISTINCT BankState,
       MAX(ApprovalFY) OVER (PARTITION BY BankState) AS max_loan_amount
FROM loan_data;

-- 4.4
SELECT DISTINCT Bank,
       AVG(Term) OVER (PARTITION BY Bank) AS avg_term
FROM loan_data;

-- 4.5
SELECT DISTINCT State, Bank,
       COUNT(*) OVER (PARTITION BY State, Bank) AS loan_count,
       AVG(Term) OVER (PARTITION BY State, Bank) AS avg_term
FROM loan_data;

-- 5. Ranking and value window functions
-- 5.1
SELECT Bank, SUM(Term) AS total_loan_amount,
       RANK() OVER (ORDER BY SUM(Term) DESC) AS bank_rank
FROM loan_data
GROUP BY Bank;

-- 5.2
SELECT City, COUNT(*) AS loan_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS city_rank
FROM loan_data
GROUP BY City;

-- 5.3
SELECT Bank, AVG(Term) AS avg_loan_term,
       RANK() OVER (ORDER BY AVG(Term) DESC) AS bank_rank
FROM loan_data
GROUP BY Bank;

-- 5.4
SELECT State, AVG(Term) AS avg_loan_amount,
       RANK() OVER (ORDER BY AVG(Term) DESC) AS state_rank
FROM loan_data
GROUP BY State;

-- 5.5
SELECT NAICS, COUNT(*) AS loan_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS naics_rank
FROM loan_data
GROUP BY NAICS;

-- 6. Tasks combining all of the above
-- 6.1
-- Create a materialized view for average term by approval year
CREATE MATERIALIZED VIEW avg_term_by_approval_year AS
SELECT ApprovalFY, AVG(Term) AS avg_term
FROM loan_data
GROUP BY ApprovalFY;

-- Create a CTE to filter loans with terms above the yearly average
WITH high_term_loans AS (
    SELECT ApprovalFY, LoanNr_ChkDgt, Term
    FROM loan_data
    WHERE Term > (SELECT AVG(avg_term) FROM avg_term_by_approval_year WHERE avg_term_by_approval_year.ApprovalFY = loan_data.ApprovalFY)
)

-- Combine CTE, materialized view, and window function to rank high-term loans within each year
SELECT ApprovalFY, LoanNr_ChkDgt, Term,
       RANK() OVER (PARTITION BY ApprovalFY ORDER BY Term DESC) AS term_rank
FROM high_term_loans;

-- 6.2
-- Find the maximum term among loan applicants with NewExist = 1
SELECT MAX(Term) AS max_term_new_exist
FROM loan_data
WHERE NewExist = 1;

-- Calculate average term of loans for applicants with term greater than max_term_new_exist
WITH avg_term_above_max AS (
    SELECT AVG(Term) AS avg_term
    FROM loan_data
    WHERE Term > (SELECT MAX(Term) FROM loan_data WHERE NewExist = 1)
)
SELECT avg_term
FROM avg_term_above_max;


-- 6.3
-- Find loan applicants with Term greater than 120
WITH long_term_applicants AS (
    SELECT *
    FROM loan_data
    WHERE Term > 120
)
-- Calculate average term for each state among the long-term applicants
SELECT State, AVG(Term) OVER (PARTITION BY State) AS avg_term_per_state
FROM long_term_applicants;

-- 6.4
-- Create a view for loan counts by bank and state
CREATE VIEW loan_counts_by_bank_state AS
SELECT Bank, BankState, COUNT(*) AS loan_count
FROM loan_data
GROUP BY Bank, BankState;

-- Combine sub-query and window function to rank banks by loan count within each state
SELECT Bank, BankState, loan_count,
       RANK() OVER (PARTITION BY BankState ORDER BY loan_count DESC) AS bank_rank
FROM loan_counts_by_bank_state
WHERE Bank IN (
    SELECT Bank
    FROM loan_counts_by_bank_state
    WHERE BankState = 'FL'  -- Choose a state to analyze
);

-- 6.5
WITH avg_emp_by_state AS (
    SELECT State, AVG(NoEmp) AS avg_employees
    FROM loan_data
    GROUP BY State
)
SELECT State, avg_employees,
       RANK() OVER (ORDER BY avg_employees DESC) AS rank_high_avg_emp,
       RANK() OVER (ORDER BY avg_employees ASC) AS rank_low_avg_emp
FROM avg_emp_by_state;

