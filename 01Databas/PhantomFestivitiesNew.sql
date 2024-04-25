IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PhantomFestivities')
BEGIN
    CREATE DATABASE PhantomFestivities;
END
GO
USE PhantomFestivities;
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
    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,
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
--insert data
-- Kunder från Sverige
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES 
    ('Elsa', 'Andersson', '1990-01-01', '+46701234567', 'elsa.andersson@sverige.com', 1),
    ('Anna', 'Larsson', '1985-03-15', '+46781234567', 'anna.larsson@sverige.com', 1),
    ('Johan', 'Nilsson', '1980-06-20', '+4689123456', 'johan.nilsson@sverige.com', 1),
    ('Emma', 'Eriksson', '1975-09-25', '+46701234568', 'emma.eriksson@sverige.com', 1),
    ('Oscar', 'Karlsson', '1970-12-30', '+46781234569', 'oscar.karlsson@sverige.com', 1),
    ('Ida', 'Svensson', '1991-02-14', '+4689123457', 'ida.svensson@sverige.com', 1),
    ('Erik', 'Gustavsson', '1986-05-21', '+46701234570', 'erik.gustavsson@sverige.com', 1),
    ('Maria', 'Johansson', '1993-08-17', '+4689123458', 'maria.johansson@sverige.com', 1),
    ('Andreas', 'Persson', '1988-11-02', '+46701234571', 'andreas.persson@sverige.com', 1),
    ('Sofia', 'Lindberg', '1983-04-05', '+46781234572', 'sofia.lindberg@sverige.com', 1),
    ('Karl', 'Berg', '1978-07-10', '+4689123459', 'karl.berg@sverige.com', 1),
    ('Emelie', 'Sjöberg', '1973-10-15', '+46701234573', 'emelie.sjoberg@sverige.com', 1),
    ('Peter', 'Holm', '1994-01-20', '+46781234574', 'peter.holm@sverige.com', 1),
    ('Hanna', 'Nordström', '1989-04-25', '+4689123460', 'hanna.nordstrom@sverige.com', 1),
    ('Magnus', 'Ek', '1984-07-30', '+46701234575', 'magnus.ek@sverige.com', 1),
    ('Sara', 'Sandberg', '1979-11-04', '+46781234576', 'sara.sandberg@sverige.com', 1),
	('Peter', 'Eriksson', '1993-02-20', '0765432109', 'peter.eriksson@example.com', 1),
    ('Sara', 'Persson', '1995-06-30', '0732109876', 'sara.persson@example.com', 1),
    ('Daniel', 'Gustavsson', '1989-04-18', '0790123456', 'daniel.gustavsson@example.com', 1);

-- Kunder från Polen
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES 
    ('Kamil', 'Nowak', '1990-02-20', '+48600123456', 'kamil.nowak@polen.com', 1),
    ('Piotr', 'Kowalski', '1985-05-25', '+48650987654', 'piotr.kowalski@polen.com', 1),
    ('Karolina', 'Duda', '1980-08-30', '+48765432109', 'karolina.duda@polen.com', 1),
    ('Aleksandra', 'Wójcik', '1975-11-05', '+48500987654', 'aleksandra.wojcik@polen.com', 1),
    ('Michał', 'Kamiński', '1991-01-10', '+48600123457', 'michal.kaminski@polen.com', 1),
    ('Monika', 'Lewandowska', '1986-04-15', '+48650987655', 'monika.lewandowska@polen.com', 1),
    ('Tomasz', 'Zieliński', '1981-07-20', '+48765432110', 'tomasz.zielinski@polen.com', 1),
    ('Magdalena', 'Szymańska', '1976-10-25', '+48500987655', 'magdalena.szymanska@polen.com', 1),
    ('Jakub', 'Woźniak', '1992-03-01', '+48600123458', 'jakub.wozniak@polen.com', 1),
    ('Agnieszka', 'Dąbrowska', '1987-06-06', '+48650987656', 'agnieszka.dabrowska@polen.com', 1),
    ('Marcin', 'Kozłowski', '1982-09-11', '+48765432111', 'marcin.kozlowski@polen.com', 1),
    ('Katarzyna', 'Jankowska', '1977-12-16', '+48500987656', 'katarzyna.jankowska@polen.com', 1),
	('Magdalena', 'Zajac', '1991-09-20', '678901234', 'magdalena.zajac@example.com', 1),
    ('Tomasz', 'Duda', '1978-12-10', '890123456', 'tomasz.duda@example.com', 1),
    ('Barbara', 'Wrobel', '1994-07-05', '0987654321', 'barbara.wrobel@example.com', 1);

-- Kunder från Storbritannien
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES 
    ('Emily', 'Smith', '1993-03-25', '+447712345678', 'emily.smith@uk.com', 1),
    ('Jack', 'Johnson', '1988-06-30', '+447823456789', 'jack.johnson@uk.com', 1),
    ('Sophie', 'Williams', '1983-10-05', '+447612345678', 'sophie.williams@uk.com', 1),
    ('Oliver', 'Brown', '1978-01-10', '+447712345679', 'oliver.brown@uk.com', 1),
    ('Harry', 'Jones', '1994-04-15', '+447823456790', 'harry.jones@uk.com', 1),
    ('Amelia', 'Taylor', '1989-07-20', '+447612345679', 'amelia.taylor@uk.com', 1),
	('Daniel', 'Thomas', '1988-11-25', '0712345678', 'daniel.thomas@example.com', 1),
    ('Jessica', 'Roberts', '1992-09-15', '0745678901', 'jessica.roberts@example.com', 1);

-- Adresser för kunder från Sverige
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Storgatan 1', 'Stockholm', 'Stockholm', 'Sweden', '11111', 1),
    ('Götgatan 12', 'Stockholm', 'Stockholm', 'Sweden', '11122', 2),
    ('Kungsgatan 5', 'Göteborg', 'Västra Götaland', 'Sweden', '22222', 3),
    ('Drottninggatan 8', 'Malmö', 'Skåne', 'Sweden', '33333', 4),
    ('Österlånggatan 10', 'Uppsala', 'Uppsala', 'Sweden', '44444', 5),
    ('Södra Kungsgatan 7', 'Linköping', 'Östergötland', 'Sweden', '55555', 6),
    ('Norra Strandgatan 15', 'Helsingborg', 'Skåne', 'Sweden', '66666', 7),
    ('Västra Storgatan 3', 'Norrköping', 'Östergötland', 'Sweden', '77777', 8),
    ('Östra Storgatan 20', 'Västerås', 'Västmanland', 'Sweden', '88888', 9),
    ('Södra Långgatan 25', 'Jönköping', 'Jönköping', 'Sweden', '99999', 10),
    ('Centralgatan 2', 'Örebro', 'Örebro', 'Sweden', '101010', 11),
    ('Lilla Norregatan 18', 'Halmstad', 'Halland', 'Sweden', '121212', 12),
    ('Östra Hamngatan 30', 'Växjö', 'Kronoberg', 'Sweden', '141414', 13),
    ('Linnégatan 13', 'Karlstad', 'Värmland', 'Sweden', '161616', 14),
    ('Kyrkogatan 9', 'Gävle', 'Gävleborg', 'Sweden', '181818', 15),
    ('Södra Kyrkogatan 22', 'Lund', 'Skåne', 'Sweden', '202020', 16),
    ('Storgatan 35', 'Eskilstuna', 'Södermanland', 'Sweden', '222222', 17),
    ('Stora Södergatan 14', 'Umeå', 'Västerbotten', 'Sweden', '242424', 18),
    ('Kungsgatan 40', 'Borås', 'Västra Götaland', 'Sweden', '262626', 19);

-- Adresser för kunder från Polen
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('Aleje Jerozolimskie 123', 'Warsaw', 'Masovian Voivodeship', 'Poland', '00-001', 20),
    ('Świętokrzyska 12', 'Kraków', 'Lesser Poland Voivodeship', 'Poland', '31-021', 21),
    ('Piotrkowska 150', 'Łódź', 'Łódź Voivodeship', 'Poland', '90-001', 22),
    ('Krakowskie Przedmieście 32', 'Wrocław', 'Lower Silesian Voivodeship', 'Poland', '50-951', 23),
    ('Plac Powstańców Warszawy 2', 'Poznań', 'Greater Poland Voivodeship', 'Poland', '61-001', 24),
    ('Wały Jagiellońskie 1', 'Gdańsk', 'Pomeranian Voivodeship', 'Poland', '80-001', 25),
    ('Zamkowa 1', 'Szczecin', 'West Pomeranian Voivodeship', 'Poland', '70-001', 26),
    ('ul. Wita Stwosza 12', 'Bydgoszcz', 'Kuyavian-Pomeranian Voivodeship', 'Poland', '85-001', 27),
    ('Armii Krajowej 9', 'Katowice', 'Silesian Voivodeship', 'Poland', '40-001', 28),
    ('1 Maja 15', 'Gdynia', 'Pomeranian Voivodeship', 'Poland', '81-001', 29),
    ('Adama Mickiewicza 30', 'Częstochowa', 'Silesian Voivodeship', 'Poland', '42-001', 30),
	('ul. Kilińskiego 1', 'Lublin', 'Lublin Voivodeship', 'Poland', '20-001', 31),
    ('ul. Piłsudskiego 20', 'Rzeszów', 'Subcarpathian Voivodeship', 'Poland', '35-001', 32),
    ('Plac Teatralny 5', 'Toruń', 'Kuyavian-Pomeranian Voivodeship', 'Poland', '87-100', 33);


-- Adresser för kunder från Storbritannien
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES 
    ('221B Baker Street', 'London', 'England', 'United Kingdom', 'NW1 6XE', 34),
    ('10 Downing Street', 'London', 'England', 'United Kingdom', 'SW1A 2AA', 35),
    ('Windsor Castle', 'Windsor', 'England', 'United Kingdom', 'SL4 1NJ', 36),
    ('Buckingham Palace', 'London', 'England', 'United Kingdom', 'SW1A 1AA', 37),
    ('Edinburgh Castle', 'Edinburgh', 'Scotland', 'United Kingdom', 'EH1 2NG', 38),
    ('St. Andrew''s House', 'Edinburgh', 'Scotland', 'United Kingdom', 'EH1 3DG', 39),
    ('Millennium Stadium', 'Cardiff', 'Wales', 'United Kingdom', 'CF10 1NS', 40),
    ('Stormont Estate', 'Belfast', 'Northern Ireland', 'United Kingdom', 'BT4 3SH', 41);

-- Skapa data poster för en kund som har gjort 9 ordrar
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 1, 0),
    ('2023-10-31', 3, 150.00, 1, 0),
    ('2023-11-01', 1, 50.00, 1, 0),
    ('2023-11-01', 4, 200.00, 1, 0),
    ('2023-11-02', 2, 100.00, 1, 0),
    ('2023-11-02', 2, 100.00, 1, 0),
    ('2023-11-03', 3, 150.00, 1, 0),
    ('2023-11-03', 1, 50.00, 1, 0),
    ('2023-11-03', 2, 100.00, 1, 0);

-- Skapa data poster för kunder som har gjort mellan 4 till 5 ordrar
-- Kund 2
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 2, 0),
    ('2023-10-31', 3, 150.00, 2, 0),
    ('2023-11-01', 1, 50.00, 2, 0),
    ('2023-11-01', 4, 200.00, 2, 0),
    ('2023-11-02', 2, 100.00, 2, 0);

-- Kund 3
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 3, 0),
    ('2023-10-31', 3, 150.00, 3, 0),
    ('2023-11-01', 1, 50.00, 3, 0),
    ('2023-11-01', 4, 200.00, 3, 0),
    ('2023-11-02', 2, 100.00, 3, 0);

-- Kund 4
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 4, 0),
    ('2023-10-31', 3, 150.00, 4, 0),
    ('2023-11-01', 1, 50.00, 4, 0),
    ('2023-11-01', 4, 200.00, 4, 0),
    ('2023-11-02', 2, 100.00, 4, 0);

	-- Kund 5
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 5, 0),
    ('2023-10-31', 3, 150.00, 5, 1),
    ('2023-11-01', 1, 50.00, 5, 0),
    ('2023-11-01', 4, 200.00, 5, 0),
    ('2023-11-02', 2, 100.00, 5, 0),
    ('2023-11-02', 2, 100.00, 5, 0),
    ('2023-11-03', 3, 150.00, 5, 0);

-- Kund 6
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 6, 0),
    ('2023-10-31', 3, 150.00, 6, 0),
    ('2023-11-01', 1, 50.00, 6, 0),
    ('2023-11-01', 4, 200.00, 6, 0),
    ('2023-11-02', 2, 100.00, 6, 0),
    ('2023-11-02', 2, 100.00, 6, 0),
    ('2023-11-03', 3, 150.00, 6, 0);

-- Kund 7
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 7, 0),
    ('2023-10-31', 3, 150.00, 7, 0),
    ('2023-11-01', 1, 50.00, 7, 0),
    ('2023-11-01', 4, 200.00, 7, 1),
    ('2023-11-02', 2, 100.00, 7, 0),
    ('2023-11-02', 2, 100.00, 7, 0),
    ('2023-11-03', 3, 150.00, 7, 0);

-- Kund 8
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 8, 1);

-- Kund 9
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 9, 0),
    ('2023-11-01', 3, 150.00, 9, 0);

-- Kund 10
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 10, 0),
    ('2023-11-01', 3, 150.00, 10, 1);

-- Kund 11
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 11, 0);

-- Kund 12
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 12, 0),
    ('2023-11-01', 3, 150.00, 12, 0),
    ('2023-11-02', 1, 50.00, 12, 0),
    ('2023-11-03', 4, 200.00, 12, 1);

-- Kund 13
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 13, 0),
    ('2023-11-01', 3, 150.00, 13, 0),
    ('2023-11-02', 1, 50.00, 13, 0);

-- Kund 14
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 14, 1),
    ('2023-11-01', 3, 150.00, 14, 0),
    ('2023-11-02', 1, 50.00, 14, 0);

-- Kund 15
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 15, 0),
    ('2023-11-01', 3, 150.00, 15, 0),
    ('2023-11-02', 1, 50.00, 15, 0),
    ('2023-11-03', 4, 200.00, 15, 0);

-- Kund 16
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 16, 0);

-- Kund 17
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 17, 1),
    ('2023-11-01', 3, 150.00, 17, 0);

-- Kund 18
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 18, 0),
    ('2023-11-01', 3, 150.00, 18, 1);

-- Kund 19
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 19, 0);

-- Kund 20
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 20, 0),
    ('2023-11-01', 3, 150.00, 20, 0),
    ('2023-11-02', 1, 50.00, 20, 1);

-- Kund 21
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 21, 0),
    ('2023-11-01', 3, 150.00, 21, 0),
    ('2023-11-02', 1, 50.00, 21, 0);

-- Kund 22
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 22, 0),
    ('2023-11-01', 3, 150.00, 22, 0),
    ('2023-11-02', 1, 50.00, 22, 0);

-- Kund 23
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 23, 0),
    ('2023-11-01', 3, 150.00, 23, 0),
    ('2023-11-02', 1, 50.00, 23, 0),
    ('2023-11-03', 4, 200.00, 23, 1);

-- Kund 24
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 24, 0),
    ('2023-11-01', 3, 150.00, 24, 0);

-- Kund 25
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 25, 0),
    ('2023-11-01', 3, 150.00, 25, 0),
    ('2023-11-02', 1, 50.00, 25, 0);

-- Kund 26
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 26, 0),
    ('2023-11-01', 3, 150.00, 26, 0),
    ('2023-11-02', 1, 50.00, 26, 0),
    ('2023-11-03', 4, 200.00, 26, 1);

-- Kund 27
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 27, 0),
    ('2023-11-01', 3, 150.00, 27, 0),
    ('2023-11-02', 1, 50.00, 27, 1);

-- Kund 28
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 28, 0),
    ('2023-11-01', 3, 150.00, 28, 0),
    ('2023-11-02', 1, 50.00, 28, 0);

-- Kund 29
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 29, 0),
    ('2023-11-01', 3, 150.00, 29, 0),
    ('2023-11-02', 1, 50.00, 29, 0);

-- Kund 30
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 30, 1),
    ('2023-11-01', 3, 150.00, 30, 0);

-- Kund 31
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 31, 0),
    ('2023-11-01', 3, 150.00, 31, 1);

-- Kund 32
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 32, 0),
    ('2023-11-01', 3, 150.00, 32, 0),
    ('2023-11-02', 1, 50.00, 32, 0);

-- Kund 33
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 33, 0),
    ('2023-11-01', 3, 150.00, 33, 0),
    ('2023-11-02', 1, 50.00, 33, 0);

-- Kund 34
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 34, 0),
    ('2023-11-01', 3, 150.00, 34, 0);

-- Kund 35
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 35, 0),
    ('2023-11-01', 3, 150.00, 35, 1);

-- Kund 36
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 36, 0),
    ('2023-11-01', 3, 150.00, 36, 0);

-- Kund 37
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 37, 0),
    ('2023-11-01', 3, 150.00, 37, 0);

-- Kund 38
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 38, 1),
    ('2023-11-01', 3, 150.00, 38, 0);

-- Kund 39
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 39, 0),
    ('2023-11-01', 3, 150.00, 39, 0),
    ('2023-11-02', 1, 50.00, 39, 0);

-- Kund 40
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 40, 0);

-- Kund 41
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 41, 0),
    ('2023-11-01', 3, 150.00, 41, 0),
    ('2023-11-02', 1, 50.00, 41, 1);

-- Kund 42
INSERT INTO [Order] (OrderDate, NumberOfTickets, TotalPrice, CustomerID, Cancelled)
VALUES 
    ('2023-10-31', 2, 100.00, 42, 0),
    ('2023-11-01', 3, 150.00, 42, 0);

-- Skapa 5 data poster med olika recensioner
INSERT INTO Review (Rating, Text, ReviewDate, CustomerID, EventID, ProductID)
VALUES (1, 'The worst product I have ever bought.', '2024-04-24', 1, NULL, NULL),
       (2, 'Alright, but I expected more.', '2024-04-23', NULL, 1, NULL),
       (3, 'Good product, but the price is too high for what you get.', '2024-04-22', 2, NULL, NULL),
       (4, 'Fantastic! I love this event.', '2024-04-21', NULL, 2, NULL),
       (5, 'Best purchase ever! The product exceeded my expectations.', '2024-04-20', 3, NULL, NULL);


-- Infoga data för hemsökta platser och hemsökta slott med övernattning
-- Inserting data for products
INSERT INTO Product (Name, Description, OrderID, SupplierID, ReviewID, ProductCategoryID, Active)
VALUES 
    ('Vasa Ship', 'One of Sweden''s most famous haunted places, a sunken ship resurrected to scare visitors.', 1, 1, 5, 1, 1),
    ('Chillingham Castle', 'A haunted castle in northern England, known for its ghost stories and ghost hunts.', 1, 2, 4, 2, 1),
    ('Książ Castle', 'A haunted castle in Poland, said to be inhabited by several ghosts, including a cursed princess.', 1, 3, 3, 3, 1),
    ('Skogskyrkogården', 'A haunted cemetery in Stockholm, Sweden, known for its paranormal activities and ghost stories.', 68, 1, 5, 1, 1),
    ('Borley Rectory', 'An infamous haunted house in Essex, England, said to be the site of countless paranormal events.', 101, 2, 5, 3, 1),
    ('Czocha Castle', 'A castle in Poland said to be inhabited by several ghosts, including a tragic princess and a ghost soldier.', 55, 3, 2, 2, 1),
    ('Mårbacka Manor', 'A mansion in Värmland, Sweden, rumored to be haunted by the author Selma Lagerlöf.', 25, 1, 3, 1, 1),
    ('Tower of London', 'A historic castle in London, UK, known for its many ghosts, including Anne Boleyn and other executed prisoners.', 27, 2, 4, 2, 1),
    ('Niedzica Castle', 'A castle in Poland, also known as "Devil''s Castle," said to be inhabited by several ghosts and haunted by a cursed count.', 7, 3, 4, 3, 1),
    ('Bran Castle', 'A famous castle in Romania, sometimes called Dracula''s Castle, said to be haunted by vampires and other supernatural creatures.', 13, 4, 5, 3, 1),
    ('Eastern State Penitentiary', 'An infamous prison in Philadelphia, USA, known for its ghost stories and ghost hunts.', 5, 5, 3, 4, 1),
    ('Ballygally Castle', 'A haunted castle in Northern Ireland, said to be haunted by Lady Isobel Shaw and other ghosts.', 69, 6, 2, 2, 1),
    ('Akershus Fortress', 'A medieval castle in Oslo, Norway, known for its ghost stories and paranormal activities.', 22, 7, 1, 5, 1)
;

-- Inserting data for product categories
INSERT INTO ProductCategory (CategoryName, Description, LocationType, ScareLevel, PriceRange)
VALUES 
    ('Haunted places', 'Places rumored to be haunted by ghosts and paranormal phenomena.', 'Area', 'Medium', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted places', 'Places rumored to be haunted by ghosts and paranormal phenomena.', 'Area', 'Medium', 'Varied'),
    ('Haunted places', 'Places rumored to be haunted by ghosts and paranormal phenomena.', 'Area', 'Medium', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted places', 'Places rumored to be haunted by ghosts and paranormal phenomena.', 'Area', 'Medium', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted castles', 'Castles and manors rumored to be inhabited by ghosts and spirits.', 'Building', 'High', 'Varied'),
    ('Haunted places', 'Places rumored to be haunted by ghosts and paranormal phenomena.', 'Area', 'Medium', 'Varied')
;


-- Infoga data för produktplatser
INSERT INTO ProductLocation (Address, City, Region, Country, Zipcode, Latitude, Longitude, ProductID, Active)
VALUES 
    ('Galarvarvsvägen 14', 'Stockholm', 'Stockholm', 'Sweden', '11765', 59.32602, 18.10242, 1, 1),
    ('Chillingham Castle', 'Alnwick', 'Northumberland', 'United Kingdom', 'NE66 5NJ', 55.53447, -1.83229, 2, 1),
    ('Książ 2', 'Wałbrzych', 'Lower Silesian Voivodeship', 'Poland', '58-306', 50.85000, 16.28000, 3, 1),
    ('Skogskyrkogården', 'Stockholm', 'Stockholm', 'Sweden', '122 33', 59.28043, 18.09704, 4, 1),
    ('Borley Rectory', 'Borley', 'Essex', 'United Kingdom', 'CO10 7NJ', 51.97878, 0.73115, 5, 1),
    ('Czocha 8', 'Leśna', 'Lower Silesian Voivodeship', 'Poland', '59-820', 51.12778, 15.30972, 6, 1),
    ('Mårbacka 27', 'Sunne', 'Värmland', 'Sweden', '686 93', 59.82685, 13.13105, 7, 1),
    ('Tower Hill', 'London', 'England', 'United Kingdom', 'EC3N 4AB', 51.50812, -0.07607, 8, 1),
    ('Zamek Niedzica 1', 'Niedzica-Zamek', 'Lesser Poland Voivodeship', 'Poland', '34-441', 49.41667, 20.26667, 9, 1),    
    ('Bran Castle', 'Bran', 'Brașov', 'Romania', '507025', 45.51487, 25.36718, 10, 1),
    ('2027 Fairmount Avenue', 'Philadelphia', 'Pennsylvania', 'United States', '19130', 39.96584, -75.17621, 11, 1),
    ('Coast Road', 'Ballygally', 'County Antrim', 'United Kingdom', 'BT40 2QZ', 54.85330, -5.81568, 12, 1),
    ('Akershus Fortress', 'Oslo', 'Oslo', 'Norway', '0150', 59.90750, 10.73292, 13, 1)
;

-- Skapa 13 data poster som matchar produkter och infoga dem i Sale-tabellen
INSERT INTO Sale (Name, SaleDate, QuantitySold, TotalPrice, ProductID, OrderID)
VALUES 
    ('Special Offer: Vasa Ship', '2024-04-01', 10, 5000.00, 1, 1),
    ('Horror Experience at Chillingham Castle', '2024-04-02', 5, 2500.00, 2, 2),
    ('Guided Tour at Książ Castle', '2024-04-03', 8, 4000.00, 3, 3),
    ('Haunted Walk at Skogskyrkogården', '2024-04-04', 12, 6000.00, 4, 4),
    ('Ghost Hunt at Borley Rectory', '2024-04-05', 6, 3000.00, 5, 5),
    ('Adventure at Czocha Castle', '2024-04-06', 7, 3500.00, 6, 6),
    ('Night at Mårbacka Manor', '2024-04-07', 9, 4500.00, 7, 7),
    ('Mysterious Visit to Tower of London', '2024-04-08', 11, 5500.00, 8, 8),
    ('Spooky Adventure at Niedzica Castle', '2024-04-09', 4, 2000.00, 9, 9),
    ('Dracula Tour at Bran Castle', '2024-04-10', 15, 7500.00, 10, 10),
    ('Paranormal Experience at Eastern State Penitentiary', '2024-04-11', 3, 1500.00, 11, 11),
    ('Overnight Stay at Ballygally Castle', '2024-04-12', 2, 1000.00, 12, 12),
    ('Guided Tour at Akershus Fortress', '2024-04-13', 6, 3000.00, 13, 13);


-- Skapa data för Event-tabellen
INSERT INTO Event (Name, Description, StartDate, EndDate, Location, OrderID, ReviewID, Active)
VALUES 
    ('Spökvandring på Skogskyrkogården', 'En skrämmande vandring genom Skogskyrkogården med spökguidning.', '2024-10-31 19:00:00', '2024-10-31 21:00:00', 'Skogskyrkogården, Stockholm', NULL, NULL, 1),
    ('Halloween-fest på Chillingham Castle', 'En oförglömlig Halloween-fest på det hemsökta slottet Chillingham Castle.', '2024-10-31 20:00:00', '2024-11-01 02:00:00', 'Chillingham Castle, Northumberland', NULL, NULL, 1),
    ('Guidad tur på Bran Castle', 'En spännande guidetur genom Draculas slott, Bran Castle.', '2024-10-31 15:00:00', '2024-10-31 17:00:00', 'Bran Castle, Bran', NULL, NULL, 1),
	('Nattvandring på Tower of London', 'Utforska Tower of London på natten med en spännande guidad tur.', '2024-11-05 21:00:00', '2024-11-05 23:00:00', 'Tower of London, London', NULL, NULL, 1),
    ('Spökjakt på Edinburgh Castle', 'Delta i en spökjakt vid det historiska Edinburgh Castle.', '2024-11-10 22:00:00', '2024-11-11 00:00:00', 'Edinburgh Castle, Edinburgh', NULL, NULL, 1),
    ('Mörkertur på Winchester Mystery House', 'En mörkertur på det legendariska Winchester Mystery House.', '2024-11-15 20:00:00', '2024-11-15 22:00:00', 'Winchester Mystery House, San Jose', NULL, NULL, 1);

-- Skapa data för EventLocation-tabellen
INSERT INTO EventLocation (Address, City, Region, Country, Zipcode, Latitude, Longitude, EventID)
VALUES 
    ('Skogskyrkogården', 'Stockholm', 'Stockholm County', 'Sweden', '12345', 59.2985, 18.0713, 1),
    ('Chillingham Castle', 'Alnwick', 'Northumberland', 'United Kingdom', 'NE66 5NJ', 55.5077, -1.8717, 2),
    ('Bran Castle', 'Bran', 'Brasov', 'Romania', '507025', 45.5143, 25.3672, 3),
	 ('Tower of London', 'London', 'England', 'United Kingdom', 'EC3N 4AB', 51.5081, -0.0759, 4),
    ('Edinburgh Castle', 'Edinburgh', 'Scotland', 'United Kingdom', 'EH1 2NG', 55.9486, -3.1999, 5),
    ('Winchester Mystery House', 'San Jose', 'California', 'United States', '95128', 37.3187, -121.9504, 6);


-- Skapa data för Supplier-tabellen
INSERT INTO Supplier (Name, Role, ProductID, Active)
VALUES 
    ('Haunted Adventures AB', 'Event organizer', 4, 1),
    ('Ghostly Getaways Ltd', 'Event organizer', 5, 1),
    ('Paranormal Excursions Inc', 'Event organizer', 6, 1),
    ('Spirited Tours Ltd', 'Event organizer', 7, 1);

-- Skapa data för SupplierType-tabellen
INSERT INTO SupplierType (Name, Description, SupplierID)
VALUES 
    ('Haunted Tours', 'Organizes haunted tours and spooky events.', 1),
    ('Castle Events Organizer', 'Arranges events and parties at historical castles.', 2),
    ('Guided Dracula Tours', 'Organizes guided tours and events related to Dracula.', 3),
    ('Paranormal Event Planner', 'Plans and organizes paranormal-themed events and experiences.', 4);


--skapar relation mellan customer & address
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