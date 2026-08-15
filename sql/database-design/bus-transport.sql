CREATE TABLE BusReg
(
    BusID   INTEGER PRIMARY KEY AUTOINCREMENT,
    RegNum  TEXT,
    WOF     TEXT
);

CREATE TABLE Passenger
(
    PassengerID     INTEGER PRIMARY KEY,
    PassengerFName  TEXT,
    PassengerLName  TEXT,
    Email           TEXT,
    Mobile          TEXT
);

CREATE TABLE Transport
(
    BusID       INTEGER,
    RouteNum    INTEGER,
    Date        TEXT,
    PassengerID INTEGER,
    TIMEIN      TEXT,
    TIMEOUT     TEXT,
    PRIMARY KEY (BusID, Date, PassengerID, TIMEIN),
    FOREIGN KEY (BusID) REFERENCES BusReg(BusID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);


INSERT INTO BusReg (BusID, RegNum, WOF)
VALUES
(1, 'XZ123456', '2020-05-10'),
(2, 'ZC321546', '2020-01-01'),
(3, 'XC432234', '2020-03-01');

INSERT INTO Passenger (PassengerID, PassengerFName, PassengerLName, Email, Mobile)
VALUES
(1, 'Jim', 'Richard', 'jim.Richard@gmail.com', '0223989876'),
(2, 'Kim', 'Ng', 'kim.ng@gmail.com', '0226758907'),
(3, 'Elsie', 'Alison', 'Elsie.Alison@gmail.com', '0227899876');

INSERT INTO Transport (BusID, RouteNum, Date, PassengerID, TIMEIN, TIMEOUT)
VALUES
(1, 22, '2020-05-05', 1, '09:00', '09:40'),
(1, 22, '2020-05-05', 1, '11:00', '12:15'),
(1, 22, '2020-05-05', 2, '09:30', '09:55'),
(1, 22, '2020-05-05', 2, '12:00', '13:33'),
(1, 22, '2020-05-05', 3, '11:07', '12:05'),
(2, 54, '2020-05-06', 1, '14:00', '15:00'),
(2, 54, '2020-05-06', 2, '14:45', '15:55'),
(3, 3,  '2020-05-07', 3, '09:00', '10:45');


SELECT
  A.PassengerID AS "A_PassengerID",
  B.PassengerID AS "B_PassengerID",
  A.Date        AS "Date",
  A.RouteNum    AS "RouteNum",
  A.TIMEIN      AS "A_TimeIN",
  A.TIMEOUT     AS "A_TimeOut",
  B.TIMEIN      AS "B_TimeIN"
FROM Transport AS A
JOIN Transport AS B
  ON A.BusID     = B.BusID
 AND A.RouteNum  = B.RouteNum
 AND A.Date      = B.Date
 AND A.PassengerID < B.PassengerID
 AND B.TIMEIN    >= A.TIMEIN
 AND B.TIMEIN    <= A.TIMEOUT
WHERE STRFTIME('%w', A.Date) = '3';
