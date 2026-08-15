-- ============================================================
-- SUBQUERIES & ADVANCED SQL
-- Selected examples from my database coursework
-- Tool: DB Browser for SQLite
-- ============================================================

-- Media type with the minimum total purchase value
SELECT
    mt.Name AS "MediaType Name",
    ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS "Minimum Total Purchase Value",
    SUM(ii.Quantity) AS "Total Number of Purchases"
FROM media_types AS mt
JOIN tracks AS t ON t.MediaTypeId = mt.MediaTypeId
JOIN invoice_items AS ii ON ii.TrackId = t.TrackId
GROUP BY mt.Name
HAVING ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) = (
    SELECT MIN(TotalVal)
    FROM (
        SELECT ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS TotalVal
        FROM media_types AS mt
        JOIN tracks AS t ON t.MediaTypeId = mt.MediaTypeId
        JOIN invoice_items AS ii ON ii.TrackId = t.TrackId
        GROUP BY mt.MediaTypeId
    ) AS sub
);

-- Derived-table version returning only the media type name
SELECT "MediaType Name"
FROM (
    SELECT mt.Name AS "MediaType Name",
           ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS "Minimum Total Purchase Value",
           SUM(ii.Quantity) AS "Total Number of Purchase"
    FROM media_types AS mt
    JOIN tracks AS t ON t.MediaTypeId = mt.MediaTypeId
    JOIN invoice_items AS ii ON ii.TrackId = t.TrackId
    GROUP BY mt.Name
    HAVING "Minimum Total Purchase Value" = (
        SELECT MIN(TotalVal)
        FROM (
            SELECT ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS TotalVal
            FROM media_types AS mt
            JOIN tracks AS t ON t.MediaTypeId = mt.MediaTypeId
            JOIN invoice_items AS ii ON ii.TrackId = t.TrackId
            GROUP BY mt.MediaTypeId
        ) AS sub
    )
) AS final;

-- Compare customer purchase totals with Puja Srivastava
SELECT
    (
        SELECT COUNT(*)
        FROM (
            SELECT c.CustomerId,
                   SUM(ii.UnitPrice * ii.Quantity) AS TotalValue
            FROM customers AS c
            JOIN invoices AS i ON c.CustomerId = i.CustomerId
            JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
            GROUP BY c.CustomerId
            HAVING TotalValue > (
                SELECT SUM(ii.UnitPrice * ii.Quantity)
                FROM customers AS c
                JOIN invoices AS i ON c.CustomerId = i.CustomerId
                JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
                WHERE c.FirstName = 'Puja'
                  AND c.LastName = 'Srivastava'
            )
        ) AS sub
    ) AS "Total Number of Customers",
    (
        SELECT ROUND(SUM(ii.UnitPrice * ii.Quantity), 2)
        FROM customers AS c
        JOIN invoices AS i ON c.CustomerId = i.CustomerId
        JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
        WHERE c.FirstName = 'Puja'
          AND c.LastName = 'Srivastava'
    ) AS "Puja Total Purchase Value";

-- Students with no participation records
SELECT StudentID, FirstName, LastName
FROM Roll
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM Participation
);

-- Thursday and Friday participation counts
SELECT
   (SELECT COUNT(DISTINCT StudentID)
    FROM Participation
    WHERE STRFTIME('%w', TimeStamp) = '4') AS "Thursday Class",
   (SELECT COUNT(DISTINCT StudentID)
    FROM Participation
    WHERE STRFTIME('%w', TimeStamp) = '5') AS "Friday Class";

-- Correlated subquery UPDATE
UPDATE Roll
SET Status = (
    SELECT COUNT(*)
    FROM Participation AS p
    WHERE p.StudentID = Roll.StudentID
);

-- Self join to find overlapping passenger journeys
SELECT
  A.PassengerID AS "A_PassengerID",
  B.PassengerID AS "B_PassengerID",
  A.Date AS "Date",
  A.RouteNum AS "RouteNum",
  A.TIMEIN AS "A_TimeIN",
  A.TIMEOUT AS "A_TimeOut",
  B.TIMEIN AS "B_TimeIN"
FROM Transport AS A
JOIN Transport AS B
  ON A.BusID = B.BusID
 AND A.RouteNum = B.RouteNum
 AND A.Date = B.Date
 AND A.PassengerID < B.PassengerID
 AND B.TIMEIN >= A.TIMEIN
 AND B.TIMEIN <= A.TIMEOUT
WHERE STRFTIME('%w', A.Date) = '3';

-- Department reassignment using a subquery in UPDATE
UPDATE Work
SET DeptID = (
    SELECT d2.DeptID
    FROM Department AS d2
    WHERE (Work.Percent_Time = 100 AND d2.DeptName = 'Software')
       OR (Work.Percent_Time < 100 AND d2.DeptName = 'Production')
)
WHERE DeptID = (
    SELECT DeptID
    FROM Department
    WHERE DeptName = 'Hardware'
);
