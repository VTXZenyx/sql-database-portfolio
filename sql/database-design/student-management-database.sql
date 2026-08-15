/*1*/
CREATE TABLE Student (
StudentID TEXT PRIMARY KEY,
Name TEXT,
DateOfBirth TEXT,
Gender TEXT,
Address TEXT,
Email TEXT,
Phone TEXT
);

/*2*/
CREATE TABLE Programme (
ProgrammeID TEXT PRIMARY KEY,
Degree TEXT
);

/*3*/
CREATE TABLE Course_Offering (
CourseNo TEXT,
Year INTEGER,
Title TEXT,
Pts INTEGER,
PRIMARY KEY (CourseNo, Year)
);

/*4*/
CREATE TABLE Student_Programme_Year (
StudentID TEXT,
Year INTEGER,
ProgrammeID TEXT,
PRIMARY KEY (StudentID, Year),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (ProgrammeID) REFERENCES Programme(ProgrammeID)
);

/*5*/
CREATE TABLE Enrolment (
CourseNo TEXT,
StudentID TEXT,
Year INTEGER,
Grade TEXT,
PRIMARY KEY (StudentID, CourseNo, Year),
FOREIGN KEY (CourseNo, Year)
REFERENCES Course_Offering(CourseNo, Year),
FOREIGN KEY (StudentID, Year)
REFERENCES Student_Programme_Year(StudentID, Year),
FOREIGN KEY (StudentID)
REFERENCES Student(StudentID)
);


/* Student */
INSERT INTO Student (StudentID, Name, DateOfBirth, Gender, Address, Email, Phone)
VALUES
('007007','James Bond','07/07/1977','Male',
'10 Downing Street Wellington','JB007@gmail.com','+64 21 123 4567');

/*2) Programmes*/
INSERT INTO Programme (ProgrammeID, Degree) VALUES
('PROG002','Bachelor of Technology'),
('PROG001','Bachelor of Commerce');

/*3) Course offerings (by year; preserves historic titles and points)*/
INSERT INTO Course_Offering (CourseNo, Year, Title, Pts) VALUES
('INF0151',2019,'Databases',15),
('ECOM130',2019,'Microeconomic Principles',15),
('FCOM111',2019,'Government Law and Business',15),
('INF0101',2019,'Foundations of Info Systems',15),
('INF0141',2018,'Systems Analysis',15),
('INF0151',2018,'Databases & SQL',15),
('MGMT101',2018,'Introduction to Management',15),
('QUAN102',2018,'Statistics for Business',15);

/*4) Student’s programme per year*/
INSERT INTO Student_Programme_Year (StudentID, Year, ProgrammeID) VALUES
('007007',2019,'PROG002'),
('007007',2018,'PROG001');

/*5) Enrolments with grades*/
INSERT INTO Enrolment (CourseNo, StudentID, Year, Grade) VALUES
('INF0151','007007',2019,'A+'),
('ECOM130','007007',2019,'A+'),
('FCOM111','007007',2019,'B+'),
('INF0101','007007',2019,'A+'),
('INF0141','007007',2018,'A-'),
('INF0151','007007',2018,'WD'),
('MGMT101','007007',2018,'B+'),
('QUAN102','007007',2018,'A+');


/* Student */
SELECT * FROM Student;

/* Programme */
SELECT * FROM Programme;

/* Course_Offering */
SELECT * FROM Course_Offering ORDER BY Year, CourseNo;

/* Student_Programme_Year */
SELECT * FROM Student_Programme_Year ORDER BY Year;

/* Enrolment */
SELECT * FROM Enrolment ORDER BY Year, CourseNo;


/*Transaction log table */
CREATE TABLE TxnLog (
log_id INTEGER PRIMARY KEY AUTOINCREMENT,
action TEXT,
student_id TEXT,
course_no TEXT,
year INTEGER,
old_grade TEXT,
new_grade TEXT,
ts TEXT DEFAULT current_timestamp
);


/* TCL to update grade for student 007007 in INF0141 from A- to B with logging */
BEGIN TRANSACTION;

/* BEGIN */
INSERT INTO TxnLog(action, student_id, course_no, year)
VALUES ('BEGIN', '007007', 'INF0141', 2018);

/* BEFORE snapshot */
INSERT INTO TxnLog(action, student_id, course_no, year, old_grade)
SELECT 'BEFORE', '007007', 'INF0141', 2018, Grade
FROM Enrolment
WHERE StudentID = '007007'
AND CourseNo = 'INF0141'
AND Year = 2018;

/* Guarded UPDATE */
UPDATE Enrolment
SET Grade = 'B'
WHERE StudentID = '007007'
AND CourseNo = 'INF0141'
AND Year = 2018
AND Grade = 'A-';

/* Verify outcome for marking */
SELECT COUNT(*) AS rows_changed
FROM Enrolment
WHERE StudentID = '007007'
AND CourseNo = 'INF0141'
AND Year = 2018
AND Grade = 'B';

/* AFTER and COMMIT block */
INSERT INTO TxnLog(action, student_id, course_no, year, old_grade, new_grade)
SELECT 'AFTER', '007007', 'INF0141', 2018, 'A-', 'B';

INSERT INTO TxnLog(action, student_id, course_no, year)
VALUES ('COMMIT', '007007', 'INF0141', 2018);

COMMIT;


/*Enrolment check*/
SELECT StudentID, CourseNo, Year, Grade
FROM Enrolment
WHERE StudentID='007007' AND CourseNo='INF0141' AND Year=2018;


/*transaction log*/
SELECT action, old_grade, new_grade, ts
FROM TxnLog
WHERE student_id='007007' AND course_no='INF0141';


SELECT
s.StudentID,
s.Name,
ROUND(
SUM(co.Pts *
CASE e.Grade
WHEN 'A+' THEN 4.0
WHEN 'A' THEN 4.0
WHEN 'A-' THEN 3.7
WHEN 'B+' THEN 3.3
WHEN 'B' THEN 3.0
WHEN 'B-' THEN 2.7
WHEN 'C+' THEN 2.3
WHEN 'C' THEN 2.0
WHEN 'D' THEN 1.0
WHEN 'F' THEN 0.0
ELSE NULL
END
) / SUM(co.Pts)
, 2) AS OverallGPA
FROM Student AS s
JOIN Enrolment AS e
ON e.StudentID = s.StudentID
JOIN Course_Offering AS co
ON co.CourseNo = e.CourseNo
AND co.Year = e.Year
WHERE s.StudentID = '007007'
AND e.Grade <> 'WD'
GROUP BY s.StudentID, s.Name;
