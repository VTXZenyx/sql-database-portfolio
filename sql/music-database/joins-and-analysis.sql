SELECT  a.Name AS "Artist Name",
 COUNT(al.AlbumId) AS "Total Albums Released"
FROM artists a
LEFT JOIN albums al ON a.ArtistId = al.ArtistId
GROUP BY a.ArtistId, a.Name
HAVING COUNT(al.AlbumId) < 6
ORDER BY "Total Albums Released" DESC
LIMIT 20;


SELECT al.AlbumId,
ar.Name AS "Artist Name",
al.Title AS "Album Title",
COUNT(t.TrackId) AS "Total Number of Track",
SUM(t.UnitPrice) AS "Total Price"
FROM albums al
JOIN artists ar ON al.ArtistId = ar.ArtistId
LEFT JOIN tracks t ON al.AlbumId = t.AlbumId
WHERE ar.Name LIKE 'L%' 
GROUP BY al.AlbumId, ar.Name, al.Title
HAVING SUM(t.UnitPrice) > 40
ORDER BY COUNT(t.TrackId) DESC;


SELECT c.FirstName || ', ' || c.LastName AS "Full Name",
       t.Name AS "Track Name",
       DATE(i.InvoiceDate) AS "Date"
FROM customers c
JOIN invoices i ON c.CustomerId = i.CustomerId
JOIN invoice_items ii ON i.InvoiceId = ii.InvoiceId
JOIN tracks t ON ii.TrackId = t.TrackId
JOIN genres g ON t.GenreId = g.GenreId
JOIN media_types m ON t.MediaTypeId = m.MediaTypeId
WHERE g.Name = 'Pop'
  AND m.Name = 'MPEG audio file'
  AND DATE(i.InvoiceDate) > '2010-01-01'
ORDER BY DATE(i.InvoiceDate) ASC;


SELECT
 c.Country,
 COUNT(DISTINCT c.CustomerId) AS "Number of Customers",
 COUNT(DISTINCT i.InvoiceId) AS "Number of Invoices",
 ROUND(SUM(i.Total), 2) AS "Total Purchase Value",
 ROUND(SUM(i.Total) / COUNT(DISTINCT c.CustomerId), 2)
 AS "Purchase Value PerCustomer"
FROM customers c
LEFT JOIN invoices i
ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY "Purchase Value PerCustomer" DESC;


SELECT DISTINCT
  c.FirstName || ', ' || c.LastName AS "Full Name",
  i.InvoiceId,
  3  AS "TrackId#1",
  9  AS "TrackId#2",
  15 AS "TrackId#3"
FROM customers c
JOIN invoices i
  ON i.CustomerId = c.CustomerId
JOIN invoice_items ii1
  ON ii1.InvoiceId = i.InvoiceId AND ii1.TrackId = 3
JOIN invoice_items ii2
  ON ii2.InvoiceId = i.InvoiceId AND ii2.TrackId = 9
JOIN invoice_items ii3
  ON ii3.InvoiceId = i.InvoiceId AND ii3.TrackId = 15
ORDER BY i.InvoiceId;
