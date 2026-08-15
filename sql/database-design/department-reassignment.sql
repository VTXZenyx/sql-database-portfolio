UPDATE Work

SET DeptID = (

    SELECT d2.DeptID

    FROM Department AS d2

    WHERE (Work.Percent_Time = 100 AND d2.DeptName = 'Software')

       OR (Work.Percent_Time  < 100 AND d2.DeptName = 'Production')

)

WHERE DeptID = (SELECT DeptID FROM Department WHERE DeptName = 'Hardware');


SELECT w.EmpID, w.DeptID, d.DeptName, w.Percent_Time
FROM Work AS w
JOIN Department AS d ON d.DeptID = w.DeptID
WHERE d.DeptName = 'Hardware'
ORDER BY w.EmpID, w.DeptID;
