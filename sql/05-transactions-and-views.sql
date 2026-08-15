-- ============================================================
-- TRANSACTIONS, ACID & VIEWS
-- Selected examples from my database coursework
-- Tool: DB Browser for SQLite
-- ============================================================

-- Transaction log table
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

-- Transaction example: update grade with before/after logging
BEGIN TRANSACTION;

INSERT INTO TxnLog(action, student_id, course_no, year)
VALUES ('BEGIN', '007007', 'INF0141', 2018);

INSERT INTO TxnLog(action, student_id, course_no, year, old_grade)
SELECT 'BEFORE', '007007', 'INF0141', 2018, Grade
FROM Enrolment
WHERE StudentID = '007007'
  AND CourseNo = 'INF0141'
  AND Year = 2018;

UPDATE Enrolment
SET Grade = 'B'
WHERE StudentID = '007007'
  AND CourseNo = 'INF0141'
  AND Year = 2018
  AND Grade = 'A-';

SELECT COUNT(*) AS rows_changed
FROM Enrolment
WHERE StudentID = '007007'
  AND CourseNo = 'INF0141'
  AND Year = 2018
  AND Grade = 'B';

INSERT INTO TxnLog(action, student_id, course_no, year, old_grade, new_grade)
SELECT 'AFTER', '007007', 'INF0141', 2018, 'A-', 'B';

INSERT INTO TxnLog(action, student_id, course_no, year)
VALUES ('COMMIT', '007007', 'INF0141', 2018);

COMMIT;

-- Verify the updated enrolment
SELECT StudentID, CourseNo, Year, Grade
FROM Enrolment
WHERE StudentID = '007007'
  AND CourseNo = 'INF0141'
  AND Year = 2018;

-- Check transaction log
SELECT action, old_grade, new_grade, ts
FROM TxnLog
WHERE student_id = '007007'
  AND course_no = 'INF0141';

-- GPA calculation
SELECT
    s.StudentID,
    s.Name,
    ROUND(
        SUM(
            co.Pts *
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
        ) / SUM(co.Pts),
        2
    ) AS OverallGPA
FROM Student AS s
JOIN Enrolment AS e
    ON e.StudentID = s.StudentID
JOIN Course_Offering AS co
    ON co.CourseNo = e.CourseNo
   AND co.Year = e.Year
WHERE s.StudentID = '007007'
  AND e.Grade <> 'WD'
GROUP BY s.StudentID, s.Name;

-- View for StudyGroup messages containing media
CREATE VIEW v_studygroup_media AS
SELECT
    c.chat_id,
    m.message_time,
    u.sender_name,
    m.message_text,
    m.media_type,
    m.media_name,
    g.group_name
FROM Message AS m
JOIN Chat AS c ON c.chat_id = m.chat_id
JOIN "Group" AS g ON g.group_id = c.group_id
JOIN "User" AS u ON u.sender_phone = m.sender_phone
WHERE g.group_name = 'StudyGroup'
  AND m.media_type IS NOT NULL
ORDER BY m.message_time;

SELECT *
FROM v_studygroup_media;
