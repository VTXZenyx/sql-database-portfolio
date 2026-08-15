SELECT
  mt.Name AS "MediaType Name",
  ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS "Minimum Total Purchase Value",
  SUM(ii.Quantity) AS "Total Number of Purchases"
FROM media_types AS mt
JOIN tracks        AS t  ON t.MediaTypeId = mt.MediaTypeId
JOIN invoice_items AS ii ON ii.TrackId    = t.TrackId
GROUP BY mt.Name
HAVING ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) = (
  SELECT MIN(TotalVal)
  FROM (
    SELECT ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS TotalVal
    FROM media_types AS mt
    JOIN tracks        AS t  ON t.MediaTypeId = mt.MediaTypeId
    JOIN invoice_items AS ii ON ii.TrackId    = t.TrackId
    GROUP BY mt.MediaTypeId
  ) AS sub
);


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


SELECT 
  (SELECT COUNT(*)
   FROM (
     SELECT c.CustomerId, SUM(ii.UnitPrice * ii.Quantity) AS TotalValue
     FROM customers AS c
     JOIN invoices AS i ON c.CustomerId = i.CustomerId
     JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
     GROUP BY c.CustomerId
     HAVING TotalValue > (
       SELECT SUM(ii.UnitPrice * ii.Quantity)
       FROM customers AS c
       JOIN invoices AS i ON c.CustomerId = i.CustomerId
       JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
       WHERE c.FirstName = 'Puja' AND c.LastName = 'Srivastava'
     )
   ) AS sub
  ) AS "Total Number of Customers",
  (SELECT ROUND(SUM(ii.UnitPrice * ii.Quantity), 2)
   FROM customers AS c
   JOIN invoices AS i ON c.CustomerId = i.CustomerId
   JOIN invoice_items AS ii ON i.InvoiceId = ii.InvoiceId
   WHERE c.FirstName = 'Puja' AND c.LastName = 'Srivastava'
  ) AS "Puja Total Purchase Value";
