CREATE DATABASE StepDB
GO

USE StepDB
GO

CREATE TABLE Students(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Age INT CHECK(Age BETWEEN 0 AND 120),
    Email NVARCHAR(100) UNIQUE NOT NULL CHECK(Email LIKE '%@%'),
    StatusIsActive BIT DEFAULT(1)
)

CREATE TABLE Teachers(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    PhoneNumber varchar(50)
)

CREATE TABLE Subjects(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Title NVARCHAR(100) NOT NULL,
    AmountOfHours INT NOT NULL
)
GO

CREATE TABLE StudentSubject(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    StudentId INT NOT NULL,
    SubjectId INT NOT NULL,
    CONSTRAINT FK_Student_Subject_StudentId FOREIGN KEY(StudentId) REFERENCES Students(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Student_Subject_SubjectId FOREIGN KEY(SubjectId) REFERENCES Subjects(Id) ON DELETE CASCADE
)
GO

CREATE TABLE TeacherSubject(
    Id INT PRIMARY KEY IDENTITY (1,1),
    TeacherId INT NOT NULL,
    SubjectId INT NOT NULL,
    CONSTRAINT FK_Teacher_Subject_TeacherId FOREIGN KEY(TeacherId) REFERENCES Teachers(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Teacher_Subject_SubjectId FOREIGN KEY(SubjectId) REFERENCES  Subjects(Id) ON DELETE CASCADE
)
GO


INSERT INTO Students (FirstName, LastName, Age, Email, StatusIsActive)
VALUES
('Giorgi', 'Beridze', 20, 'giorgi.beridze@gmail.com', 1),
('Nino', 'Kapanadze', 21, 'nino.kapanadze@gmail.com', 1),
('Luka', 'Maisuradze', 19, 'luka.maisuradze@gmail.com', 1),
('Ana', 'Gelashvili', 22, 'ana.gelashvili@gmail.com', 1),
('Saba', 'Japaridze', 20, 'saba.japaridze@gmail.com', 1),
('Mariam', 'Kiknadze', 21, 'mariam.kiknadze@gmail.com', 1),
('Dato', 'Chikovani', 23, 'dato.chikovani@gmail.com', 1),
('Salome', 'Tsiklauri', 20, 'salome.tsiklauri@gmail.com', 1),
('Nikoloz', 'Gogoladze', 19, 'nikoloz.gogoladze@gmail.com', 1),
('Tamar', 'Abashidze', 22, 'tamar.abashidze@gmail.com', 1),
('Irakli', 'Lomidze', 24, 'irakli.lomidze@gmail.com', 1),
('Elene', 'Kvaratskhelia', 20, 'elene.kvaratskhelia@gmail.com', 1),
('Sandro', 'Mchedlishvili', 21, 'sandro.mchedlishvili@gmail.com', 1),
('Kristine', 'Dolidze', 19, 'kristine.dolidze@gmail.com', 1),
('Giga', 'Khutsishvili', 23, 'giga.khutsishvili@gmail.com', 0),
('Sophie', 'Nadiradze', 20, 'sophie.nadiradze@gmail.com', 1),
('Andria', 'Kobakhidze', 22, 'andria.kobakhidze@gmail.com', 1),
('Maka', 'Rukhadze', 21, 'maka.rukhadze@gmail.com', 1),
('Levan', 'Kalandadze', 25, 'levan.kalandadze@gmail.com', 0),
('Ketevan', 'Gvasalia', 20, 'ketevan.gvasalia@gmail.com', 1);
GO

INSERT INTO Teachers (FirstName, LastName, PhoneNumber)
VALUES
('Giorgi', 'Tsereteli', '555100001'),
('Natia', 'Maisuradze', '555100002'),
('David', 'Beridze', '555100003'),
('Mariam', 'Kapanadze', '555100004'),
('Irakli', 'Gelashvili', '555100005'),
('Tamar', 'Japaridze', '555100006'),
('Lasha', 'Kiknadze', '555100007'),
('Nino', 'Chikovani', '555100008'),
('Zurab', 'Tsiklauri', '555100009'),
('Ana', 'Gogoladze', '555100010'),
('Sandro', 'Abashidze', '555100011'),
('Elene', 'Lomidze', '555100012'),
('Giga', 'Mchedlishvili', '555100013'),
('Salome', 'Dolidze', '555100014'),
('Vakhtang', 'Khutsishvili', '555100015'),
('Kristine', 'Nadiradze', '555100016'),
('Beka', 'Kobakhidze', '555100017'),
('Maka', 'Rukhadze', '555100018'),
('Levan', 'Kalandadze', '555100019'),
('Ketevan', 'Gvasalia', '555100020');
GO

INSERT INTO Subjects (Title, AmountOfHours)
VALUES
('Database Administration', 60),
('Web Development', 72),
('Artificial Intelligence', 64),
('Programming Fundamentals', 80),
('Computer Networks', 56);
GO

INSERT INTO StudentSubject (StudentId, SubjectId)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(3, 4),
(4, 1),
(4, 5),
(5, 2),
(5, 3),
(6, 3),
(6, 4),
(7, 1),
(7, 4),
(8, 2),
(8, 5),
(9, 3),
(9, 5),
(10, 1),
(10, 2),
(11, 4),
(11, 5),
(12, 2),
(12, 3),
(13, 1),
(13, 5),
(14, 3),
(14, 4),
(15, 1),
(15, 4),
(16, 2),
(16, 5),
(17, 3),
(17, 4);
GO

INSERT INTO TeacherSubject (TeacherId, SubjectId)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
GO


------------------------------------

-------------------- N1

USE StepDB
GO

SELECT st.FirstName + ' ' + st.LastName AS FullName, subj.Title FROM StudentSubject AS st_subj
INNER JOIN Students AS st ON st_subj.StudentId = st.Id
INNER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id;
GO


-------------------- N2

SELECT t.FirstName + ' ' + t.LastName AS FullName, subj.Title FROM TeacherSubject AS t_subj
INNER JOIN Teachers AS t ON t_subj.TeacherId = t.Id
INNER JOIN Subjects AS subj ON t_subj.SubjectId = subj.Id
GO


-------------------- N3

SELECT st.FirstName + ' ' + st.LastName AS Fullname, st.Age, subj.Title FROM StudentSubject AS st_subj
INNER JOIN Students AS st ON st_subj.StudentId = st.Id
INNER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
WHERE st.StatusIsActive = 1
GO


-------------------- N4

SELECT st.Id, st.FirstName + ' ' +  st.LastName AS FullName, subj.Title FROM Students AS st
LEFT JOIN StudentSubject AS st_subj ON st.Id = st_subj.StudentId
LEFT JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
GO


-------------------- N5

SELECT subj.Title, st.FirstName + ' ' + st.LastName AS FullName FROM Subjects AS subj
LEFT JOIN StudentSubject AS st_subj ON subj.Id = st_subj.SubjectId
LEFT JOIN Students AS st ON st_subj.StudentId = st.Id
GO


-------------------- N6

SELECT st.FirstName + ' ' + st.LastName AS Student_FullName,
       subj.Title,
       t.FirstName + ' ' + t.LastName AS Teacher_FullName
FROM Students AS st
INNER JOIN  StudentSubject AS st_subj ON st.Id = st_subj.StudentId
INNER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
INNER JOIN TeacherSubject AS t_subj ON subj.Id = t_subj.SubjectId
INNER JOIN Teachers AS t ON t_subj.TeacherId = t.Id
GO


-------------------- N7

SELECT t.FirstName + ' ' + t.LastName AS FullName, subj.Title, subj.AmountOfHours FROM Teachers AS t
LEFT JOIN TeacherSubject AS t_subj ON t.Id = t_subj.TeacherId
LEFT JOIN Subjects AS subj ON t_subj.SubjectId = subj.Id
GO


-------------------- N8

SELECT st.FirstName + ' ' + st.LastName AS Student_FullName,
       st.Age, st.Email,
       subj.Title, subj.AmountOfHours
FROM Students AS st
INNER JOIN StudentSubject AS st_subj ON st.Id = st_subj.StudentId
INNER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
WHERE subj.Title = 'Programming Fundamentals'
GO


-------------------- N9

SELECT st.FirstName + ' ' + st.LastName AS Student_FullName, subj.Title FROM Students AS st
FULL OUTER JOIN StudentSubject AS st_subj ON st.Id = st_subj.StudentId
FULL OUTER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
GO


-------------------- N10

SELECT st.FirstName + ' ' + st.LastName AS Student_FullName,
       st.Age, subj.Title, subj.AmountOfHours,
       t.FirstName + ' ' + t.LastName AS Teacher_FullName
FROM Students AS st
INNER JOIN StudentSubject AS st_subj ON st.Id = st_subj.StudentId
INNER JOIN Subjects AS subj ON st_subj.SubjectId = subj.Id
INNER JOIN TeacherSubject AS t_subj ON subj.Id = t_subj.SubjectId
INNER JOIN Teachers AS t ON t_subj.TeacherId = t.Id
WHERE st.StatusIsActive = 1 AND subj.AmountOfHours > 50
ORDER BY subj.AmountOfHours DESC
GO


-------------------- BONUS

SELECT t.FirstName + ' ' + t.LastName AS Teacher_FullName, subj.Title, COUNT(st_subj.StudentId) AS StudentCount
FROM Teachers AS t
INNER JOIN TeacherSubject AS t_subj ON t.Id = t_subj.TeacherId
INNER JOIN Subjects AS subj ON t_subj.SubjectId = subj.Id
INNER JOIN StudentSubject AS st_subj ON subj.Id = st_subj.SubjectId
INNER JOIN Students AS st ON st_subj.StudentId = st.Id
GROUP BY t.FirstName, t.LastName, subj.Title
GO
