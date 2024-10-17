USE loan_manager;

-- 1. CONCAT
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM person;

-- 2. UPPER
SELECT UPPER(name) AS business_name
FROM business;

-- 3. LOWER
SELECT LOWER(mail) AS email_lowercase
FROM person;

-- 4. SUBSTRING
SELECT SUBSTRING(document, 1, 4) AS partial_document
FROM person;

-- 5. LENGTH
SELECT first_name, LENGTH(first_name) AS name_length
FROM person;

-- 6. ROUND
SELECT amount, ROUND(amount, 0) AS rounded_amount
FROM loan;

-- 7. ABS
SELECT loan_id, ABS(estimated_value) AS absolute_value
FROM guarantee;

-- 8. COUNT
SELECT COUNT(*) AS total_loans
FROM loan;

-- 9. SUM
SELECT SUM(amount) AS total_amount
FROM loan;

-- 10. AVG
SELECT AVG(amount) AS average_loan_amount
FROM loan;

-- 11. MIN
SELECT MIN(amount) AS minimum_loan_amount
FROM loan;

-- 12. MAX
SELECT MAX(amount) AS maximum_loan_amount
FROM loan;

-- 13. GROUP BY
SELECT status, COUNT(*) AS count_loans
FROM loan
GROUP BY status;

-- 14. GROUP BY con HAVING
SELECT client_id, COUNT(*) AS loan_count
FROM loan
GROUP BY client_id
HAVING COUNT(*) > 1;
