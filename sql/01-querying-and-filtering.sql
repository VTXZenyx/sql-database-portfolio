-- ============================================================
-- SQL QUERYING & FILTERING
-- Selected examples from my database coursework
-- Tool: DB Browser for SQLite
-- ============================================================

-- Customer filtering with BETWEEN, NOT IN and ORDER BY
SELECT *
FROM customers
WHERE CustomerId BETWEEN 10 AND 30
  AND Country NOT IN ('USA', 'Canada')
ORDER BY FirstName DESC;

-- Pattern matching and logical operator precedence
SELECT *
FROM Customers
WHERE (FirstName LIKE '%a' OR LastName LIKE '_____')
  AND Email NOT LIKE '%gmail.com';

-- DISTINCT combinations
SELECT DISTINCT City, Country
FROM customers;

SELECT DISTINCT Country, City
FROM customers;

-- NOT BETWEEN compared with equivalent logical conditions
SELECT *
FROM invoices
WHERE Total NOT BETWEEN 1.99 AND 14.99
  AND BillingState IS NOT NULL
  AND BillingCountry = 'USA';

SELECT *
FROM invoices
WHERE (Total < 1.99 OR Total > 14.99)
  AND BillingState IS NOT NULL
  AND BillingCountry = 'USA';

-- Calculated column using ROUND
SELECT *,
       ROUND(Total * 1.13, 1) AS "Total Include VAT"
FROM invoices
WHERE BillingState LIKE '%A%';

-- Logical XOR-style condition:
-- first or last name contains "s", but not both
SELECT *
FROM customers
WHERE
    (FirstName LIKE '%s%' AND LastName NOT LIKE '%s%')
    OR
    (FirstName NOT LIKE '%s%' AND LastName LIKE '%s%')
ORDER BY CustomerID ASC;

-- Modulus idea used to inspect numeric IDs ending in 7:
-- InvoiceId % 10 = 7
