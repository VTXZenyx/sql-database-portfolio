CREATE TABLE Roll
(
    StudentID  TEXT PRIMARY KEY,
    FirstName  TEXT NOT NULL,
    LastName   TEXT NOT NULL
);

CREATE TABLE Participation
(
    StudentID  TEXT NOT NULL,
    TimeStamp  TEXT NOT NULL,
    Mode       TEXT,
    PRIMARY KEY (StudentID, TimeStamp),
    FOREIGN KEY (StudentID) REFERENCES Roll(StudentID)
);


INSERT INTO Roll (StudentID, FirstName, LastName)
VALUES
('S001', 'John', 'Doe'),
('S002', 'Jane', 'Smith'),
('S003', 'Michael', 'Brown'),
('S004', 'Emily', 'Davis'),
('S005', 'Daniel', 'Wilson'),
('S006', 'Sophia', 'Taylor'),
('S007', 'James', 'Anderson'),
('S008', 'Olivia', 'Thomas'),
('S009', 'Liam', 'Jackson'),
('S010', 'Isabella', 'White');


INSERT INTO Participation (StudentID, TimeStamp, Mode)
VALUES
('S001', '2024-09-01 09:00:00', 'In-Person'),
('S002', '2024-09-01 09:05:00', 'Online'),
('S003', '2024-09-01 09:10:00', 'In-Person'),
('S004', '2024-09-02 10:00:00', 'In-Person'),
('S005', '2024-09-02 10:15:00', 'Online'),
('S001', '2024-09-03 11:00:00', 'Online'),
('S003', '2024-09-03 11:10:00', 'In-Person'),
('S006', '2024-09-04 12:00:00', 'In-Person'),
('S002', '2024-09-04 12:20:00', 'Online'),
('S007', '2024-09-05 13:00:00', 'Online');


SELECT StudentID, FirstName, LastName
FROM Roll
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM Participation
);


SELECT 
   (SELECT COUNT(DISTINCT StudentID)
    FROM Participation
    WHERE STRFTIME('%w', TimeStamp) = '4') AS "Thursday Class",
   (SELECT COUNT(DISTINCT StudentID)
    FROM Participation
    WHERE STRFTIME('%w', TimeStamp) = '5') AS "Friday Class";


ALTER TABLE Roll
ADD COLUMN Status TEXT;


UPDATE Roll
SET Status = (
  SELECT COUNT(*)
  FROM Participation AS p
  WHERE p.StudentID = Roll.StudentID
);
