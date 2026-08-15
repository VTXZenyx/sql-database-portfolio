-- ============================================================
-- DATABASE DESIGN & DDL
-- Selected examples from my database coursework
-- Tool: DB Browser for SQLite
-- ============================================================

-- Roll / Participation relational design
CREATE TABLE Roll
(
    StudentID TEXT PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL
);

CREATE TABLE Participation
(
    StudentID TEXT NOT NULL,
    TimeStamp TEXT NOT NULL,
    Mode TEXT,
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

ALTER TABLE Roll
ADD COLUMN Status TEXT;

-- Bus / Passenger / Transport many-to-many design
CREATE TABLE BusReg
(
    BusID INTEGER PRIMARY KEY AUTOINCREMENT,
    RegNum TEXT,
    WOF TEXT
);

CREATE TABLE Passenger
(
    PassengerID INTEGER PRIMARY KEY,
    PassengerFName TEXT,
    PassengerLName TEXT,
    Email TEXT,
    Mobile TEXT
);

CREATE TABLE Transport
(
    BusID INTEGER,
    RouteNum INTEGER,
    Date TEXT,
    PassengerID INTEGER,
    TIMEIN TEXT,
    TIMEOUT TEXT,
    PRIMARY KEY (BusID, Date, PassengerID, TIMEIN),
    FOREIGN KEY (BusID) REFERENCES BusReg(BusID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Normalised student management database
CREATE TABLE Student (
    StudentID TEXT PRIMARY KEY,
    Name TEXT,
    DateOfBirth TEXT,
    Gender TEXT,
    Address TEXT,
    Email TEXT,
    Phone TEXT
);

CREATE TABLE Programme (
    ProgrammeID TEXT PRIMARY KEY,
    Degree TEXT
);

CREATE TABLE Course_Offering (
    CourseNo TEXT,
    Year INTEGER,
    Title TEXT,
    Pts INTEGER,
    PRIMARY KEY (CourseNo, Year)
);

CREATE TABLE Student_Programme_Year (
    StudentID TEXT,
    Year INTEGER,
    ProgrammeID TEXT,
    PRIMARY KEY (StudentID, Year),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ProgrammeID) REFERENCES Programme(ProgrammeID)
);

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

-- Normalised messaging database
CREATE TABLE "Group" (
    group_id TEXT PRIMARY KEY,
    group_name TEXT
);

CREATE TABLE Chat (
    chat_id TEXT PRIMARY KEY,
    group_id TEXT,
    chat_type TEXT,
    FOREIGN KEY (group_id) REFERENCES "Group"(group_id)
);

CREATE TABLE "User" (
    sender_phone TEXT PRIMARY KEY,
    sender_name TEXT
);

CREATE TABLE Receiver (
    receiver_id TEXT PRIMARY KEY,
    receiver_name TEXT
);

CREATE TABLE Message (
    chat_id TEXT,
    message_time TEXT,
    receiver_id TEXT,
    sender_phone TEXT,
    message_text TEXT,
    media_type TEXT,
    media_name TEXT,
    PRIMARY KEY (chat_id, message_time),
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (receiver_id) REFERENCES Receiver(receiver_id),
    FOREIGN KEY (sender_phone) REFERENCES "User"(sender_phone)
);

-- Schema extension for group membership
CREATE TABLE Group_Member (
    group_id TEXT,
    sender_phone TEXT,
    join_date TEXT DEFAULT current_timestamp,
    PRIMARY KEY (group_id, sender_phone),
    FOREIGN KEY (group_id) REFERENCES "Group"(group_id),
    FOREIGN KEY (sender_phone) REFERENCES "User"(sender_phone)
);
