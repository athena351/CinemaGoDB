CREATE DATABASE HotelDB
GO

USE HotelDB
GO

CREATE TABLE Customers(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
)
GO

CREATE TABLE Hotels(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Name NVARCHAR(100) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    RoomCount INT NOT NULL
)
GO

CREATE TABLE Rooms(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    RoomNumber INT NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT(1),
    HotelId INT NOT NULL FOREIGN KEY REFERENCES dbo.Hotels(Id),
)
GO

CREATE TABLE Bookings(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    CustomerId INT NOT NULL FOREIGN KEY REFERENCES dbo.Customers(Id),
    RoomId INT NOT NULL FOREIGN KEY REFERENCES dbo.Rooms(Id),
    CheckInDate DATETIME NOT NULL,
    CheckOutDate DATETIME NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK(Price > 0)
)
GO

CREATE TABLE Payments(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    BookingId INT NOT NULL FOREIGN KEY REFERENCES dbo.Bookings(Id),
    Amount DECIMAL(10, 2) NOT NULL CHECK(AMOUNT >= 0),
    PaymentDate DATETIME NOT NULL
)
GO




USE HotelDB;
GO

INSERT INTO Customers (FirstName, LastName, Email)
VALUES
('Giorgi', 'Beridze', 'giorgi@gmail.com'),
('Nino', 'Kapanadze', 'nino@gmail.com'),
('Ana', 'Maisuradze', 'ana@gmail.com'),
('Luka', 'Gelashvili', 'luka@gmail.com'),
('Mariam', 'Dolidze', 'mariam@gmail.com');
GO


INSERT INTO Hotels (Name, City, RoomCount)
VALUES
('Grand Hotel', 'Tbilisi', 3),
('Sea View', 'Batumi', 3),
('Mountain Resort', 'Gudauri', 2),
('City Inn', 'Kutaisi', 2);
GO


INSERT INTO Rooms (RoomNumber, IsAvailable, HotelId)
VALUES
(101, 0, 1),
(102, 0, 1),
(103, 1, 1),
(201, 0, 2),
(202, 1, 2),
(203, 1, 2),
(301, 0, 3),
(302, 1, 3),
(401, 1, 4),
(402, 1, 4);
GO


INSERT INTO Bookings
    (CustomerId, RoomId, CheckInDate, CheckOutDate, Price)
VALUES
(1, 1, '2026-01-10', '2026-01-12', 300),
(1, 2, '2026-02-05', '2026-02-08', 600),
(2, 4, '2026-03-10', '2026-03-12', 500),
(2, 1, '2026-04-01', '2026-04-03', 300),
(3, 7, '2026-05-10', '2026-05-14', 1600),
(1, 4, '2026-06-01', '2026-06-04', 750);
GO


INSERT INTO Payments (BookingId, Amount, PaymentDate)
VALUES
(1, 300, '2026-01-10'),
(2, 300, '2026-02-05'),
(2, 300, '2026-02-06'),
(3, 500, '2026-03-10'),
(4, 300, '2026-04-01'),
(5, 1000, '2026-05-10'),
(5, 600, '2026-05-11'),
(6, 750, '2026-06-01');
GO


-------------------------------------------------


------------- N1

SELECT c.FirstName, c.LastName, COUNT(b.Id) AS BookingCount FROM Customers c
LEFT JOIN Bookings b ON c.Id = b.CustomerId
GROUP BY c.Id, c.FirstName, c.LastName
ORDER BY BookingCount DESC


------------- N2

SELECT TOP 1 WITH TIES h.Name AS HotelName, COUNT(b.Id) AS BookingCount FROM Hotels h
JOIN Rooms r ON h.Id = r.HotelId
JOIN Bookings b ON r.Id = b.RoomId
GROUP BY h.Name
ORDER BY BookingCount DESC


------------- N3

SELECT r.RoomNumber, h.Name AS HotelName FROM Rooms r
JOIN Hotels h ON r.HotelId = h.Id
LEFT JOIN Bookings b ON r.Id = b.RoomId
WHERE b.Id IS NULL


------------- N4

SELECT c.FirstName, c.LastName, COALESCE(SUM(p.Amount), 0) AS TotalSpent FROM Customers c
LEFT JOIN Bookings b ON c.Id = b.CustomerId
LEFT JOIN Payments p ON b.Id = p.BookingId
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC


------------- N5

SELECT TOP 1 c.FirstName, c.LastName,
             h.Name AS HotelName,
             r.RoomNumber,
             b.CheckInDate, b.CheckOutDate, b.Price
FROM Bookings b
JOIN Customers c ON b.CustomerId = c.Id
JOIN Rooms r ON b.RoomId = r.Id
JOIN Hotels h ON r.HotelId = h.Id
ORDER BY b.Price DESC


------------- N6



SELECT * FROM Hotels h
WHERE h.Id NOT IN (
    SELECT r.HotelId FROM Rooms r
    JOIN Bookings b ON r.Id = b.RoomId
    WHERE b.CheckInDate < '2026-08-31' AND b.CheckOutDate > '2026-07-01'
)













