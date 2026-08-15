SELECT COUNT(*) AS 'Employee without a certificate'
FROM Employee e
LEFT JOIN Certificate c ON e.eid = c.eid
WHERE c.eid IS NULL;


SELECT COUNT(DISTINCT e.eid) AS 'Number of pilots qualified to operate aircraft listed in the
 Flight table'
FROM Employee e
JOIN Certificate c ON e.eid = c.eid
JOIN Flight f ON c.aid = f.aid;
