IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PhantomFestivitiesOld')
BEGIN
    CREATE DATABASE PhantomFestivitiesOld;
END
GO
USE PhantomFestivitiesOld;
GO

-- skapar tabeller
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    CHECK (DateOfBirth < GETDATE()),
    Phonenumber VARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    CHECK (Email LIKE '%_@_%._%'),
    Active BIT NOT NULL
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
    CustomerID INT NOT NULL,
);

CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    NumberOfTickets INT NOT NULL,
    CHECK (NumberOfTickets > 0),
    TotalPrice DECIMAL(10,2) NOT NULL,
    CHECK (TotalPrice >= 0),
    CustomerID INT NOT NULL,
    Cancelled BIT NOT NULL
    CHECK (Cancelled IN (0,1))
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    Rating INT NOT NULL,
    Text NVARCHAR(300) NOT NULL,
    ReviewDate DATE NOT NULL,
    CustomerID INT,
    EventID INT,
    ProductID INT,
--FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), -- Kan vara null om det inte finns en koppling till en kund
--FOREIGN KEY (EventID) REFERENCES Event(EventID),
--FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    --CONSTRAINT CHK_Review_CustomerObject CHECK (
      --  (CustomerID IS NOT NULL AND (EventID IS NULL AND ProductID IS NULL)) OR
        --(CustomerID IS NULL AND (EventID IS NOT NULL OR ProductID IS NOT NULL))
    --)
    --CONSTRAINT CHK_Review_ObjectType CHECK (
      --  (EventID IS NOT NULL AND ProductID IS NULL) OR
       -- (ProductID IS NOT NULL AND EventID IS NULL)
    
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    Description NVARCHAR(500) NOT NULL,   
    OrderID INT,    
    SupplierID INT NOT NULL,
    ReviewID INT, -- Kan vara null om det inte finns en recension
	ProductCategoryID INT NOT NULL,
    Active BIT NOT NULL
); -- fortsätt här med att skapa data

CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    LocationType NVARCHAR(100),
    ScareLevel NVARCHAR(50),
    PriceRange NVARCHAR(50)
);

CREATE TABLE ProductLocation (
    ProductLocationID INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
	ProductID INT NOT NULL,
    Active BIT NOT NULL
);

CREATE TABLE Sale (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    SaleDate DATE NOT NULL,
	QuantitySold INT NOT NULL,
	TotalPrice DECIMAL(15,2) NOT NULL,
    ProductID INT NOT NULL,
	OrderID INT
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    OrderID INT, -- Kan vara null om det inte finns någon order
    ReviewID INT, -- Kan vara null om det inte finns en recension
    Active BIT NOT NULL
);

CREATE TABLE EventLocation (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(20) NOT NULL,
    Latitude DECIMAL(7,5) NOT NULL,
    Longitude DECIMAL (8,5) NOT NULL,
	EventID INT NOT NULL
);

CREATE TABLE Supplier (
	SupplierID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Role NVARCHAR(20) NOT NULL,
	ProductID INT NOT NULL,
	Active BIT NOT NULL
);

CREATE TABLE SupplierType (
	SupplierTypeID INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(300) NOT NULL,
	SupplierID INT NOT NULL
);


-- insert data
-- Skapa användare från Sverige
INSERT INTO Customer(FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Erik', 'Andersson', '1985-05-10', '0701234567', 'erik@example.com', 1),
       ('Anna', 'Johansson', '1990-08-15', '0707654321', 'anna@example.com', 1),
       ('Lisa', 'Nilsson', '1982-12-20', '0705554444', 'lisa@example.com', 1),
       ('Johan', 'Lindgren', '1993-08-07', '0708889999', 'johan@example.com', 1),
       ('Emma', 'Svensson', '1986-12-12', '0701112222', 'emma@example.com', 1),
       ('David', 'Eriksson', '1979-05-25', '0703334444', 'david@example.com', 1),
	   ('Lars', 'Jansson', '1984-07-15', '0704445555', 'lars@example.com', 1),
	   ('Maria', 'Andersson', '1991-03-20', '0706667777', 'maria.a@example.com', 1);

-- Skapa användare från Tyskland
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Michael', 'Müller', '1978-04-25', '01761234567', 'michael@example.com', 1),
       ('Sarah', 'Schmidt', '1989-10-12', '01767654321', 'sarah@example.com', 1),
       ('Stefan', 'Wagner', '1983-06-08', '01765554444', 'stefan@example.com',  1),
       ('Andreas', 'Schneider', '1982-10-30', '01768888888', 'andreas@example.com',  1),
       ('Julia', 'Becker', '1990-06-15', '01769999999', 'julia@example.com', 1),
       ('Sabine', 'Schulz', '1985-04-18', '01767777777', 'sabine@example.com', 1),
	   ('Andrea', 'Becker', '1983-05-12', '01761234567', 'andrea@example.com', 1),
		('Matthias', 'Schneider', '1990-09-18', '01767654321', 'matthias@example.com', 1);

-- Skapa användare från Polen
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Katarzyna', 'Nowak', '1980-07-15', '123456789', 'katarzyna@example.com', 1),
       ('Piotr', 'Kowalski', '1995-02-28', '987654321', 'piotr@example.com',  1),
       ('Magdalena', 'Wiśniewska', '1987-11-03', '543216789', 'magdalena@example.com', 1),
       ('Tomasz', 'Wojcik', '1976-03-05', '123987456', 'tomasz@example.com', 1),
       ('Agnieszka', 'Kowalczyk', '1989-09-20', '789654123', 'agnieszka@example.com', 1),
       ('Marek', 'Jankowski', '1983-07-10', '456123789', 'marek@example.com', 1),
	   ('Łukasz', 'Kowalczyk', '1978-12-28', '123456789', 'lukasz@example.com', 1),
    ('Monika', 'Nowak', '1993-05-10', '987654321', 'monika@example.com', 1);

-- Skapa användare från Frankrike
INSERT INTO Customer(FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Jean', 'Dubois', '1975-09-30', '0601020304', 'jean@example.com', 1),
       ('Marie', 'Lefèvre', '1988-03-14', '0604050607', 'marie@example.com', 1),
       ('Pierre', 'Leroy', '1992-11-22', '0607080910', 'pierre@example.com', 1),
       ('Sophie', 'Martin', '1984-11-15', '0609998888', 'sophie@example.com', 1),
       ('Nicolas', 'Lefebvre', '1995-02-28', '0608889999', 'nicolas@example.com', 1),
       ('Isabelle', 'Roux', '1980-06-25', '0607778888', 'isabelle@example.com', 1),
	   ('Étienne', 'Dupont', '1982-10-15', '0601020304', 'etienne@example.com', 1),
    ('Camille', 'Leclerc', '1990-04-22', '0604050607', 'camille@example.com', 1);

-- Skapa användare från Spanien
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Manuel', 'García', '1984-01-20', '612345678', 'manuel@example.com', 1),
       ('Sofía', 'Martínez', '1996-05-05', '654321987', 'sofia@example.com', 1),
       ('Alejandro', 'López', '1979-08-12', '698745632', 'alejandro@example.com', 1),
       ('Carlos', 'Hernández', '1977-04-10', '612345678', 'carlos@example.com', 1),
       ('Laura', 'Gómez', '1989-08-22', '654321987', 'laura@example.com', 1),
       ('Javier', 'Díaz', '1982-01-18', '698745632', 'javier@example.com', 1),
	   ('Pablo', 'Rodríguez', '1979-11-25', '612345678', 'pablo@example.com', 1),
    ('Elena', 'González', '1991-06-30', '654321987', 'elena@example.com', 1),
	('Laura', 'Díaz', '1982-06-10', '654321987', 'laura@example.com', 1);

-- Skapa användare från Italien
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES ('Giuseppe', 'Rossi', '1986-03-18', '3351234567', 'giuseppe@example.com', 1),
       ('Maria', 'Russo', '1991-07-22', '3387654321', 'maria@example.com', 1),
       ('Antonio', 'Ferrari', '1980-12-10', '3398765432', 'antonio@example.com', 1),
       ('Paolo', 'Conti', '1978-09-20', '3351234567', 'paolo@example.com', 1),
       ('Laura', 'Galli', '1990-07-15', '3387654321', 'laura@example.com', 1),
       ('Giovanni', 'Ricci', '1985-12-30', '3398765432', 'giovanni@example.com', 1),
	   ('Francesco', 'Moretti', '1983-04-18', '3351234567', 'francesco@example.com', 1),
    ('Giulia', 'Ferrari', '1992-09-22', '3387654321', 'giulia@example.com', 1),
	('Luca', 'Ricci', '1985-12-10', '3398765432', 'luca@example.com', 1);

-- Skapa bokningar för de 50 användarna
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    -- Bokningar för användare från Sverige
    ('2024-04-22', 2, 100.00, 1, 0), 
    ('2024-04-23', 1, 50.00, 2, 0),
    ('2024-04-24', 3, 150.00, 3, 0),
    ('2024-04-25', 2, 100.00, 4, 0),
    ('2024-04-26', 1, 50.00, 5, 0),
    ('2024-04-27', 3, 150.00, 6, 1), 
	-- Bokningar för användare från Tyskland
    ('2024-04-22', 2, 100.00, 7, 1),
	('2024-04-23', 1, 50.00, 8, 1),
    ('2024-04-24', 3, 150.00, 9, 1),
    ('2024-04-25', 2, 100.00, 10, 1),
    ('2024-04-26', 1, 50.00, 11, 1), 
    ('2024-04-27', 3, 150.00, 12, 1),

    -- Bokningar för användare från Polen
    ('2024-04-22', 2, 100.00, 13, 1),
    ('2024-04-23', 1, 50.00, 14, 1), 
    ('2024-04-24', 3, 150.00, 15, 1),
    ('2024-04-25', 2, 100.00, 16, 1),
    ('2024-04-26', 1, 50.00, 17, 1), 
    ('2024-04-27', 3, 150.00, 18, 1),

    -- Bokningar för användare från Frankrike
    ('2024-04-22', 2, 100.00, 19, 1),
    ('2024-04-23', 1, 50.00, 20, 1), 
    ('2024-04-24', 3, 150.00, 21, 1),
    ('2024-04-25', 2, 100.00, 22, 1),
    ('2024-04-26', 1, 50.00, 23, 1), 
    ('2024-04-27', 3, 150.00, 24, 1),

    -- Bokningar för användare från Spanien
    ('2024-04-22', 2, 100.00, 25, 1),
    ('2024-04-23', 1, 50.00, 26, 1), 
    ('2024-04-24', 3, 150.00, 27, 1),
    ('2024-04-25', 2, 100.00, 28, 1),
    ('2024-04-26', 1, 50.00, 29, 1), 
    ('2024-04-27', 3, 150.00, 30, 1),

    -- Bokningar för användare från Italien
    ('2024-04-22', 2, 100.00, 31, 1),
    ('2024-04-23', 1, 50.00, 32, 1), 
    ('2024-04-24', 3, 150.00, 33, 1),
    ('2024-04-25', 2, 100.00, 34, 1),
    ('2024-04-26', 1, 50.00, 35, 1),
    ('2024-04-27', 3, 150.00, 36, 1);



-- Skapa adresser för användare från Sverige
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Storgatan 1', 'Stockholm', 'Stockholms län', 'Sverige', '11111', 1, 1), -- Användare: swedishuser1
    ('Gustav Adolfs Torg 2', 'Göteborg', 'Västra Götalands län', 'Sverige', '22222', 2, 1), -- Användare: swedishuser2
    ('Östra Storgatan 3', 'Malmö', 'Skåne län', 'Sverige', '33333', 3, 1), -- Användare: swedishuser3
    ('Drottninggatan 4', 'Uppsala', 'Uppsala län', 'Sverige', '44444', 4, 1), -- Användare: swedishuser4
    ('Kungsgatan 5', 'Linköping', 'Östergötlands län', 'Sverige', '55555', 5, 1), -- Användare: swedishuser5
    ('Södra Hamngatan 6', 'Helsingborg', 'Skåne län', 'Sverige', '66666', 6, 1); -- Användare: swedishuser6

-- Skapa adresser för användare från Tyskland
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Hauptstraße 1', 'Berlin', 'Berlin', 'Tyskland', '10115', 7, 1), -- Användare: germanuser1
    ('Königstraße 2', 'Hamburg', 'Hamburg', 'Tyskland', '20095', 8, 1), -- Användare: germanuser2
    ('Marktplatz 3', 'München', 'Bayern', 'Tyskland', '80331', 9, 1), -- Användare: germanuser3
    ('Bahnhofstraße 4', 'Köln', 'Nordrhein-Westfalen', 'Tyskland', '50667', 10, 1), -- Användare: germanuser4
    ('Schloßstraße 5', 'Frankfurt am Main', 'Hessen', 'Tyskland', '60313', 11, 1), -- Användare: germanuser5
    ('Marktstraße 6', 'Stuttgart', 'Baden-Württemberg', 'Tyskland', '70173', 12, 1); -- Användare: germanuser6

-- Skapa adresser för användare från Polen
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Nowy Świat 1', 'Warszawa', 'Mazowieckie', 'Polen', '00-002', 13, 1), -- Användare: polishuser1
    ('Plac Zbawiciela 2', 'Kraków', 'Małopolskie', 'Polen', '31-001', 14, 1), -- Användare: polishuser2
    ('Plac Grzybowski 3', 'Łódź', 'Łódzkie', 'Polen', '90-001', 15, 1), -- Användare: polishuser3
    ('Plac Wolności 4', 'Wrocław', 'Dolnośląskie', 'Polen', '50-001', 16, 1), -- Användare: polishuser4
    ('Rynek 5', 'Poznań', 'Wielkopolskie', 'Polen', '61-001', 17, 1), -- Användare: polishuser5
    ('Aleja Niepodległości 6', 'Gdańsk', 'Pomorskie', 'Polen', '80-001', 18, 1); -- Användare: polishuser6

-- Skapa adresser för användare från Frankrike
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Rue de la République 1', 'Paris', 'Île-de-France', 'Frankrike', '75001', 19, 1), -- Användare: frenchuser1
    ('Rue du Faubourg Saint-Honoré 2', 'Paris', 'Île-de-France', 'Frankrike', '75008', 20, 1), -- Användare: frenchuser2
    ('Rue de Rivoli 3', 'Paris', 'Île-de-France', 'Frankrike', '75004', 21, 1), -- Användare: frenchuser3
    ('Place de la Concorde 4', 'Paris', 'Île-de-France', 'Frankrike', '75008', 22, 1), -- Användare: frenchuser4
    ('Avenue des Champs-Élysées 5', 'Paris', 'Île-de-France', 'Frankrike', '75008', 23, 1), -- Användare: frenchuser5
    ('Avenue de la République 6', 'Paris', 'Île-de-France', 'Frankrike', '75011', 24, 1); -- Användare: frenchuser6

-- Skapa adresser för användare från Spanien
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Calle Mayor 1', 'Madrid', 'Madrid', 'Spanien', '28001', 25, 1), -- Användare: spanishuser1
    ('Paseo de la Castellana 2', 'Madrid', 'Madrid', 'Spanien', '28046', 26, 1), -- Användare: spanishuser2
    ('Gran Vía 3', 'Madrid', 'Madrid', 'Spanien', '28013', 27, 1), -- Användare: spanishuser3
    ('Calle de Alcalá 4', 'Madrid', 'Madrid', 'Spanien', '28014', 28, 1), -- Användare: spanishuser4
    ('Calle de Serrano 5', 'Madrid', 'Madrid', 'Spanien', '28006', 29, 1), -- Användare: spanishuser5
    ('Paseo del Prado 6', 'Madrid', 'Madrid', 'Spanien', '28014', 30, 1); -- Användare: spanishuser6

-- Skapa adresser för användare från Italien
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Via Roma 1', 'Rom', 'Lazio', 'Italien', '00184', 31, 1), -- Användare: italianuser1
    ('Via Monte Napoleone 2', 'Milano', 'Lombardiet', 'Italien', '20121', 32, 1), -- Användare: italianuser2
    ('Via della Spiga 3', 'Milano', 'Lombardiet', 'Italien', '20121', 33, 1), -- Användare: italianuser3
    ('Piazza San Marco 4', 'Venedig', 'Veneto', 'Italien', '30124', 34, 1), -- Användare: italianuser4
    ('Via Veneto 5', 'Rom', 'Lazio', 'Italien', '00187', 35, 1), -- Användare: italianuser5
    ('Corso Vittorio Emanuele II 6', 'Rom', 'Lazio', 'Italien', '00186', 36, 1); -- Användare: italianuser6

-- Skapa 20 dataposter för recensioner
INSERT INTO Review (Rating, Text, ReviewDate, CustomerID, EventID)
VALUES 
    ('5', 'Great experience, highly recommended!', '2024-04-22', 1, 6), 
    ('4', 'Enjoyed the event, but could be improved', '2024-04-23', 2, 7), 
    ('3', 'Average experience, nothing special', '2024-04-24', 3, 8),
    ('5', 'Absolutely terrifying, loved it!', '2024-04-25', 4, 9), 
    ('2', 'Disappointing, not worth the money', '2024-04-26', 5, 25), 
    ('5', 'Best haunted house I have ever been to!', '2024-04-27', 6, 16), 
    ('4', 'Spooky atmosphere, but too crowded', '2024-04-28', 7, 7), 
    ('3', 'Expected more scares, was a bit disappointed', '2024-04-29', 8, 8),
    ('5', 'Fantastic event, exceeded my expectations', '2024-04-30', 9, 19), 
    ('2', 'Not scary at all, waste of time', '2024-05-01', 10, 10), 
    ('5', 'Incredible experience, will definitely come back', '2024-05-02', 11, 21), 
    ('4', 'Good scares, but too short', '2024-05-03', 12, 12), 
    ('5', 'Absolutely terrifying, worth every penny', '2024-05-04', 1, 13),
    ('3', 'Expected more from the event, was a bit disappointed', '2024-05-05', 2, 14), 
    ('4', 'Fun experience, but could be scarier', '2024-05-06', 3, 15), 
    ('5', 'Spine-chilling experience, loved every moment', '2024-05-07', 4, 16), 
    ('2', 'Not worth the money, very disappointed', '2024-05-08', 5, 17), 
    ('5', 'One of the best haunted houses I have visited', '2024-05-09', 6, 18), 
    ('4', 'Scary, but wish there were more interactive elements', '2024-05-10', 7, 19), 
    ('3', 'Expected better, left feeling underwhelmed', '2024-05-11', 8, 20),
	('5', 'The haunted place was absolutely terrifying, would recommend!', '2024-05-12', 9, 21), 
    ('4', 'Great atmosphere, but wish there were more scares', '2024-05-13', 10, 22),
    ('3', 'Decent event, but could be improved', '2024-05-14', 11, 23),
    ('5', 'One of the best haunted experiences I have had!', '2024-05-15', 12, 24),
    ('4', 'Scary, but not as much as I expected', '2024-05-16', 1, 25),
    ('5', 'Absolutely terrifying, worth every penny', '2024-05-17', 2, 26), 
    ('3', 'Expected more scares, was a bit let down', '2024-05-18', 3, 27), 
    ('4', 'Good scares, but wish it was longer', '2024-05-19', 4, 28),
    ('5', 'Absolutely terrifying, loved every moment', '2024-05-20', 5, 29),
    ('2', 'Not scary at all, very disappointed', '2024-05-21', 6, 30); 

-- Skapa 20 dataposter för betalningar
INSERT INTO Sale (SaleDate, TotalPrice, QuantitySold, OrderID)
VALUES 
    ('2024-04-22 12:30:00', 50.00, 'Credit Card', 1, 1),
    ('2024-04-23 13:45:00', 100.00, 'PayPal', 2, 1), 
    ('2024-04-24 14:20:00', 75.00, 'Credit Card', 3, 1), 
    ('2024-04-25 15:10:00', 120.00, 'PayPal', 4, 1), 
    ('2024-04-26 16:00:00', 30.00, 'Credit Card', 5, 1),
    ('2024-04-27 17:30:00', 80.00, 'PayPal', 6, 1), 
    ('2024-04-28 18:45:00', 60.00, 'Credit Card', 7, 1), 
    ('2024-04-29 19:20:00', 90.00, 'PayPal', 8, 1),
    ('2024-04-30 20:15:00', 110.00, 'Credit Card', 9, 1), 
    ('2024-05-01 21:00:00', 40.00, 'PayPal', 10, 1), 
    ('2024-05-02 22:30:00', 70.00, 'Credit Card', 11, 1), 
    ('2024-05-03 23:55:00', 85.00, 'PayPal', 12, 1), 
    ('2024-05-04 11:20:00', 55.00, 'Credit Card', 13, 1), 
    ('2024-05-05 12:45:00', 95.00, 'PayPal', 14, 1), 
    ('2024-05-06 13:30:00', 65.00, 'Credit Card', 15, 1),
    ('2024-05-07 14:20:00', 130.00, 'PayPal', 16, 1), 
    ('2024-05-08 15:10:00', 45.00, 'Credit Card', 17, 1), 
    ('2024-05-09 16:30:00', 75.00, 'PayPal', 18, 1), 
    ('2024-05-10 17:45:00', 70.00, 'Credit Card', 19, 1), 
    ('2024-05-11 18:20:00', 100.00, 'PayPal', 20, 1); 

-- Skapa 30 dataposter för hemsökta platser
INSERT INTO Product (Name, Description, OrderID, SupplierID, Active)
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
 

-- Skapa 30 dataposter i HauntedPlaceLocation med riktiga platser
INSERT INTO ProductLocation(Address, City, Region, Country, Zipcode, Latitude, Longitude, ProductID, Active)
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


-- Skapa data för Event-tabellen
INSERT INTO Event (Name, Description, StartDate, EndDate, Location, OrderID, ReviewID, Active)
VALUES 
    ('Spökvandring på Skogskyrkogården', 'En skrämmande vandring genom Skogskyrkogården med spökguidning.', '2024-10-31 19:00:00', '2024-10-31 21:00:00', 'Skogskyrkogården, Stockholm', NULL, NULL, 1),
    ('Halloween-fest på Chillingham Castle', 'En oförglömlig Halloween-fest på det hemsökta slottet Chillingham Castle.', '2024-10-31 20:00:00', '2024-11-01 02:00:00', 'Chillingham Castle, Northumberland', NULL, NULL, 1),
    ('Guidad tur på Bran Castle', 'En spännande guidetur genom Draculas slott, Bran Castle.', '2024-10-31 15:00:00', '2024-10-31 17:00:00', 'Bran Castle, Bran', NULL, NULL, 1);




-- Skapa data för EventLocation-tabellen
INSERT INTO EventLocation (Address, City, Region, Country, Zipcode, Latitude, Longitude, EventID)
VALUES 
    ('Skogskyrkogården', 'Stockholm', 'Stockholm County', 'Sweden', '12345', 59.2985, 18.0713, 1),
    ('Chillingham Castle', 'Alnwick', 'Northumberland', 'United Kingdom', 'NE66 5NJ', 55.5077, -1.8717, 2),
    ('Bran Castle', 'Bran', 'Brasov', 'Romania', '507025', 45.5143, 25.3672, 3);


-- Skapa data för Supplier-tabellen
INSERT INTO Supplier (Name, Role, ProductID, Active)
VALUES 
    ('Spökguiden AB', 'Eventorganisatör', 1, 1),
    ('Chillingham Castle Events Ltd', 'Eventorganisatör', 2, 1),
    ('Dracula Tours Ltd', 'Eventorganisatör', 3, 1);

-- Skapa data för SupplierType-tabellen
INSERT INTO SupplierType (Name, Description, SupplierID)
VALUES 
    ('Spökguidning', 'Organiserar spökvandringar och hemsökta evenemang.', 1),
    ('Slottsarrangör', 'Arrangerar evenemang och fester på historiska slott.', 2),
    ('Guidade turer', 'Organiserar guidade turer och evenemang relaterade till Dracula.', 3);

-- Skapa relationer
ALTER TABLE Address
ADD CONSTRAINT FK_Customer_Address
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO
ALTER TABLE Address
CHECK CONSTRAINT FK_Customer_Address;
GO

ALTER TABLE Review
ADD CONSTRAINT FK_Customer_Review
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO
ALTER TABLE Review
CHECK CONSTRAINT FK_Customer_Review;
GO

ALTER TABLE Product
ADD CONSTRAINT FK_Product_ProductCategory
FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(CategoryID);

ALTER TABLE Product
CHECK CONSTRAINT FK_Product_ProductCategory;
GO

ALTER TABLE ProductLocation
ADD CONSTRAINT FK_Product_ProductLocation
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

ALTER TABLE Product
CHECK CONSTRAINT FK_Product_ProductCategory;
GO

ALTER TABLE Product
ADD CONSTRAINT FK_Product_Order
FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);

ALTER TABLE Product
CHECK CONSTRAINT FK_Product_Order;
GO

ALTER TABLE Sale
ADD CONSTRAINT FK_Product_Sale
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

ALTER TABLE Sale
CHECK CONSTRAINT FK_Product_Sale;
GO

ALTER TABLE Event
ADD CONSTRAINT FK_Order_Event
FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);

ALTER TABLE Event
CHECK CONSTRAINT FK_Order_Event;
GO

ALTER TABLE Event
ADD CONSTRAINT FK_Review_Event
FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID);

ALTER TABLE Event
CHECK CONSTRAINT FK_Review_Event;
GO

ALTER TABLE EventLocation
ADD CONSTRAINT FK_Event_EventLocation
FOREIGN KEY (EventID) REFERENCES Event(EventID);

ALTER TABLE EventLocation
CHECK CONSTRAINT FK_Event_EventLocation;
GO

ALTER TABLE Supplier
ADD CONSTRAINT FK_Product_Supplier
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

ALTER TABLE Supplier
CHECK CONSTRAINT FK_Product_Supplier;
GO

ALTER TABLE SupplierType
ADD CONSTRAINT FK_Supplier_SupplierType
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

ALTER TABLE SupplierType
CHECK CONSTRAINT FK_Supplier_SupplierType;
GO