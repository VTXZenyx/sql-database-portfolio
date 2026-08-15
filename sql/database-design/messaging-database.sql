/* 1) GROUP */
CREATE TABLE "Group" (
group_id TEXT PRIMARY KEY,
group_name TEXT
);

/* 2) CHAT */
CREATE TABLE Chat (
chat_id TEXT PRIMARY KEY,
group_id TEXT,
chat_type TEXT,
FOREIGN KEY (group_id) REFERENCES "Group"(group_id)
);

/* 3) USER */
CREATE TABLE "User" (
sender_phone TEXT PRIMARY KEY,
sender_name TEXT
);

/* 4) RECEIVER */
CREATE TABLE Receiver (
receiver_id TEXT PRIMARY KEY,
receiver_name TEXT
);

/* 5) MESSAGE */
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


BEGIN TRANSACTION;

/* GROUP */
INSERT INTO "Group"(group_id, group_name) VALUES ('G202','Group1');
INSERT INTO "Group"(group_id, group_name) VALUES ('G303','StudyGroup');

/* CHAT */
INSERT INTO Chat(chat_id, group_id, chat_type) VALUES ('C101', NULL, 'individual');
INSERT INTO Chat(chat_id, group_id, chat_type) VALUES ('C202', 'G202','group');
INSERT INTO Chat(chat_id, group_id, chat_type) VALUES ('C303', 'G303','group');

/* USER */
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+1234567890','Alice');
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+1987654321','Bob');
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+1111111111','Charlie');
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+3333333333','David');
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+4444444444','Emma');
INSERT INTO "User"(sender_phone, sender_name) VALUES ('+5555555555','Frank');

/* RECEIVER */
INSERT INTO Receiver(receiver_id, receiver_name) VALUES ('+1987654321','Bob');
INSERT INTO Receiver(receiver_id, receiver_name) VALUES ('+1234567890','Alice');
INSERT INTO Receiver(receiver_id, receiver_name) VALUES ('G202','Group1');
INSERT INTO Receiver(receiver_id, receiver_name) VALUES ('G303','StudyGroup');

/* MESSAGE */
INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C101','2023-10-21 09:15:05','+1987654321','+1234567890','Hey, how are you?',
NULL, NULL);

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C101','2023-10-21 09:17:10','+1234567890','+1987654321','I''m fine, thanks', NULL,
NULL);

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C202','2023-10-21 10:00:15','G202','+1111111111','Meeting at 5 pm', NULL, NULL);

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C202','2023-10-21 10:05:20','G202','+3333333333','Sending file','image','notes.png');

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C202','2023-10-21 10:10:30','G202','+4444444444','Sure, see you', NULL, NULL);

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C303','2023-10-22 14:00:45','G303','+1234567890','Let''s start', NULL, NULL);

INSERT INTO Message(chat_id, message_time, receiver_id, sender_phone, message_text,
media_type, media_name)
VALUES ('C303','2023-10-22 14:05:50','G303','+5555555555','Check this
out','video','lecture.mp4');

COMMIT;


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


CREATE TABLE Group_Member (
group_id TEXT,
sender_phone TEXT,
join_date TEXT DEFAULT current_timestamp,
PRIMARY KEY (group_id, sender_phone),
FOREIGN KEY (group_id) REFERENCES "Group"(group_id),
FOREIGN KEY (sender_phone) REFERENCES "User"(sender_phone)
);
