IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PhantomFestivities')
BEGIN
    CREATE DATABASE PhantomFestivities;
END
GO
USE PhantomFestivities;
GO

-- create tables

CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL
    CHECK (LEN(Username) BETWEEN 3 AND 30),
    CHECK (Username LIKE '[a-zA-Z0-9]%'),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    CHECK (DateOfBirth < GETDATE()),
    Phonenumber VARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    CHECK (Email LIKE '%_@_%._%'),
    Role VARCHAR(10) NOT NULL,
    CHECK (Role IN ('Admin', 'User', 'Guest')),
    Active BIT NOT NULL
);

CREATE TABLE Login (
    LoginID INT PRIMARY KEY IDENTITY(1,1),
    HashedPassword VARCHAR(64) NOT NULL,
    Salt VARCHAR(64) NOT NULL,
    LastLogin DATETIME NOT NULL,
    FailedAttempt INT NOT NULL,
    CHECK (FailedAttempt >= 0),
    UserID INT NOT NULL,
    Active BIT NOT NULL,
    CHECK (Active IN (0,1))
);

CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    Street NVARCHAR(50) NOT NULL,
    CHECK (LEN(Street) <= 50),
    City NVARCHAR(50) NOT NULL,
    CHECK (LEN(City) <= 50),
    Region NVARCHAR(50) NOT NULL
    CHECK (LEN(Region) <= 50),
    Country NVARCHAR(50) NOT NULL
    CHECK (LEN(Country) <= 50),
    Zipcode NVARCHAR(11) NOT NULL
    CHECK (LEN(Zipcode) <= 10),
    UserID INT NOT NULL,
    Active BIT NOT NULL,
    CHECK (Active IN (0,1))
);

CREATE TABLE UserCommunity (
    UserCommunityID INT PRIMARY KEY IDENTITY(1,1),
    JoinDate DATE NOT NULL,
    Role VARCHAR(20) NOT NULL
    CHECK (LEN(Role) <= 20),
    UserID INT NOT NULL,
    CommunityID INT NOT NULL,
    Active BIT NOT NULL,
    CHECK (Active IN (0,1))
);

CREATE TABLE Community (
    CommunityID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    CHECK (LEN(Name) <= 300),
    Description NVARCHAR(500) NOT NULL,
    CHECK (LEN(Description) <= 500),
    CreatedDate DATE NOT NULL,
    CHECK (CreatedDate <= GETDATE()),
    CreatedBy NVARCHAR(50) NOT NULL
    CHECK (LEN(CreatedBy) <= 50),
    Active BIT NOT NULL,
    CHECK (Active IN (0,1))
);

CREATE TABLE UserAdvertisement (
    UserID INT,
    AdvertisementID INT,
    PRIMARY KEY(UserID, AdvertisementID)
);

CREATE TABLE Advertisement (
    AdvertisementID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL
    CHECK (Price >= 0),
    Category NVARCHAR(100) NOT NULL
    CHECK (LEN(Category) <= 100),
    ImageURL NVARCHAR(500) NOT NULL
    CHECK (LEN(ImageURL) <= 500),
    UserID INT NOT NULL,
    Active BIT NOT NULL
    CHECK (Active IN (0,1))
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    Rating VARCHAR(1) NOT NULL,
    Text NVARCHAR(300) NOT NULL,
    ReviewDate DATE NOT NULL,
    UserID INT NOT NULL,
    EventID INT NOT NULL
);


CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    BookingDate DATE NOT NULL,
    NumberOfTickets INT NOT NULL
    CHECK (NumberOfTickets > 0),
    TotalPrice DECIMAL(10,2) NOT NULL
    CHECK (TotalPrice >= 0),
    UserID INT NOT NULL,
    Active BIT NOT NULL
    CHECK (Active IN (0,1))
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    BookingID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE HauntedPlace (
    HauntedPlaceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    MultiMediaContent NVARCHAR(20) NOT NULL,
    BookingID INT NOT NULL,
    ResourceID INT NOT NULL,
    Partnership INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE HauntedPlaceReview (
	HauntedPlaceID INT,
	ReviewID INT,
	PRIMARY KEY (HauntedPlaceID, ReviewID)
	);

CREATE TABLE HauntedPlaceLocation (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
	HauntedPlaceID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE AdType (
    AdTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL,
    HauntedPlaceID INT NOT NULL,
    AdvertisementID INT NOT NULL
);

CREATE TABLE HauntedPlaceAdvertisement (
    AdvertisementID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    AdTypeID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE ResourceType (
    ResourceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL
);

CREATE TABLE Resource (
    ResourceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    ResourceTypeID INT NOT NULL,
    HauntedPlaceID INT NOT NULL
);


CREATE TABLE NotificationType (
    NotificationTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL
);

CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    NotificationTypeID INT NOT NULL,
    UserID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE UserPremium (
    UserPremiumID INT PRIMARY KEY IDENTITY(1,1),
    StartDate DATE NOT NULL,    
	EndDate DATE NOT NULL,
	UserID INT NOT NULL,
	PremiumID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE PremiumPayment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    UserID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Premium (
    PremiumID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    UserID INT NOT NULL
);

CREATE TABLE EventLocation (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE EventAdvertisement (
    EventAdvertisementID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    EventID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE EventAdType (
    EventAdType INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);

CREATE TABLE Partnership (
    PartnershipID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	HauntedPlaceID INT NOT NULL,
    PartnershipTypeID INT NOT NULL,
	Active BIT NOT NULL    
);

CREATE TABLE PartnershipType (
    PartnershipType INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);

CREATE TABLE PartnershipContact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    ContactName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    ContactPhone NVARCHAR(20),
    PartnershipID INT NOT NULL,
	Active BIT NOT NULL
);

CREATE TABLE PartnershipAdType (
    PartnershipAdTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,    
);

CREATE TABLE PartnershipAdvertisement (
    PartnershipAdID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    AdTypeID INT NOT NULL,
	PartnershipTypeID INT NOT NULL,
    Active BIT NOT NULL
);


-- insert data
-- Skapa användare från Sverige
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('swedishuser1', 'Erik', 'Andersson', '1985-05-10', '0701234567', 'erik@example.com', 'User', 1),
       ('swedishuser2', 'Anna', 'Johansson', '1990-08-15', '0707654321', 'anna@example.com', 'User', 1),
       ('swedishuser3', 'Lisa', 'Nilsson', '1982-12-20', '0705554444', 'lisa@example.com', 'User', 1),
       ('swedishuser4', 'Johan', 'Lindgren', '1993-08-07', '0708889999', 'johan@example.com', 'User', 1),
       ('swedishuser5', 'Emma', 'Svensson', '1986-12-12', '0701112222', 'emma@example.com', 'User', 1),
       ('swedishuser6', 'David', 'Eriksson', '1979-05-25', '0703334444', 'david@example.com', 'User', 1),
	   ('swedishuser7', 'Lars', 'Jansson', '1984-07-15', '0704445555', 'lars@example.com', 'User', 1),
	   ('swedishuser8', 'Maria', 'Andersson', '1991-03-20', '0706667777', 'maria.a@example.com', 'User', 1);

-- Skapa användare från Tyskland
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('germanuser1', 'Michael', 'Müller', '1978-04-25', '01761234567', 'michael@example.com', 'User', 1),
       ('germanuser2', 'Sarah', 'Schmidt', '1989-10-12', '01767654321', 'sarah@example.com', 'User', 1),
       ('germanuser3', 'Stefan', 'Wagner', '1983-06-08', '01765554444', 'stefan@example.com', 'User', 1),
       ('germanuser4', 'Andreas', 'Schneider', '1982-10-30', '01768888888', 'andreas@example.com', 'User', 1),
       ('germanuser5', 'Julia', 'Becker', '1990-06-15', '01769999999', 'julia@example.com', 'User', 1),
       ('germanuser6', 'Sabine', 'Schulz', '1985-04-18', '01767777777', 'sabine@example.com', 'User', 1),
	   ('germanuser7', 'Andrea', 'Becker', '1983-05-12', '01761234567', 'andrea@example.com', 'User', 1),
		('germanuser8', 'Matthias', 'Schneider', '1990-09-18', '01767654321', 'matthias@example.com', 'User', 1);

-- Skapa användare från Polen
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('polishuser1', 'Katarzyna', 'Nowak', '1980-07-15', '123456789', 'katarzyna@example.com', 'User', 1),
       ('polishuser2', 'Piotr', 'Kowalski', '1995-02-28', '987654321', 'piotr@example.com', 'User', 1),
       ('polishuser3', 'Magdalena', 'Wiśniewska', '1987-11-03', '543216789', 'magdalena@example.com', 'User', 1),
       ('polishuser4', 'Tomasz', 'Wojcik', '1976-03-05', '123987456', 'tomasz@example.com', 'User', 1),
       ('polishuser5', 'Agnieszka', 'Kowalczyk', '1989-09-20', '789654123', 'agnieszka@example.com', 'User', 1),
       ('polishuser6', 'Marek', 'Jankowski', '1983-07-10', '456123789', 'marek@example.com', 'User', 1),
	   ('polishuser7', 'Łukasz', 'Kowalczyk', '1978-12-28', '123456789', 'lukasz@example.com', 'User', 1),
    ('polishuser8', 'Monika', 'Nowak', '1993-05-10', '987654321', 'monika@example.com', 'User', 1);

-- Skapa användare från Frankrike
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('frenchuser1', 'Jean', 'Dubois', '1975-09-30', '0601020304', 'jean@example.com', 'User', 1),
       ('frenchuser2', 'Marie', 'Lefèvre', '1988-03-14', '0604050607', 'marie@example.com', 'User', 1),
       ('frenchuser3', 'Pierre', 'Leroy', '1992-11-22', '0607080910', 'pierre@example.com', 'User', 1),
       ('frenchuser4', 'Sophie', 'Martin', '1984-11-15', '0609998888', 'sophie@example.com', 'User', 1),
       ('frenchuser5', 'Nicolas', 'Lefebvre', '1995-02-28', '0608889999', 'nicolas@example.com', 'User', 1),
       ('frenchuser6', 'Isabelle', 'Roux', '1980-06-25', '0607778888', 'isabelle@example.com', 'User', 1),
	   ('frenchuser7', 'Étienne', 'Dupont', '1982-10-15', '0601020304', 'etienne@example.com', 'User', 1),
    ('frenchuser8', 'Camille', 'Leclerc', '1990-04-22', '0604050607', 'camille@example.com', 'User', 1);

-- Skapa användare från Spanien
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('spanishuser1', 'Manuel', 'García', '1984-01-20', '612345678', 'manuel@example.com', 'User', 1),
       ('spanishuser2', 'Sofía', 'Martínez', '1996-05-05', '654321987', 'sofia@example.com', 'User', 1),
       ('spanishuser3', 'Alejandro', 'López', '1979-08-12', '698745632', 'alejandro@example.com', 'User', 1),
       ('spanishuser4', 'Carlos', 'Hernández', '1977-04-10', '612345678', 'carlos@example.com', 'User', 1),
       ('spanishuser5', 'Laura', 'Gómez', '1989-08-22', '654321987', 'laura@example.com', 'User', 1),
       ('spanishuser6', 'Javier', 'Díaz', '1982-01-18', '698745632', 'javier@example.com', 'User', 1),
	   ('spanishuser7', 'Pablo', 'Rodríguez', '1979-11-25', '612345678', 'pablo@example.com', 'User', 1),
    ('spanishuser8', 'Elena', 'González', '1991-06-30', '654321987', 'elena@example.com', 'User', 1),
	('spanishuser17', 'Laura', 'Díaz', '1982-06-10', '654321987', 'laura@example.com', 'User', 1);

-- Skapa användare från Italien
INSERT INTO [User] (Username, FirstName, LastName, DateOfBirth, Phonenumber, Email, Role, Active)
VALUES ('italianuser1', 'Giuseppe', 'Rossi', '1986-03-18', '3351234567', 'giuseppe@example.com', 'User', 1),
       ('italianuser2', 'Maria', 'Russo', '1991-07-22', '3387654321', 'maria@example.com', 'User', 1),
       ('italianuser3', 'Antonio', 'Ferrari', '1980-12-10', '3398765432', 'antonio@example.com', 'User', 1),
       ('italianuser4', 'Paolo', 'Conti', '1978-09-20', '3351234567', 'paolo@example.com', 'User', 1),
       ('italianuser5', 'Laura', 'Galli', '1990-07-15', '3387654321', 'laura@example.com', 'User', 1),
       ('italianuser6', 'Giovanni', 'Ricci', '1985-12-30', '3398765432', 'giovanni@example.com', 'User', 1),
	   ('italianuser7', 'Francesco', 'Moretti', '1983-04-18', '3351234567', 'francesco@example.com', 'User', 1),
    ('italianuser8', 'Giulia', 'Ferrari', '1992-09-22', '3387654321', 'giulia@example.com', 'User', 1),
	('italianuser9', 'Luca', 'Ricci', '1985-12-10', '3398765432', 'luca@example.com', 'User', 1);

-- Skapa bokningar för de 50 användarna
INSERT INTO Booking (BookingDate, NumberOfTickets, TotalPrice, UserID, Active)
VALUES 
    -- Bokningar för användare från Sverige
    ('2024-04-22', 2, 100.00, 1, 1),  -- Användare: swedishuser1
    ('2024-04-23', 1, 50.00, 2, 1),    -- Användare: swedishuser2
    ('2024-04-24', 3, 150.00, 3, 1),   -- Användare: swedishuser3
    ('2024-04-25', 2, 100.00, 4, 1),   -- Användare: swedishuser4
    ('2024-04-26', 1, 50.00, 5, 1),    -- Användare: swedishuser5
    ('2024-04-27', 3, 150.00, 6, 1),   -- Användare: swedishuser6

    -- Bokningar för användare från Tyskland
    ('2024-04-22', 2, 100.00, 7, 1),   -- Användare: germanuser1
    ('2024-04-23', 1, 50.00, 8, 1),    -- Användare: germanuser2
    ('2024-04-24', 3, 150.00, 9, 1),   -- Användare: germanuser3
    ('2024-04-25', 2, 100.00, 10, 1),-- Användare: germanuser4
    ('2024-04-26', 1, 50.00, 11, 1), -- Användare: germanuser5
    ('2024-04-27', 3, 150.00, 12, 1),-- Användare: germanuser6

    -- Bokningar för användare från Polen
    ('2024-04-22', 2, 100.00, 13, 1),-- Användare: polishuser1
    ('2024-04-23', 1, 50.00, 14, 1), -- Användare: polishuser2
    ('2024-04-24', 3, 150.00, 15, 1),-- Användare: polishuser3
    ('2024-04-25', 2, 100.00, 16, 1),-- Användare: polishuser4
    ('2024-04-26', 1, 50.00, 17, 1), -- Användare: polishuser5
    ('2024-04-27', 3, 150.00, 18, 1),-- Användare: polishuser6

    -- Bokningar för användare från Frankrike
    ('2024-04-22', 2, 100.00, 19, 1),-- Användare: frenchuser1
    ('2024-04-23', 1, 50.00, 20, 1), -- Användare: frenchuser2
    ('2024-04-24', 3, 150.00, 21, 1),-- Användare: frenchuser3
    ('2024-04-25', 2, 100.00, 22, 1),-- Användare: frenchuser4
    ('2024-04-26', 1, 50.00, 23, 1), -- Användare: frenchuser5
    ('2024-04-27', 3, 150.00, 24, 1),-- Användare: frenchuser6

    -- Bokningar för användare från Spanien
    ('2024-04-22', 2, 100.00, 25, 1),-- Användare: spanishuser1
    ('2024-04-23', 1, 50.00, 26, 1), -- Användare: spanishuser2
    ('2024-04-24', 3, 150.00, 27, 1),-- Användare: spanishuser3
    ('2024-04-25', 2, 100.00, 28, 1),-- Användare: spanishuser4
    ('2024-04-26', 1, 50.00, 29, 1), -- Användare: spanishuser5
    ('2024-04-27', 3, 150.00, 30, 1),-- Användare: spanishuser6

    -- Bokningar för användare från Italien
    ('2024-04-22', 2, 100.00, 31, 1),-- Användare: italianuser1
    ('2024-04-23', 1, 50.00, 32, 1), -- Användare: italianuser2
    ('2024-04-24', 3, 150.00, 33, 1),-- Användare: italianuser3
    ('2024-04-25', 2, 100.00, 34, 1),-- Användare: italianuser4
    ('2024-04-26', 1, 50.00, 35, 1), -- Användare: italianuser5
    ('2024-04-27', 3, 150.00, 36, 1);-- Användare: italianuser6

-- Skapa 10 inloggningsposter med lyckade och misslyckade försök för olika användare
INSERT INTO Login (HashedPassword, Salt, LastLogin, FailedAttempt, UserID, Active)
VALUES
    -- Lyckade inloggningsförsök
    ('hashedpass1', 'salt1', '2024-04-22 08:30:00', 0, 1, 1), -- Användare: swedishuser1
    ('hashedpass2', 'salt2', '2024-04-22 09:45:00', 0, 2, 1), -- Användare: swedishuser2
    ('hashedpass3', 'salt3', '2024-04-22 10:20:00', 0, 3, 1), -- Användare: swedishuser3
    ('hashedpass4', 'salt4', '2024-04-22 11:15:00', 0, 4, 1), -- Användare: swedishuser4
    ('hashedpass5', 'salt5', '2024-04-22 12:00:00', 0, 5, 1), -- Användare: swedishuser5

    -- Misslyckade inloggningsförsök
    ('hashedpass6', 'salt6', '2024-04-22 13:30:00', 1, 6, 1), -- Användare: swedishuser6
    ('hashedpass7', 'salt7', '2024-04-22 14:45:00', 1, 7, 1), -- Användare: germanuser1
    ('hashedpass8', 'salt8', '2024-04-22 15:20:00', 2, 8, 1), -- Användare: germanuser2
    ('hashedpass9', 'salt9', '2024-04-22 16:15:00', 1, 9, 1), -- Användare: germanuser3
    ('hashedpass10', 'salt10', '2024-04-22 17:00:00', 2, 10, 1); -- Användare: germanuser4


-- Skapa adresser för användare från Sverige
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Storgatan 1', 'Stockholm', 'Stockholms län', 'Sverige', '11111', 1, 1), -- Användare: swedishuser1
    ('Gustav Adolfs Torg 2', 'Göteborg', 'Västra Götalands län', 'Sverige', '22222', 2, 1), -- Användare: swedishuser2
    ('Östra Storgatan 3', 'Malmö', 'Skåne län', 'Sverige', '33333', 3, 1), -- Användare: swedishuser3
    ('Drottninggatan 4', 'Uppsala', 'Uppsala län', 'Sverige', '44444', 4, 1), -- Användare: swedishuser4
    ('Kungsgatan 5', 'Linköping', 'Östergötlands län', 'Sverige', '55555', 5, 1), -- Användare: swedishuser5
    ('Södra Hamngatan 6', 'Helsingborg', 'Skåne län', 'Sverige', '66666', 6, 1); -- Användare: swedishuser6

-- Skapa adresser för användare från Tyskland
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Hauptstraße 1', 'Berlin', 'Berlin', 'Tyskland', '10115', 7, 1), -- Användare: germanuser1
    ('Königstraße 2', 'Hamburg', 'Hamburg', 'Tyskland', '20095', 8, 1), -- Användare: germanuser2
    ('Marktplatz 3', 'München', 'Bayern', 'Tyskland', '80331', 9, 1), -- Användare: germanuser3
    ('Bahnhofstraße 4', 'Köln', 'Nordrhein-Westfalen', 'Tyskland', '50667', 10, 1), -- Användare: germanuser4
    ('Schloßstraße 5', 'Frankfurt am Main', 'Hessen', 'Tyskland', '60313', 11, 1), -- Användare: germanuser5
    ('Marktstraße 6', 'Stuttgart', 'Baden-Württemberg', 'Tyskland', '70173', 12, 1); -- Användare: germanuser6

-- Skapa adresser för användare från Polen
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Nowy Świat 1', 'Warszawa', 'Mazowieckie', 'Polen', '00-002', 13, 1), -- Användare: polishuser1
    ('Plac Zbawiciela 2', 'Kraków', 'Małopolskie', 'Polen', '31-001', 14, 1), -- Användare: polishuser2
    ('Plac Grzybowski 3', 'Łódź', 'Łódzkie', 'Polen', '90-001', 15, 1), -- Användare: polishuser3
    ('Plac Wolności 4', 'Wrocław', 'Dolnośląskie', 'Polen', '50-001', 16, 1), -- Användare: polishuser4
    ('Rynek 5', 'Poznań', 'Wielkopolskie', 'Polen', '61-001', 17, 1), -- Användare: polishuser5
    ('Aleja Niepodległości 6', 'Gdańsk', 'Pomorskie', 'Polen', '80-001', 18, 1); -- Användare: polishuser6

-- Skapa adresser för användare från Frankrike
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Rue de la République 1', 'Paris', 'Île-de-France', 'Frankrike', '75001', 19, 1), -- Användare: frenchuser1
    ('Rue du Faubourg Saint-Honoré 2', 'Paris', 'Île-de-France', 'Frankrike', '75008', 20, 1), -- Användare: frenchuser2
    ('Rue de Rivoli 3', 'Paris', 'Île-de-France', 'Frankrike', '75004', 21, 1), -- Användare: frenchuser3
    ('Place de la Concorde 4', 'Paris', 'Île-de-France', 'Frankrike', '75008', 22, 1), -- Användare: frenchuser4
    ('Avenue des Champs-Élysées 5', 'Paris', 'Île-de-France', 'Frankrike', '75008', 23, 1), -- Användare: frenchuser5
    ('Avenue de la République 6', 'Paris', 'Île-de-France', 'Frankrike', '75011', 24, 1); -- Användare: frenchuser6

-- Skapa adresser för användare från Spanien
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Calle Mayor 1', 'Madrid', 'Madrid', 'Spanien', '28001', 25, 1), -- Användare: spanishuser1
    ('Paseo de la Castellana 2', 'Madrid', 'Madrid', 'Spanien', '28046', 26, 1), -- Användare: spanishuser2
    ('Gran Vía 3', 'Madrid', 'Madrid', 'Spanien', '28013', 27, 1), -- Användare: spanishuser3
    ('Calle de Alcalá 4', 'Madrid', 'Madrid', 'Spanien', '28014', 28, 1), -- Användare: spanishuser4
    ('Calle de Serrano 5', 'Madrid', 'Madrid', 'Spanien', '28006', 29, 1), -- Användare: spanishuser5
    ('Paseo del Prado 6', 'Madrid', 'Madrid', 'Spanien', '28014', 30, 1); -- Användare: spanishuser6

-- Skapa adresser för användare från Italien
INSERT INTO Address (Street, City, Region, Country, Zipcode, UserID, Active)
VALUES 
    ('Via Roma 1', 'Rom', 'Lazio', 'Italien', '00184', 31, 1), -- Användare: italianuser1
    ('Via Monte Napoleone 2', 'Milano', 'Lombardiet', 'Italien', '20121', 32, 1), -- Användare: italianuser2
    ('Via della Spiga 3', 'Milano', 'Lombardiet', 'Italien', '20121', 33, 1), -- Användare: italianuser3
    ('Piazza San Marco 4', 'Venedig', 'Veneto', 'Italien', '30124', 34, 1), -- Användare: italianuser4
    ('Via Veneto 5', 'Rom', 'Lazio', 'Italien', '00187', 35, 1), -- Användare: italianuser5
    ('Corso Vittorio Emanuele II 6', 'Rom', 'Lazio', 'Italien', '00186', 36, 1); -- Användare: italianuser6
	
-- Skapa 12 communitys och associera dem med användarna
INSERT INTO UserCommunity (JoinDate, Role, UserID, CommunityID, Active)
VALUES 
    -- Community 1
    ('2024-04-22', 'Admin', 1, 1, 1), -- Användare: swedishuser1
    ('2024-04-23', 'Member', 2, 1, 1), -- Användare: swedishuser2
    ('2024-04-24', 'Member', 3, 1, 1), -- Användare: swedishuser3

    -- Community 2
    ('2024-04-22', 'Admin', 4, 2, 1), -- Användare: swedishuser4
    ('2024-04-23', 'Member', 5, 2, 1), -- Användare: swedishuser5
    ('2024-04-24', 'Member', 6, 2, 1), -- Användare: swedishuser6

    -- Community 3
    ('2024-04-22', 'Admin', 7, 3, 1), -- Användare: germanuser1
    ('2024-04-23', 'Member', 8, 3, 1), -- Användare: germanuser2
    ('2024-04-24', 'Member', 9, 3, 1), -- Användare: germanuser3

    -- Community 4
    ('2024-04-22', 'Admin', 10, 4, 1), -- Användare: germanuser4
    ('2024-04-23', 'Member', 11, 4, 1), -- Användare: germanuser5
    ('2024-04-24', 'Member', 12, 4, 1); -- Användare: germanuser6


-- Skapa 12 communitys och matcha dem med användarcommunityerna
INSERT INTO Community (Name, Description, CreatedDate, CreatedBy, Active)
VALUES 
    -- Community 1
    ('Swedish Users Community', 'Community for Swedish users', '2024-04-22', 'Admin1', 1),

    -- Community 2
    ('German Users Community', 'Community for German users', '2024-04-22', 'Admin2', 1),

    -- Community 3
    ('Polish Users Community', 'Community for Polish users', '2024-04-22', 'Admin3', 1),

    -- Community 4
    ('French Users Community', 'Community for French users', '2024-04-22', 'Admin4', 1),

    -- Community 5
    ('Spanish Users Community', 'Community for Spanish users', '2024-04-22', 'Admin5', 1),

    -- Community 6
    ('Italian Users Community', 'Community for Italian users', '2024-04-22', 'Admin6', 1),

    -- Community 7
    ('Nordic Users Community', 'Community for Nordic users', '2024-04-22', 'Admin7', 1),

    -- Community 8
    ('Central European Users Community', 'Community for Central European users', '2024-04-22', 'Admin8', 1),

    -- Community 9
    ('Western European Users Community', 'Community for Western European users', '2024-04-22', 'Admin9', 1),

    -- Community 10
    ('Southern European Users Community', 'Community for Southern European users', '2024-04-22', 'Admin10', 1),

    -- Community 11
    ('European Users Community', 'Community for European users', '2024-04-22', 'Admin11', 1),

    -- Community 12
    ('Global Users Community', 'Community for Global users', '2024-04-22', 'Admin12', 1);

-- Skapa 5 dataposter för användarannonsering
INSERT INTO UserAdvertisement (UserID, AdvertisementID)
VALUES 
    (1, 1), -- Användare: swedishuser1, Annons: 1
    (2, 2), -- Användare: swedishuser2, Annons: 2
    (3, 3), -- Användare: swedishuser3, Annons: 3
    (4, 4), -- Användare: swedishuser4, Annons: 4
    (5, 5); -- Användare: swedishuser5, Annons: 5

-- Skapa 5 dataposter för annonsering av hemsökta platser och events
INSERT INTO Advertisement (Title, Description, StartDate, EndDate, Price, Category, ImageURL, UserID, Active)
VALUES 
    ('Ghost Tour in Old Town', 'Join us for a spooky adventure in the historic Old Town', '2024-04-22', '2024-04-30', 50.00, 'Events', 'https://example.com/ghost_tour.jpg', 1, 1),
    ('Haunted House Party', 'Experience the thrill of a haunted house party', '2024-04-23', '2024-05-15', 20.00, 'Events', 'https://example.com/haunted_house_party.jpg', 2, 1),
    ('Paranormal Investigation', 'Join our team for a paranormal investigation at a haunted location', '2024-04-24', '2024-05-10', 100.00, 'Events', 'https://example.com/paranormal_investigation.jpg', 3, 1),
    ('Haunted Hotel Stay', 'Stay overnight at a haunted hotel if you dare', '2024-04-25', '2024-05-05', 150.00, 'Accommodation', 'https://example.com/haunted_hotel.jpg', 4, 1),
    ('Ghost Ship Cruise', 'Embark on a ghostly adventure with our haunted ship cruise', '2024-04-26', '2024-05-20', 75.00, 'Events', 'https://example.com/ghost_ship.jpg', 5, 1);

-- Skapa 20 dataposter för recensioner
INSERT INTO Review (Rating, Text, ReviewDate, UserID, EventID)
VALUES 
    ('5', 'Great experience, highly recommended!', '2024-04-22', 1, 6), -- Användare: swedishuser1, Event: 1
    ('4', 'Enjoyed the event, but could be improved', '2024-04-23', 2, 7), -- Användare: swedishuser2, Event: 2
    ('3', 'Average experience, nothing special', '2024-04-24', 3, 8), -- Användare: swedishuser3, Event: 3
    ('5', 'Absolutely terrifying, loved it!', '2024-04-25', 4, 9), -- Användare: swedishuser4, Event: 4
    ('2', 'Disappointing, not worth the money', '2024-04-26', 5, 25), -- Användare: swedishuser5, Event: 5
    ('5', 'Best haunted house I have ever been to!', '2024-04-27', 6, 16), -- Användare: swedishuser6, Event: 6
    ('4', 'Spooky atmosphere, but too crowded', '2024-04-28', 7, 7), -- Användare: germanuser1, Event: 7
    ('3', 'Expected more scares, was a bit disappointed', '2024-04-29', 8, 8), -- Användare: germanuser2, Event: 8
    ('5', 'Fantastic event, exceeded my expectations', '2024-04-30', 9, 19), -- Användare: germanuser3, Event: 9
    ('2', 'Not scary at all, waste of time', '2024-05-01', 10, 10), -- Användare: germanuser4, Event: 10
    ('5', 'Incredible experience, will definitely come back', '2024-05-02', 11, 21), -- Användare: germanuser5, Event: 11
    ('4', 'Good scares, but too short', '2024-05-03', 12, 12), -- Användare: germanuser6, Event: 12
    ('5', 'Absolutely terrifying, worth every penny', '2024-05-04', 1, 13), -- Användare: swedishuser1, Event: 13
    ('3', 'Expected more from the event, was a bit disappointed', '2024-05-05', 2, 14), -- Användare: swedishuser2, Event: 14
    ('4', 'Fun experience, but could be scarier', '2024-05-06', 3, 15), -- Användare: swedishuser3, Event: 15
    ('5', 'Spine-chilling experience, loved every moment', '2024-05-07', 4, 16), -- Användare: swedishuser4, Event: 16
    ('2', 'Not worth the money, very disappointed', '2024-05-08', 5, 17), -- Användare: swedishuser5, Event: 17
    ('5', 'One of the best haunted houses I have visited', '2024-05-09', 6, 18), -- Användare: swedishuser6, Event: 18
    ('4', 'Scary, but wish there were more interactive elements', '2024-05-10', 7, 19), -- Användare: germanuser1, Event: 19
    ('3', 'Expected better, left feeling underwhelmed', '2024-05-11', 8, 20), -- Användare: germanuser2, Event: 20
	('5', 'The haunted place was absolutely terrifying, would recommend!', '2024-05-12', 9, 21), -- Användare: germanuser3, Event: 21
    ('4', 'Great atmosphere, but wish there were more scares', '2024-05-13', 10, 22), -- Användare: germanuser4, Event: 22
    ('3', 'Decent event, but could be improved', '2024-05-14', 11, 23), -- Användare: germanuser5, Event: 23
    ('5', 'One of the best haunted experiences I have had!', '2024-05-15', 12, 24), -- Användare: germanuser6, Event: 24
    ('4', 'Scary, but not as much as I expected', '2024-05-16', 1, 25), -- Användare: swedishuser1, Event: 25
    ('5', 'Absolutely terrifying, worth every penny', '2024-05-17', 2, 26), -- Användare: swedishuser2, Event: 26
    ('3', 'Expected more scares, was a bit let down', '2024-05-18', 3, 27), -- Användare: swedishuser3, Event: 27
    ('4', 'Good scares, but wish it was longer', '2024-05-19', 4, 28), -- Användare: swedishuser4, Event: 28
    ('5', 'Absolutely terrifying, loved every moment', '2024-05-20', 5, 29), -- Användare: swedishuser5, Event: 29
    ('2', 'Not scary at all, very disappointed', '2024-05-21', 6, 30); -- Användare: swedishuser6, Event: 30

-- Skapa 20 dataposter för betalningar
INSERT INTO Payment (PaymentDate, Amount, PaymentMethod, BookingID, Active)
VALUES 
    ('2024-04-22 12:30:00', 50.00, 'Credit Card', 1, 1), -- Användare: swedishuser1, Bokning: 1
    ('2024-04-23 13:45:00', 100.00, 'PayPal', 2, 1), -- Användare: swedishuser2, Bokning: 2
    ('2024-04-24 14:20:00', 75.00, 'Credit Card', 3, 1), -- Användare: swedishuser3, Bokning: 3
    ('2024-04-25 15:10:00', 120.00, 'PayPal', 4, 1), -- Användare: swedishuser4, Bokning: 4
    ('2024-04-26 16:00:00', 30.00, 'Credit Card', 5, 1), -- Användare: swedishuser5, Bokning: 5
    ('2024-04-27 17:30:00', 80.00, 'PayPal', 6, 1), -- Användare: swedishuser6, Bokning: 6
    ('2024-04-28 18:45:00', 60.00, 'Credit Card', 7, 1), -- Användare: germanuser1, Bokning: 7
    ('2024-04-29 19:20:00', 90.00, 'PayPal', 8, 1), -- Användare: germanuser2, Bokning: 8
    ('2024-04-30 20:15:00', 110.00, 'Credit Card', 9, 1), -- Användare: germanuser3, Bokning: 9
    ('2024-05-01 21:00:00', 40.00, 'PayPal', 10, 1), -- Användare: germanuser4, Bokning: 10
    ('2024-05-02 22:30:00', 70.00, 'Credit Card', 11, 1), -- Användare: germanuser5, Bokning: 11
    ('2024-05-03 23:55:00', 85.00, 'PayPal', 12, 1), -- Användare: germanuser6, Bokning: 12
    ('2024-05-04 11:20:00', 55.00, 'Credit Card', 13, 1), -- Användare: swedishuser1, Bokning: 13
    ('2024-05-05 12:45:00', 95.00, 'PayPal', 14, 1), -- Användare: swedishuser2, Bokning: 14
    ('2024-05-06 13:30:00', 65.00, 'Credit Card', 15, 1), -- Användare: swedishuser3, Bokning: 15
    ('2024-05-07 14:20:00', 130.00, 'PayPal', 16, 1), -- Användare: swedishuser4, Bokning: 16
    ('2024-05-08 15:10:00', 45.00, 'Credit Card', 17, 1), -- Användare: swedishuser5, Bokning: 17
    ('2024-05-09 16:30:00', 75.00, 'PayPal', 18, 1), -- Användare: swedishuser6, Bokning: 18
    ('2024-05-10 17:45:00', 70.00, 'Credit Card', 19, 1), -- Användare: germanuser1, Bokning: 19
    ('2024-05-11 18:20:00', 100.00, 'PayPal', 20, 1); -- Användare: germanuser2, Bokning: 20

-- Skapa 30 dataposter för hemsökta platser
INSERT INTO HauntedPlace (Name, Description, MultiMediaContent, BookingID, ResourceID, Partnership, Active)
VALUES 
    ('Djurgården', 'The Djurgården island is rumored to be haunted by the spirits of sailors who drowned in the nearby waters centuries ago.', 'Image', 1, 1, 1, 1), -- Sverige
    ('Skeppsholmen', 'Skeppsholmen, an island in central Stockholm, is said to be haunted by the ghost of a woman who was executed for witchcraft.', 'Video', 2, 2, 1, 1), -- Sverige
    ('The Old Town', 'Stockholm''s Old Town, Gamla Stan, is rumored to have several haunted buildings dating back to medieval times.', 'Image', 3, 3, 1, 1), -- Sverige
    ('Wawel Castle', 'Wawel Castle in Krakow is said to be haunted by the ghost of a dragon slain by the legendary Polish prince Krakus.', 'Video', 4, 4, 1, 1), -- Polen
    ('The Warsaw Ghetto', 'The site of the former Warsaw Ghetto is believed to be haunted by the spirits of those who perished during World War II.', 'Image', 5, 5, 1, 1), -- Polen
    ('Zakopane', 'Zakopane, a popular mountain resort in Poland, is rumored to have several haunted chalets and cabins.', 'Video', 6, 6, 1, 1), -- Polen
    ('Burg Frankenstein', 'Burg Frankenstein in Germany is said to be haunted by the ghost of a mad alchemist who once lived there.', 'Image', 7, 7, 1, 1), -- Tyskland
    ('Heidelberg Castle', 'Heidelberg Castle, one of Germany''s most famous landmarks, is rumored to be haunted by the spirit of a cursed princess.', 'Video', 8, 8, 1, 1), -- Tyskland
    ('The Black Forest', 'The Black Forest in Germany is said to be haunted by various spirits, including the ghost of a headless horseman.', 'Image', 9, 9, 1, 1), -- Tyskland
    ('The Catacombs of Paris', 'The Catacombs of Paris, a vast underground ossuary, are said to be haunted by the restless souls of the deceased.', 'Video', 10, 10, 1, 1), -- Frankrike
    ('Château de Brissac', 'Château de Brissac in France is said to be haunted by the Green Lady, a ghost who reportedly wanders the castle.', 'Image', 11, 11, 1, 1), -- Frankrike
    ('The Palace of Versailles', 'The Palace of Versailles, once the seat of French royalty, is rumored to be haunted by the ghosts of former monarchs.', 'Video', 12, 12, 1, 1), -- Frankrike
    ('The Alhambra', 'The Alhambra, a majestic palace in Granada, Spain, is said to be haunted by the ghost of a Moorish princess.', 'Image', 13, 13, 1, 1), -- Spanien
    ('The Monastery of San Jerónimo', 'The Monastery of San Jerónimo in Spain is rumored to be haunted by the spirits of monks who once lived there.', 'Video', 14, 14, 1, 1), -- Spanien
    ('The Royal Palace of Madrid', 'The Royal Palace of Madrid is said to be haunted by the ghost of a former queen who died under mysterious circumstances.', 'Image', 15, 15, 1, 1), -- Spanien
    ('Poveglia Island', 'Poveglia Island near Venice, Italy, is rumored to be one of the most haunted places in the world, with a history of plague victims and asylum patients.', 'Video', 16, 16, 1, 1), -- Italien
    ('The Catacombs of Rome', 'The Catacombs of Rome, ancient underground burial sites, are said to be haunted by the spirits of early Christians.', 'Image', 17, 17, 1, 1), -- Italien
    ('The Colosseum', 'The Colosseum in Rome is rumored to be haunted by the ghosts of gladiators who died in combat.', 'Video', 18, 18, 1, 1), -- Italien
    ('The Tower of London', 'The Tower of London is said to be haunted by the spirits of former prisoners and executed royals.', 'Image', 19, 19, 1, 1), -- Storbritannien
    ('Edinburgh Castle', 'Edinburgh Castle in Scotland is rumored to be haunted by the ghost of a headless drummer.', 'Video', 20, 20, 1, 1); -- Storbritannien

-- Skapa 30 dataposter i HauntedPlaceReview
INSERT INTO HauntedPlaceReview (HauntedPlaceID, ReviewID)
VALUES 
    (1, 1),
    (2, 2),  
    (3, 3),  
    (4, 4),  
    (5, 5),  
    (1, 6),  
    (2, 7),  
    (3, 8),  
    (4, 9),  
    (5, 10),  
    (1, 11),  
    (2, 12),  
    (3, 13),  
    (4, 14),  
    (5, 15),  
    (1, 16),  
    (2, 17),  
    (3, 18),  
    (4, 19),  
    (5, 20),  
    (1, 21),  
    (2, 22),  
    (3, 23),  
    (4, 24),  
    (5, 25),  
    (1, 26),  
    (2, 27),  
    (3, 28),  
    (4, 29),  
    (5, 30);  

-- Skapa 30 dataposter i HauntedPlaceLocation med riktiga platser
INSERT INTO HauntedPlaceLocation (Address, City, Region, Country, Zipcode, Latitude, Longitude, HauntedPlaceID, Active)
VALUES 
    ('Skeppsholmen 1', 'Stockholm', 'Stockholm', 'Sweden', '11149', 59.3252, 18.0860,1, 1),
    ('Brandenburger Tor', 'Berlin', 'Berlin', 'Germany', '10117', 52.5163, 13.3777,2, 1),
    ('ul. Podwale', 'Warsaw', 'Masovian Voivodeship', 'Poland', '00-260', 52.2481, 21.0138,3, 1),
    ('Musée du Louvre', 'Paris', 'Île-de-France', 'France', '75001', 48.8606, 2.3376,4, 1),
    ('Plaza Mayor', 'Madrid', 'Community of Madrid', 'Spain', '28012', 40.4155, -3.7075,5, 1),
    ('Colosseum', 'Rome', 'Lazio', 'Italy', '00184', 41.8902, 12.4922,6, 1),
    ('Vasamuseet', 'Stockholm', 'Stockholm', 'Sweden', '11521', 59.3289, 18.0913,7, 1),
    ('Berliner Dom', 'Berlin', 'Berlin', 'Germany', '10178', 52.5186, 13.4009,8, 1),
    ('Zamek Królewski', 'Warsaw', 'Masovian Voivodeship', 'Poland', '00-277', 52.2472, 21.0139,9, 1),
    ('Palais Garnier', 'Paris', 'Île-de-France', 'France', '75009', 48.8718, 2.3311,10, 1),
    ('Parque del Retiro', 'Madrid', 'Community of Madrid', 'Spain', '28009', 40.4144, -3.6823,11, 1),
    ('Roman Forum', 'Rome', 'Lazio', 'Italy', '00186', 41.8925, 12.4862,12, 1),
    ('Gamla stan', 'Stockholm', 'Stockholm', 'Sweden', '11129', 59.3257, 18.0719,13, 1),
    ('Pergamonmuseum', 'Berlin', 'Berlin', 'Germany', '10117', 52.5195, 13.3986,14, 1),
    ('Pałac Kultury i Nauki', 'Warsaw', 'Masovian Voivodeship', 'Poland', '00-001', 52.2315, 21.0067,15, 1),
    ('Centre Pompidou', 'Paris', 'Île-de-France', 'France', '75004', 48.8606, 2.3522,16, 1),
    ('Templo de Debod', 'Madrid', 'Community of Madrid', 'Spain', '28008', 40.4240, -3.7170,17, 1),
    ('Piazza di Spagna', 'Rome', 'Lazio', 'Italy', '00187', 41.9058, 12.4828,18, 1),
    ('Drottningholms slott', 'Stockholm', 'Stockholm', 'Sweden', '17802', 59.3257, 17.8967,19, 1),
    ('Gedenkstätte Berliner Mauer', 'Berlin', 'Berlin', 'Germany', '10117', 52.5056, 13.4393,20, 1)    

-- Skapa 30 dataposter i AdType tabellen
INSERT INTO AdType (TypeName, HauntedPlaceID, AdvertisementID)
VALUES 
    ('Standard', 1, 1),  -- Använd HauntedPlaceID och AdvertisementID från tidigare skapade dataposter
    ('Featured', 2, 2),
    ('Standard', 3, 3),
    ('Premium', 4, 4),
    ('Featured', 5, 5),
    ('Standard', 6, 6),
    ('Premium', 7, 7),
    ('Standard', 8, 8),
    ('Featured', 9, 9),
    ('Standard', 10, 10),
    ('Premium', 11, 11),
    ('Featured', 12, 12),
    ('Standard', 13, 13),
    ('Premium', 14, 14),
    ('Featured', 15, 15),
    ('Standard', 16, 16),
    ('Premium', 17, 17),
    ('Featured', 18, 18),
    ('Standard', 19, 19),
    ('Premium', 20, 20)

-- Skapa 30 dataposter i HauntedPlaceAdvertisement tabellen
INSERT INTO HauntedPlaceAdvertisement (Title, Description, StartDate, EndDate, Price, Category, AdTypeID, Active)
VALUES 
    ('Haunted Mansion Tour', 'Explore the haunted history of this mysterious mansion', '2024-04-22', '2024-05-22', 50.00, 'Tours', 1, 1),  -- Använd AdTypeID från tidigare skapade dataposter
    ('Ghostly Encounter Experience', 'Join us for a spine-chilling ghostly encounter', '2024-04-23', '2024-05-23', 75.00, 'Experiences', 2, 1),
    ('Horror Movie Marathon', 'Watch your favorite horror movies in a haunted setting', '2024-04-24', '2024-05-24', 25.00, 'Events', 3, 1),
    ('Creepy Escape Room Challenge', 'Test your bravery in our terrifying escape room', '2024-04-25', '2024-05-25', 40.00, 'Activities', 4, 1),
    ('Paranormal Investigation Workshop', 'Learn the secrets of paranormal investigation from experts', '2024-04-26', '2024-05-26', 60.00, 'Workshops', 5, 1),
    ('Haunted History Walking Tour', 'Discover the haunted history of our city on foot', '2024-04-27', '2024-05-27', 35.00, 'Tours', 6, 1),
    ('Nightmare-inducing Maze Experience', 'Navigate through a terrifying maze filled with nightmares', '2024-04-28', '2024-05-28', 45.00, 'Experiences', 7, 1),
    ('Spooky Dinner Party', 'Dine with ghosts in this eerie dinner party experience', '2024-04-29', '2024-05-29', 55.00, 'Events', 8, 1),
    ('Horror Film Screening', 'Watch classic horror films in a haunted theater', '2024-04-30', '2024-05-30', 20.00, 'Events', 9, 1),
    ('Frightening Haunted House Tour', 'Brave the horrors of our haunted house if you dare', '2024-05-01', '2024-05-31', 65.00, 'Tours', 10, 1),
    ('Ghost Hunt Adventure', 'Join us on a ghost hunt in the most haunted locations', '2024-05-02', '2024-06-01', 70.00, 'Experiences', 11, 1),
    ('Scary Movie Night', 'Enjoy a night of spine-chilling horror films', '2024-05-03', '2024-06-02', 30.00, 'Events', 12, 1),
    ('Eerie Escape Room Challenge', 'Attempt to escape from our terrifying escape room', '2024-05-04', '2024-06-03', 40.00, 'Activities', 13, 1),
    ('Paranormal Investigation Seminar', 'Learn about paranormal investigation techniques', '2024-05-05', '2024-06-04', 50.00, 'Workshops', 14, 1),
    ('Haunted Cemetery Tour', 'Explore the spookiest cemetery in town', '2024-05-06', '2024-06-05', 30.00, 'Tours', 15, 1),
    ('Creepy Ghost Stories Night', 'Listen to bone-chilling ghost stories by candlelight', '2024-05-07', '2024-06-06', 25.00, 'Events', 16, 1),
    ('Terrifying Haunted Trail Experience', 'Survive a journey through our haunted trail', '2024-05-08', '2024-06-07', 40.00, 'Experiences', 17, 1),
    ('Horror Movie Marathon', 'Watch a marathon of horror movies in our haunted theater', '2024-05-09', '2024-06-08', 35.00, 'Events', 18, 1),
    ('Spooky Escape Room Challenge', 'Attempt to escape from our spooky escape room', '2024-05-10', '2024-06-09', 45.00, 'Activities', 19, 1),
    ('Paranormal Investigation Workshop', 'Learn about the tools and techniques used in paranormal investigations', '2024-05-11', '2024-06-10', 55.00, 'Workshops', 20, 1)    

-- Skapa 30 dataposter i ResourceType tabellen
INSERT INTO ResourceType (Name, Description)
VALUES 
    ('Ghost Hunting Equipment', 'Essential equipment for paranormal investigations'),
    ('Brochure', 'Informational brochure about the haunted place'),
    ('Entertainment', 'Entertainment options for visitors'),
    ('Puzzle Clues', 'Clues and hints for solving puzzles'),
    ('Tools', 'Tools used by experts for paranormal investigations'),
    ('Guidebook', 'Guidebook with information about the haunted location'),
    ('Map', 'Map showing the layout of the haunted area'),
    ('Menu', 'Menu featuring spooky dishes for themed events'),
    ('Schedule', 'Schedule of activities and events'),
    ('Props', 'Props used to create a spooky atmosphere'),
    ('Handbook', 'Handbook with tips for visitors'),
    ('Program', 'Program listing events and activities'),
    ('Devices', 'Devices for detecting paranormal activity'),
    ('Book', 'Book containing spooky stories'),
    ('Props', 'Props for interactive experiences'),
    ('Brochure', 'Brochure with information about the haunted attraction'),
    ('Guidebook', 'Guidebook with information about the haunted location'),
    ('Map', 'Map of the haunted area for visitors'),
    ('Program', 'Program listing events and activities'),
    ('Props', 'Props for interactive experiences')

-- Skapa 30 dataposter i Resource tabellen
INSERT INTO Resource (Name, Description, ResourceTypeID, HauntedPlaceID)
VALUES 
    ('Ghost Hunting Equipment', 'Essential equipment for paranormal investigations', 1, 1), -- HauntedPlaceID: 1
    ('Haunted Mansion Brochure', 'Informational brochure about the haunted mansion', 2, 2), -- HauntedPlaceID: 2
    ('Horror Movie Collection', 'Collection of classic horror movies for guests to watch', 3, 3), -- HauntedPlaceID: 3
    ('Escape Room Clues', 'Clues and hints for solving the escape room puzzles', 4, 4), -- HauntedPlaceID: 4
    ('Paranormal Investigation Tools', 'Tools used by experts for paranormal investigations', 5, 5), -- HauntedPlaceID: 5
    ('Haunted History Guidebook', 'Guidebook detailing the haunted history of the city', 6, 6), -- HauntedPlaceID: 6
    ('Maze Map', 'Map showing the layout of the haunted maze', 7, 7), -- HauntedPlaceID: 7
    ('Dinner Party Menu', 'Menu featuring spooky dishes for the dinner party', 8, 8), -- HauntedPlaceID: 8
    ('Theater Schedule', 'Schedule of horror movie screenings in the haunted theater', 9, 9), -- HauntedPlaceID: 9
    ('Haunted House Brochure', 'Brochure with information about the haunted house', 10, 10), -- HauntedPlaceID: 10
    ('Ghost Hunting Cameras', 'Cameras used to capture paranormal activity', 11, 11), -- HauntedPlaceID: 11
    ('Escape Room Challenges', 'Challenges and puzzles for the escape room experience', 12, 12), -- HauntedPlaceID: 12
    ('Paranormal Investigation Handbook', 'Handbook with tips for conducting paranormal investigations', 13, 13), -- HauntedPlaceID: 13
    ('Cemetery Map', 'Map of the haunted cemetery for guided tours', 14, 14), -- HauntedPlaceID: 14
    ('Ghost Stories Book', 'Book containing spooky ghost stories for storytelling events', 15, 15), -- HauntedPlaceID: 15
    ('Trail Map', 'Map of the haunted trail for visitors to navigate', 16, 16), -- HauntedPlaceID: 16
    ('Theater Program', 'Program listing the horror movies being screened in the theater', 17, 17), -- HauntedPlaceID: 17
    ('Escape Room Props', 'Props used to create a creepy atmosphere in the escape room', 18, 18), -- HauntedPlaceID: 18
    ('Paranormal Investigation Devices', 'Devices for detecting and measuring paranormal activity', 19, 19), -- HauntedPlaceID: 19
    ('Ghost Ship Brochure', 'Brochure with information about the haunted ghost ship', 20, 20) -- HauntedPlaceID: 20   

-- Skapa 50 dataposter i NotificationType tabellen
INSERT INTO NotificationType (TypeName)
VALUES 
    ('General'),
    ('Promotion'),
    ('Event'),
    ('Reminder'),
    ('Feedback'),
    ('Update'),
    ('Alert'),
    ('Announcement'),
    ('Invitation'),
    ('Newsletter'),
    ('Special Offer'),
    ('Survey'),
    ('Reminder'),
    ('Feedback'),
    ('Announcement'),
    ('Event'),
    ('Update'),
    ('Promotion'),
    ('Alert'),
    ('Invitation'),
    ('Newsletter'),
    ('General'),
    ('Special Offer'),
    ('Survey'),
    ('Reminder'),
    ('Feedback'),
    ('Announcement'),
    ('Event'),
    ('Update'),
    ('Promotion'),
    ('Alert'),
    ('Invitation'),
    ('Newsletter'),
    ('General'),
    ('Special Offer'),
    ('Survey'),
    ('Reminder'),
    ('Feedback'),
    ('Announcement'),
    ('Event'),
    ('Update'),
    ('Promotion'),
    ('Alert'),
    ('Invitation'),
    ('Newsletter'),
    ('General'),
    ('Special Offer'),
    ('Survey');

-- Skapa 50 dataposter i Notification tabellen
INSERT INTO Notification (Title, Description, NotificationTypeID, UserID, Active)
VALUES
    ('New Message', 'You have received a new message.', 1, 1, 1),
    ('New Friend Request', 'You have received a friend request.', 2, 2, 1),
    ('Event Reminder', 'Reminder: Event starts in one hour.', 3, 3, 1),
    ('Payment Confirmation', 'Your payment has been confirmed.', 1, 4, 1),
    ('Account Update', 'Your account information has been updated.', 2, 5, 1),
    ('Password Reset', 'A request to reset your password has been received.', 3, 6, 1),
    ('New Comment', 'You have a new comment on your post.', 1, 7, 1),
    ('Post Liked', 'Your post has been liked by another user.', 2, 8, 1),
    ('New Follower', 'You have a new follower.', 3, 9, 1),
    ('Appointment Reminder', 'Reminder: You have an appointment tomorrow.', 1, 10, 1),
    ('Task Assigned', 'A new task has been assigned to you.', 2, 11, 1),
    ('Document Approval', 'Your document has been approved.', 3, 12, 1),
    ('New Order', 'You have a new order.', 1, 13, 1),
    ('Subscription Renewal', 'Your subscription has been renewed.', 2, 14, 1),
    ('File Uploaded', 'A new file has been uploaded to your account.', 3, 15, 1),
    ('Meeting Invitation', 'You have been invited to a meeting.', 1, 16, 1),
    ('New Task', 'You have a new task assigned.', 2, 17, 1),
    ('Product Shipped', 'Your order has been shipped.', 3, 18, 1),
    ('Appointment Confirmation', 'Your appointment has been confirmed.', 1, 19, 1),
    ('Event Invitation', 'You have been invited to an event.', 2, 20, 1),
    ('New Announcement', 'There is a new announcement.', 3, 21, 1),
    ('Service Update', 'There is an update regarding your service.', 1, 22, 1),
    ('Document Shared', 'A document has been shared with you.', 2, 23, 1),
    ('Feedback Received', 'Your feedback has been received.', 3, 24, 1),
    ('New Task Comment', 'There is a new comment on your task.', 1, 25, 1),
    ('Profile Update', 'Your profile information has been updated.', 2, 26, 1),
    ('New Event RSVP', 'You have a new RSVP for your event.', 3, 27, 1),
    ('New Subscription', 'You have a new subscription.', 1, 28, 1),
    ('New Request', 'You have a new request.', 2, 29, 1),
    ('Product Discount', 'You have received a discount on a product.', 3, 30, 1),
    ('Task Completed', 'A task assigned to you has been completed.', 1, 31, 1),
    ('Survey Invitation', 'You have been invited to participate in a survey.', 2, 32, 1),
    ('Document Update', 'A document you have access to has been updated.', 3, 33, 1),
    ('New Message Received', 'You have received a new message from another user.', 1, 34, 1),
    ('Appointment Rescheduled', 'Your appointment has been rescheduled.', 2, 35, 1),
    ('Event Update', 'There is an update regarding the event you are attending.', 3, 36, 1),
    ('New Notification', 'You have a new notification.', 1, 37, 1),
    ('Task Reminder', 'Reminder: You have a task due today.', 2, 38, 1),
    ('Product Review', 'You have received a review on your product.', 3, 39, 1),
    ('New Message Sent', 'A new message has been sent.', 1, 40, 1),
    ('Feedback Request', 'A request for feedback has been sent to you.', 2, 41, 1),
    ('New Recommendation', 'You have received a new recommendation.', 3, 42, 1),
    ('Document Reminder', 'Reminder: You have a document pending review.', 1, 43, 1),
    ('Account Deactivated', 'Your account has been deactivated.', 2, 44, 1),
    ('Event Cancellation', 'The event you were attending has been cancelled.', 3, 45, 1),
    ('New Message Alert', 'You have received a new message. Check your inbox.', 1, 46, 1),
    ('Task Overdue', 'Reminder: You have overdue tasks.', 2, 47, 1),
    ('Product Return Request', 'A return request for your product has been received.', 3, 48, 1),
    ('Document Expiration Notice', 'Notice: A document you have access to is expiring soon.', 1, 49, 1),
    ('Appointment Cancelled', 'Your appointment has been cancelled.', 2, 50, 1),
    ('Event Registration Confirmation', 'Your registration for an event has been confirmed.', 3, 1, 1);



-- Skapa 50 dataposter i UserPremium tabellen
INSERT INTO UserPremium (UserID, PremiumID, StartDate, EndDate, Active)
SELECT 
    u.UserID,
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), GETDATE()),
    DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), GETDATE()),
    1
FROM 
    [User] u
WHERE 
    u.UserID <= 50;

-- Skapa Premium tabell dataposter
INSERT INTO Premium (Name, Description, Price, Active)
VALUES 
    ('Premium Package 1', 'Description for Premium Package 1', 29.99, 1),
    ('Premium Package 2', 'Description for Premium Package 2', 39.99, 1),
    ('Premium Package 3', 'Description for Premium Package 3', 49.99, 1),
    ('Premium Package 4', 'Description for Premium Package 4', 59.99, 1),
    ('Premium Package 5', 'Description for Premium Package 5', 69.99, 1),
	('Premium Package 6', 'Description for Premium Package 6', 79.99, 1),
    ('Premium Package 7', 'Description for Premium Package 7', 89.99, 1),
    ('Premium Package 8', 'Description for Premium Package 8', 99.99, 1),
    ('Premium Package 9', 'Description for Premium Package 9', 109.99, 1),
    ('Premium Package 10', 'Description for Premium Package 10', 119.99, 1),
    ('Premium Package 11', 'Description for Premium Package 11', 129.99, 1),
    ('Premium Package 12', 'Description for Premium Package 12', 139.99, 1),
    ('Premium Package 13', 'Description for Premium Package 13', 149.99, 1),
    ('Premium Package 14', 'Description for Premium Package 14', 159.99, 1),
    ('Premium Package 15', 'Description for Premium Package 15', 169.99, 1),
    ('Premium Package 16', 'Description for Premium Package 16', 179.99, 1),
    ('Premium Package 17', 'Description for Premium Package 17', 189.99, 1),
    ('Premium Package 18', 'Description for Premium Package 18', 199.99, 1),
    ('Premium Package 19', 'Description for Premium Package 19', 209.99, 1),
    ('Premium Package 20', 'Description for Premium Package 20', 219.99, 1),
    ('Premium Package 21', 'Description for Premium Package 21', 229.99, 1),
    ('Premium Package 22', 'Description for Premium Package 22', 239.99, 1),
    ('Premium Package 23', 'Description for Premium Package 23', 249.99, 1),
    ('Premium Package 24', 'Description for Premium Package 24', 259.99, 1),
    ('Premium Package 25', 'Description for Premium Package 25', 269.99, 1),
    ('Premium Package 26', 'Description for Premium Package 26', 279.99, 1),
    ('Premium Package 27', 'Description for Premium Package 27', 289.99, 1),
    ('Premium Package 28', 'Description for Premium Package 28', 299.99, 1),
    ('Premium Package 29', 'Description for Premium Package 29', 309.99, 1),
    ('Premium Package 30', 'Description for Premium Package 30', 319.99, 1),
    ('Premium Package 31', 'Description for Premium Package 31', 329.99, 1),
    ('Premium Package 32', 'Description for Premium Package 32', 339.99, 1),
    ('Premium Package 33', 'Description for Premium Package 33', 349.99, 1),
    ('Premium Package 34', 'Description for Premium Package 34', 359.99, 1),
    ('Premium Package 35', 'Description for Premium Package 35', 369.99, 1),
    ('Premium Package 36', 'Description for Premium Package 36', 379.99, 1),
    ('Premium Package 37', 'Description for Premium Package 37', 389.99, 1),
    ('Premium Package 38', 'Description for Premium Package 38', 399.99, 1),
    ('Premium Package 39', 'Description for Premium Package 39', 409.99, 1),
    ('Premium Package 40', 'Description for Premium Package 40', 419.99, 1),
    ('Premium Package 41', 'Description for Premium Package 41', 429.99, 1),
    ('Premium Package 42', 'Description for Premium Package 42', 439.99, 1),
    ('Premium Package 43', 'Description for Premium Package 43', 449.99, 1),
    ('Premium Package 44', 'Description for Premium Package 44', 459.99, 1),
    ('Premium Package 45', 'Description for Premium Package 45', 469.99, 1),
    ('Premium Package 46', 'Description for Premium Package 46', 479.99, 1),
    ('Premium Package 47', 'Description for Premium Package 47', 489.99, 1),
    ('Premium Package 48', 'Description for Premium Package 48', 499.99, 1),
    ('Premium Package 49', 'Description for Premium Package 49', 509.99, 1),
    ('Premium Package 50', 'Description for Premium Package 50', 519.99, 1);

-- Skapa PremiumPayment tabell dataposter
INSERT INTO PremiumPayment (PaymentDate, Amount, PaymentMethod, UserID, Active)
SELECT 
    DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), GETDATE()),
    50.00,
    'Credit Card',
    u.UserID,
    1
FROM 
    [User] u
WHERE 
    u.UserID <= 50;

-- Skapa 50 slumpmässiga data poster för Event tabellen som matchar användarposter
INSERT INTO Event (Name, Description, StartDate, EndDate, Location, UserID)
SELECT TOP 50
    CONCAT('Event ', ROW_NUMBER() OVER (ORDER BY NEWID())),
    'Description for Event ' + CAST(ROW_NUMBER() OVER (ORDER BY NEWID()) AS NVARCHAR(10)),
    DATEADD(day, ABS(CHECKSUM(NEWID())) % 100, GETDATE()), -- Slumpmässig startdatum inom de senaste 100 dagarna
    DATEADD(day, ABS(CHECKSUM(NEWID())) % 100 + 1, GETDATE()), -- Slumpmässig slutdatum inom 1-100 dagar från startdatumet
    CONCAT('Location ', ABS(CHECKSUM(NEWID())) % 20 + 1), -- Slumpmässig plats från 1 till 20
    UserID
FROM [User]
ORDER BY NEWID(); -- Slumpmässig ordning av användareposter


-- EventLocation tabellen
INSERT INTO EventLocation (EventID, Address, City, Region, Country, Zipcode, Latitude, Longitude, Active)
VALUES
    (1, '123 Haunted Street', 'Spooksville', 'Ghost County', 'Transylvania', '12345', 47.12345, -122.12345, 1),
    (2, 'Town Square', 'Creepyville', 'Ghost County', 'Transylvania', '54321', 47.54321, -122.54321, 1),
    (3, '456 Scary Avenue', 'Creepyville', 'Ghost County', 'Transylvania', '67890', 47.67890, -122.67890, 1),
    (4, '789 Fright Road', 'Ghost Town', 'Ghost County', 'Transylvania', '98765', 47.98765, -122.98765, 1),
    (5, '101 Broomstick Lane', 'Witchingham', 'Witch County', 'Transylvania', '13579', 47.13579, -122.13579, 1);

-- EventAdvertisement tabellen
INSERT INTO EventAdvertisement (Title, Description, StartDate, EndDate, Price, Category, EventID, Active)
VALUES
    ('Haunted House Special Access Pass', 'Get VIP access to all attractions in the haunted house', '2024-10-31', '2024-11-01', 29.99, 'Tickets', 1, 1),
    ('Ghost Tour Group Discount', 'Book now for a special discount for groups of 4 or more', '2024-11-01', '2024-11-15', 49.99, 'Tickets', 2, 1),
    ('Horror Movie Marathon Early Bird Tickets', 'Limited early bird tickets available at a discounted price', '2024-10-01', '2024-10-24', 19.99, 'Tickets', 3, 1),
    ('Pumpkin Carving Contest Entry Fee', 'Register now to participate in the pumpkin carving contest', '2024-10-10', '2024-10-27', 9.99, 'Tickets', 4, 1),
    ('Witchcraft Workshop Premium Package', 'Upgrade to the premium package for exclusive materials and instruction', '2024-10-15', '2024-11-05', 39.99, 'Tickets', 5, 1);

-- EventAdType tabellen
INSERT INTO EventAdType (Name, Description)
VALUES
    ('Featured', 'Prominent placement for maximum visibility and exposure'),
    ('Discount', 'Special offer or reduced price for a limited time');

-- Partnership tabellen
INSERT INTO Partnership (Name, Description, HauntedPlaceID, PartnershipTypeID, Active)
VALUES
    ('Haunted House', 'Collaboration with a local haunted house attraction', 1, 1, 1),
    ('Ghost Tour Company', 'Partnership with a company offering guided ghost tours', 2, 2, 1),
    ('Horror Movie Theater', 'Joint promotion with a cinema specializing in horror films', 3, 1, 1),
    ('Community Center', 'Partnership with a community center hosting Halloween events', 4, 1, 1),
    ('Witchcraft School', 'Collaboration with a school teaching witchcraft and magic', 5, 1, 1);

-- PartnershipType tabellen
INSERT INTO PartnershipType (Name, Description)
VALUES
    ('Sponsorship', 'Financial support in exchange for promotional opportunities'),
    ('Collaboration', 'Mutual cooperation for shared benefits');

-- PartnershipContact tabellen
INSERT INTO PartnershipContact (ContactName, ContactEmail, ContactPhone, PartnershipID, Active)
VALUES
    ('John Doe', 'john.doe@example.com', '+1234567890', 1, 1),
    ('Jane Smith', 'jane.smith@example.com', '+9876543210', 2, 1),
    ('Michael Johnson', 'michael.johnson@example.com', '+1122334455', 3, 1),
    ('Emily Brown', 'emily.brown@example.com', '+9988776655', 4, 1),
    ('David Wilson', 'david.wilson@example.com', '+6677889900', 5, 1);

-- PartnershipAdvertisement tabellen
INSERT INTO PartnershipAdvertisement (Title, Description, StartDate, EndDate, Price, Category, AdTypeID, PartnershipTypeID, Active)
VALUES
    ('Haunted House Sponsorship', 'Become a sponsor and have your brand prominently featured at the haunted house', '2024-10-01', '2024-10-31', 499.99, 'Sponsorship', 1, 1, 1),
    ('Ghost Tour Package Deal', 'Offer a special package deal for customers booking the ghost tour', '2024-11-01', '2024-11-15', 399.99, 'Package Deal', 2, 2, 1),
    ('Horror Movie Theater Advertising', 'Advertise your product or service on the big screen before each movie screening', '2024-10-01', '2024-10-31', 299.99, 'Advertising', 1, 2, 1),
    ('Community Center Event Sponsorship', 'Support community events and gain exposure with event sponsorship', '2024-10-10', '2024-10-27', 199.99, 'Sponsorship', 2, 1, 1),
    ('Witchcraft School Workshop Partnership', 'Collaborate on workshops and classes for aspiring witches', '2024-10-15', '2024-11-05', 599.99, 'Partnership', 1, 1, 1);

-- PartnershipAdType tabellen
INSERT INTO PartnershipAdType (Name, Description)
VALUES
    ('Sponsorship', 'Financial support in exchange for promotional opportunities'),
    ('Package Deal', 'Special offer or bundle for customers'),
    ('Advertising', 'Promotion of products or services through advertisements'),
    ('Partnership', 'Mutual collaboration for shared benefits');

-- Skapa relation mellan User och Login tabellerna
ALTER TABLE Login
ADD CONSTRAINT FK_Login_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE Login
CHECK CONSTRAINT FK_Login_User;
GO

-- Skapa relation mellan User och Address tabellerna
ALTER TABLE Address
ADD CONSTRAINT FK_Address_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE Address
CHECK CONSTRAINT FK_Address_User;
GO

-- Skapa relation mellan User och UserCommunity tabellerna
ALTER TABLE UserCommunity
ADD CONSTRAINT FK_UserCommunity_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE UserCommunity
CHECK CONSTRAINT FK_UserCommunity_User;
GO

-- Skapa relation mellan Community och UserCommunity tabellerna
ALTER TABLE UserCommunity
ADD CONSTRAINT FK_UserCommunity_Community
FOREIGN KEY (CommunityID) REFERENCES Community(CommunityID);
GO
ALTER TABLE UserCommunity
CHECK CONSTRAINT FK_UserCommunity_Community;
GO

-- Skapa relation mellan User och Booking tabellerna
ALTER TABLE Booking
ADD CONSTRAINT FK_Booking_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE Booking
CHECK CONSTRAINT FK_Booking_User;
GO

-- Skapa relation mellan Booking och HauntedPlace tabellerna
ALTER TABLE HauntedPlace
ADD CONSTRAINT FK_HauntedPlace_Booking
FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);
GO
ALTER TABLE HauntedPlace
CHECK CONSTRAINT FK_HauntedPlace_Booking;
GO

-- Skapa relation mellan Payment och Booking tabellerna
ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_Booking
FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);
GO
ALTER TABLE Payment
CHECK CONSTRAINT FK_Payment_Booking;
GO

-- Skapa relation mellan UserAdvertisement och User tabellerna
ALTER TABLE UserAdvertisement
ADD CONSTRAINT FK_UserAdvertisement_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE UserAdvertisement
CHECK CONSTRAINT FK_UserAdvertisement_User;
GO

-- Lägg till CHECK CONSTRAINT för Advertisement tabellen
ALTER TABLE UserAdvertisement
ADD CONSTRAINT FK_UserAdvertisement_Advertisement
FOREIGN KEY (AdvertisementID) REFERENCES Advertisement(AdvertisementID);
GO
ALTER TABLE UserAdvertisement
CHECK CONSTRAINT FK_UserAdvertisement_Advertisement;
GO

-- Skapa relation mellan Review och User tabellerna
ALTER TABLE Review
ADD CONSTRAINT FK_Review_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE Review
CHECK CONSTRAINT FK_Review_User;
GO

-- Skapa relation mellan Review och Event tabellerna
ALTER TABLE Review
ADD CONSTRAINT FK_Review_Event
FOREIGN KEY (EventID) REFERENCES Event(EventID);
GO
ALTER TABLE Review
CHECK CONSTRAINT FK_Review_Event;
GO

-- Skapa relation mellan EventLocation och Event tabellerna
ALTER TABLE EventLocation
ADD CONSTRAINT FK_EventLocation_Event
FOREIGN KEY (EventID) REFERENCES Event(EventID);
GO
ALTER TABLE EventLocation
CHECK CONSTRAINT FK_EventLocation_Event;
GO

-- Skapa relation mellan EventAdvertisement och Event tabellerna
ALTER TABLE EventAdvertisement
ADD CONSTRAINT FK_EventAdvertisement_Event
FOREIGN KEY (EventID) REFERENCES Event(EventID);
GO
ALTER TABLE EventAdvertisement
CHECK CONSTRAINT FK_EventAdvertisement_Event;
GO

-- Skapa relation mellan Partnership och HauntedPlace tabellerna
ALTER TABLE Partnership
ADD CONSTRAINT FK_Partnership_HauntedPlace
FOREIGN KEY (HauntedPlaceID) REFERENCES HauntedPlace(HauntedPlaceID);
GO
ALTER TABLE Partnership
CHECK CONSTRAINT FK_Partnership_HauntedPlace;
GO

-- Skapa relation mellan Partnership och PartnershipType tabellerna
ALTER TABLE Partnership
ADD CONSTRAINT FK_Partnership_PartnershipType
FOREIGN KEY (PartnershipTypeID) REFERENCES PartnershipType(PartnershipType);
GO
ALTER TABLE Partnership
CHECK CONSTRAINT FK_Partnership_PartnershipType;
GO

-- Skapa relation mellan PartnershipContact och Partnership tabellerna
ALTER TABLE PartnershipContact
ADD CONSTRAINT FK_PartnershipContact_Partnership
FOREIGN KEY (PartnershipID) REFERENCES Partnership(PartnershipID);
GO

-- Kontrollera constraint
ALTER TABLE PartnershipContact
CHECK CONSTRAINT FK_PartnershipContact_Partnership;
GO

ALTER TABLE PartnershipAdvertisement
DROP CONSTRAINT IF EXISTS FK_PartnershipAdvertisement_PartnershipType;
GO
-- Skapa relation mellan PartnershipAdvertisement och Partnership tabellerna
ALTER TABLE PartnershipAdvertisement
ADD CONSTRAINT FK_PartnershipAdvertisement_PartnershipType
FOREIGN KEY (PartnershipTypeID) REFERENCES PartnershipType(PartnershipType);

GO

-- Kontrollera constraint
ALTER TABLE PartnershipAdvertisement
CHECK CONSTRAINT FK_PartnershipAdvertisement_PartnershipType;
GO

-- Skapa relation mellan PartnershipAdvertisement och PartnershipAdType tabellerna
ALTER TABLE PartnershipAdvertisement
ADD CONSTRAINT FK_PartnershipAdvertisement_PartnershipAdType
FOREIGN KEY (AdTypeID) REFERENCES PartnershipAdType(PartnershipAdTypeID);
GO
ALTER TABLE PartnershipAdvertisement
CHECK CONSTRAINT FK_PartnershipAdvertisement_PartnershipAdType;
GO

-- Skapa relation mellan HauntedPlace och HauntedPlaceLocation tabellerna
ALTER TABLE HauntedPlaceLocation
ADD CONSTRAINT FK_HauntedPlace_HauntedPlaceLocation
FOREIGN KEY (HauntedPlaceID) REFERENCES HauntedPlace(HauntedPlaceID);
GO
ALTER TABLE HauntedPlaceLocation
CHECK CONSTRAINT FK_HauntedPlace_HauntedPlaceLocation;
GO

-- Skapa relation mellan AdType och HauntedPlace tabellerna
ALTER TABLE AdType
ADD CONSTRAINT FK_AdType_HauntedPlace
FOREIGN KEY (HauntedPlaceID) REFERENCES HauntedPlace(HauntedPlaceID);
GO
ALTER TABLE AdType
CHECK CONSTRAINT FK_AdType_HauntedPlace;
GO

-- Skapa relation mellan HauntedPlaceAdvertisement och HauntedPlace tabellerna
--ALTER TABLE HauntedPlaceAdvertisement
--ADD CONSTRAINT FK_HauntedPlaceAdvertisement_HauntedPlace
--FOREIGN KEY (HauntedPlaceID) REFERENCES HauntedPlace(HauntedPlaceID);
--GO
--ALTER TABLE HauntedPlaceAdvertisement
--CHECK CONSTRAINT FK_HauntedPlaceAdvertisement_HauntedPlace;
--GO

-- Skapa relation mellan ResourceType och Resource tabellerna
ALTER TABLE Resource
ADD CONSTRAINT FK_Resource_ResourceType
FOREIGN KEY (ResourceTypeID) REFERENCES ResourceType(ResourceID);
GO
ALTER TABLE Resource
CHECK CONSTRAINT FK_Resource_ResourceType;
GO

-- Skapa relation mellan Resource och HauntedPlace tabellerna
ALTER TABLE Resource
ADD CONSTRAINT FK_Resource_HauntedPlace
FOREIGN KEY (HauntedPlaceID) REFERENCES HauntedPlace(HauntedPlaceID);
GO
ALTER TABLE Resource
CHECK CONSTRAINT FK_Resource_HauntedPlace;
GO

-- Skapa relation mellan Notification och User tabellerna
ALTER TABLE Notification
ADD CONSTRAINT FK_Notification_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE Notification
CHECK CONSTRAINT FK_Notification_User;
GO

-- Skapa relation mellan Notification och NotificationType tabellerna
ALTER TABLE Notification
ADD CONSTRAINT FK_Notification_NotificationType
FOREIGN KEY (NotificationTypeID) REFERENCES NotificationType(NotificationTypeID);
GO
ALTER TABLE Notification
CHECK CONSTRAINT FK_Notification_NotificationType;
GO

-- Skapa relation mellan UserPremium och User tabellerna
ALTER TABLE UserPremium
ADD CONSTRAINT FK_UserPremium_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE UserPremium
CHECK CONSTRAINT FK_UserPremium_User;
GO

-- Skapa relation mellan UserPremium och Premium tabellerna
ALTER TABLE UserPremium
DROP CONSTRAINT IF EXISTS FK_UserPremium_Premium;
GO
ALTER TABLE UserPremium
ADD CONSTRAINT FK_UserPremium_Premium
FOREIGN KEY (PremiumID) REFERENCES Premium(PremiumID);
GO
ALTER TABLE UserPremium
CHECK CONSTRAINT FK_UserPremium_Premium;
GO

-- Skapa relation mellan PremiumPayment och User tabellerna
ALTER TABLE PremiumPayment
ADD CONSTRAINT FK_PremiumPayment_User
FOREIGN KEY (UserID) REFERENCES [User](UserID);
GO
ALTER TABLE PremiumPayment
CHECK CONSTRAINT FK_PremiumPayment_User;
GO
