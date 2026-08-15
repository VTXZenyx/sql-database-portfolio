SELECT * 
FROM customers 
WHERE CustomerId BETWEEN 10 AND 30
AND Country NOT IN ('USA', 'Canada')
ORDER BY FirstName DESC;


SELECT *
FROM Customers
WHERE (FirstName LIKE '%a' OR LastName LIKE '_____')
AND Email NOT LIKE '%gmail.com';


SELECT DISTINCT City,  Country 
FROM customers;


SELECT DISTINCT Country,  City 
FROM customers;


SELECT * 
FROM invoices 
WHERE Total NOT BETWEEN 1.99 AND 14.99 
AND BillingState IS NOT NULL 
AND BillingCountry='USA';


SELECT * 
FROM invoices 
WHERE (Total < 1.99 OR Total > 14.99) 
AND BillingState IS NOT NULL 
AND BillingCountry='USA';


SELECT *,  ROUND(Total * 1.13, 1)  AS "Total Include VAT"
FROM 
invoices
WHERE BillingState LIKE '%A%';


SELECT *
FROM customers
WHERE 
  (FirstName LIKE '%s%' AND LastName NOT LIKE '%s%')
  OR
  (FirstName NOT LIKE '%s%' AND LastName LIKE '%s%')
ORDER BY CustomerID ASC;
