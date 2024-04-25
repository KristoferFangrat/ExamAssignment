IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'KristofersSnusAB')
BEGIN
    CREATE DATABASE KristofersSnusAB;
END
GO
USE KristofersSnusAB;
GO

-- Skapa tabellen Customer (Kund)
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Phonenumber VARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Active BIT NOT NULL
);

-- Skapa tabellen Address (Adress)
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    Street NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(11) NOT NULL,
    CustomerID INT NOT NULL
);

-- Skapa tabellen Order (Beställning)
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    CustomerID INT NOT NULL,
    Cancelled BIT NOT NULL
);

-- Skapa tabellen Product (Produkt)
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    SupplierID INT NOT NULL,
	OrderID INT NOT NULL,
    ProductCategoryID INT NOT NULL,
);


CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    SnusType NVARCHAR(50), -- Typ av snus (t.ex. vit portion, lössnus, all white-snus)
    StrengthLevel NVARCHAR(50), --Styrkenivå (t.ex. mild, stark, extra stark)
    PriceRange NVARCHAR(50) --Priskategori för snuset
);

-- Skapa tabellen Sale (Försäljning)
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(300) NOT NULL,
    SaleDate DATE NOT NULL,
    QuantitySold INT NOT NULL,
    TotalPrice DECIMAL(15,2) NOT NULL,
    ProductID INT NOT NULL,
    OrderID INT,
);

-- Skapa tabellen Supplier (Leverantör)
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Role NVARCHAR(20) NOT NULL,
	ProductID INT,
    Active BIT NOT NULL
);

-- Skapa tabellen SupplierType (Leverantörstyp)
CREATE TABLE SupplierType (
    SupplierTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    SupplierID INT NOT NULL
);

-- Lägg till kunder från Stockholm
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES
    ('Erik', 'Andersson', '1985-03-15', '0701234567', 'erik.andersson@example.com', 1),
    ('Anna', 'Johansson', '1990-07-20', '0707654321', 'anna.johansson@example.com', 1),
    ('Johan', 'Nilsson', '1982-11-10', '0709876543', 'johan.nilsson@example.com', 1),
    ('Sara', 'Larsson', '1978-05-25', '0702468135', 'sara.larsson@example.com', 1),
    ('Emma', 'Persson', '1995-09-18', '0701357924', 'emma.persson@example.com', 1),
    ('Anders', 'Svensson', '1989-02-03', '0701122334', 'anders.svensson@example.com', 1),
    ('Maria', 'Gustafsson', '1973-12-08', '0703344556', 'maria.gustafsson@example.com', 1),
    ('Peter', 'Eriksson', '1987-08-29', '0705566778', 'peter.eriksson@example.com', 1),
    ('Kalle', 'Karlsson', '1980-04-25', '0701111111', 'kalle.karlsson@example.com', 1),
    ('Lisa', 'Lindberg', '1992-09-15', '0702222222', 'lisa.lindberg@example.com', 1),
    ('Per', 'Persson', '1975-12-03', '0703333333', 'per.persson@example.com', 1),
    ('Carina', 'Carlsson', '1988-06-20', '0704444444', 'carina.carlsson@example.com', 1),
    ('Anders', 'Andersson', '1983-03-10', '0705555555', 'anders.andersson@example.com', 1),
    ('Lotta', 'Larsson', '1990-11-28', '0706666666', 'lotta.larsson@example.com', 1),
    ('Mats', 'Mattsson', '1978-08-17', '0707777777', 'mats.mattsson@example.com', 1),
    ('Sofie', 'Svensson', '1985-02-12', '0708888888', 'sofie.svensson@example.com', 1),
    ('David', 'Davidsson', '1982-07-05', '0709999999', 'david.davidsson@example.com', 1),
    ('Eva', 'Eriksson', '1995-01-30', '0701010101', 'eva.eriksson@example.com', 1);


-- Lägg till kunder från Göteborg
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES
    ('Hanna', 'Andersson', '1984-04-12', '0311234567', 'hanna.andersson@example.com', 1),
    ('Oscar', 'Svensson', '1991-10-05', '0317654321', 'oscar.svensson@example.com', 1),
    ('Lina', 'Johansson', '1980-06-27', '0319876543', 'lina.johansson@example.com', 1),
    ('Andreas', 'Karlsson', '1976-09-14', '0312468135', 'andreas.karlsson@example.com', 1),
    ('Jessica', 'Nilsson', '1994-03-02', '0311357924', 'jessica.nilsson@example.com', 1),
    ('David', 'Eriksson', '1988-07-19', '0311122334', 'david.eriksson@example.com', 1),
    ('Elin', 'Gustafsson', '1972-11-28', '0313344556', 'elin.gustafsson@example.com', 1),
    ('Niklas', 'Larsson', '1986-01-15', '0315566778', 'niklas.larsson@example.com', 1);

-- Lägg till kunder från Malmö
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES
    ('Karin', 'Andersson', '1983-08-20', '0401234567', 'karin.andersson@example.com', 1),
    ('Martin', 'Nilsson', '1992-02-17', '0407654321', 'martin.nilsson@example.com', 1),
    ('Malin', 'Johansson', '1979-10-08', '0409876543', 'malin.johansson@example.com', 1),
    ('Simon', 'Svensson', '1975-05-16', '0402468135', 'simon.svensson@example.com', 1),
    ('Linda', 'Eriksson', '1993-12-03', '0401357924', 'linda.eriksson@example.com', 1),
    ('Jonas', 'Gustafsson', '1987-06-22', '0401122334', 'jonas.gustafsson@example.com', 1),
    ('Cecilia', 'Karlsson', '1971-09-11', '0403344556', 'cecilia.karlsson@example.com', 1),
    ('Fredrik', 'Larsson', '1985-03-24', '0405566778', 'fredrik.larsson@example.com', 1);

-- Lägg till kunder från Sundsvall
INSERT INTO Customer (FirstName, LastName, DateOfBirth, Phonenumber, Email, Active)
VALUES
    ('Linnea', 'Svensson', '1982-06-09', '0601234567', 'linnea.svensson@example.com', 1),
    ('Robert', 'Andersson', '1993-11-26', '0607654321', 'robert.andersson@example.com', 1),
    ('Therese', 'Johansson', '1978-02-14', '0609876543', 'therese.johansson@example.com', 1),
    ('Erik', 'Karlsson', '1974-07-01', '0602468135', 'erik.karlsson@example.com', 1),
    ('Sofia', 'Eriksson', '1990-09-30', '0601357924', 'sofia.eriksson@example.com', 1),
    ('Daniel', 'Nilsson', '1986-05-18', '0601122334', 'daniel.nilsson@example.com', 1),
    ('Monica', 'Gustafsson', '1970-12-25', '0603344556', 'monica.gustafsson@example.com', 1),
    ('Anders', 'Larsson', '1989-04-08', '0605566778', 'anders.larsson@example.com', 1);

-- Lägg till adresser för kunder
-- För Stockholm-kunder
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES
    ('Drottninggatan 1', 'Stockholm', 'Stockholm', 'Sweden', '111 21', 1),
    ('Vasagatan 15', 'Stockholm', 'Stockholm', 'Sweden', '112 34', 2),
    ('Götgatan 32', 'Stockholm', 'Stockholm', 'Sweden', '113 45', 3),
    ('Sveavägen 100', 'Stockholm', 'Stockholm', 'Sweden', '114 56', 4),
    ('Kungsgatan 7', 'Stockholm', 'Stockholm', 'Sweden', '115 67', 5),
    ('Hornsgatan 18', 'Stockholm', 'Stockholm', 'Sweden', '116 78', 6),
    ('Folkungagatan 25', 'Stockholm', 'Stockholm', 'Sweden', '117 89', 7),
    ('Katarinavägen 3', 'Stockholm', 'Stockholm', 'Sweden', '118 90', 8);

-- För Göteborg-kunder
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES
    ('Avenyn 12', 'Göteborg', 'Västra Götaland', 'Sweden', '411 11', 9),
    ('Kungsportsavenyen 2', 'Göteborg', 'Västra Götaland', 'Sweden', '412 22', 10),
    ('Linnégatan 9', 'Göteborg', 'Västra Götaland', 'Sweden', '413 33', 11),
    ('Vasaplatsen 8', 'Göteborg', 'Västra Götaland', 'Sweden', '414 44', 12),
    ('Magasinsgatan 17', 'Göteborg', 'Västra Götaland', 'Sweden', '415 55', 13),
    ('Kungsgatan 3', 'Göteborg', 'Västra Götaland', 'Sweden', '416 66', 14),
    ('Andra Långgatan 20', 'Göteborg', 'Västra Götaland', 'Sweden', '417 77', 15),
    ('Storgatan 14', 'Göteborg', 'Västra Götaland', 'Sweden', '418 88', 16);

-- För Malmö-kunder
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES
    ('Stortorget 1', 'Malmö', 'Skåne', 'Sweden', '211 22', 17),
    ('Södergatan 8', 'Malmö', 'Skåne', 'Sweden', '212 33', 18),
    ('Norra Vallgatan 14', 'Malmö', 'Skåne', 'Sweden', '213 44', 19),
    ('Drottningtorget 5', 'Malmö', 'Skåne', 'Sweden', '214 55', 20),
    ('Fersens väg 3', 'Malmö', 'Skåne', 'Sweden', '215 66', 21),
    ('Davidshalls väg 12', 'Malmö', 'Skåne', 'Sweden', '216 77', 22),
    ('Västra Hamnen 19', 'Malmö', 'Skåne', 'Sweden', '217 88', 23),
    ('S:t Johannesgatan 11', 'Malmö', 'Skåne', 'Sweden', '218 99', 24);

-- För Sundsvall-kunder
INSERT INTO Address (Street, City, Region, Country, Zipcode, CustomerID)
VALUES
    ('Storgatan 7', 'Sundsvall', 'Västernorrland', 'Sweden', '851 11', 25),
    ('Köpmangatan 3', 'Sundsvall', 'Västernorrland', 'Sweden', '852 22', 26),
    ('Sveagatan 10', 'Sundsvall', 'Västernorrland', 'Sweden', '853 33', 27),
    ('Storgatan 15', 'Sundsvall', 'Västernorrland', 'Sweden', '854 44', 28),
    ('Hörngatan 2', 'Sundsvall', 'Västernorrland', 'Sweden', '855 55', 29),
    ('Skolgatan 18', 'Sundsvall', 'Västernorrland', 'Sweden', '856 66', 30),
    ('Esplanaden 6', 'Sundsvall', 'Västernorrland', 'Sweden', '857 77', 31),
    ('Sjögatan 9', 'Sundsvall', 'Västernorrland', 'Sweden', '858 88', 32);

-- Lägg till leverantörer
INSERT INTO Supplier (Name, Role, Active)
VALUES
    ('Swedish Match', 'Snus Manufacturer', 1),
    ('Skruf', 'Snus Manufacturer', 1),
    ('Göteborgs Rapé', 'Snus Manufacturer', 1),
    ('General', 'Snus Manufacturer', 1);

-- Lägg till produkter (snus)
INSERT INTO Product (Name, Description, SupplierID, OrderID, ProductCategoryID)
VALUES
    ('General Lös', 'Traditionellt svenskt lössnus', 4,1, 1),
    ('Skruf Original Portion', 'Portionsförpackat snus med klassiskt smakprofil',2,2, 2),
    ('Göteborgs Rapé Vit Portion', 'Portionsförpackat snus med enbärssmak', 3,3, 3),
    ('General G.4 All White Slim Mint', 'All White-snus med mintsmak', 4,4, 4),
	('Ettan Lös', 'Klassiskt lössnus med enbärssmak', 4,1, 1),
    ('General Portion', 'Traditionellt portionsförpackat snus',2,1, 2),
    ('Grov Lös', 'Kraftigt lössnus med rökig smak', 3,2, 1),
    ('Skruf Tranbär Vit Portion', 'Portionsförpackat snus med tranbärssmak', 2,1, 3),
    ('Catch White Eucalyptus Slim', 'All White-snus med eukalyptussmak', 4,3, 4);

-- Lägg till kategorier för produkter
INSERT INTO ProductCategory (CategoryName, Description, SnusType, StrengthLevel, PriceRange)
VALUES
    ('Lössnus', 'Lössnus för den traditionella snusaren', 'Lös', 'Mellan', 'Mellan'),
    ('Portionssnus', 'Förpackat snus för bekväm användning', 'Portion', 'Mellan', 'Mellan'),
    ('Vit Portion', 'Förpackat snus med vit påse', 'Vit portion', 'Mild', 'Mellan'),
    ('All White', 'Snus utan tobak för diskret användning', 'All White-snus', 'Mild', 'Hög'),
	('Lössnus', 'Lössnus för den traditionella snusaren', 'Lös', 'Mellan', 'Mellan'),
    ('Portionssnus', 'Förpackat snus för bekväm användning', 'Portion', 'Mellan', 'Mellan'),
    ('Vit Portion', 'Förpackat snus med vit påse', 'Vit portion', 'Mild', 'Mellan'),
    ('All White', 'Snus utan tobak för diskret användning', 'All White-snus', 'Mild', 'Hög'),
    ('Original Portion', 'Traditionell portionssnus med klassisk smak', 'Portion', 'Mellan', 'Mellan'),
    ('Extra Stark', 'Snus med extra hög nikotinhalt', 'Portion', 'Stark', 'Hög');

-- Lägg till försäljningar (beställningar)
-- 2022
INSERT INTO [Order] (OrderDate, TotalPrice, CustomerID, Cancelled)
VALUES
    ('2022-01-15', 250.00, 1, 0),
    ('2022-02-20', 300.00, 2, 0),
    ('2022-03-10', 280.00, 3, 0),
    ('2022-04-05', 320.00, 4, 0),
    ('2022-05-18', 270.00, 5, 0),
    ('2022-06-22', 290.00, 6, 0),
    ('2022-07-30', 310.00, 7, 0),
    ('2022-08-12', 260.00, 8, 0);

-- 2023
INSERT INTO [Order] (OrderDate, TotalPrice, CustomerID, Cancelled)
VALUES
    ('2023-01-10', 270.00, 9, 0),
    ('2023-02-25', 310.00, 10, 0),
    ('2023-03-18', 290.00, 11, 0),
    ('2023-04-02', 300.00, 12, 0),
    ('2023-05-20', 280.00, 13, 0),
    ('2023-06-15', 320.00, 14, 0),
    ('2023-07-28', 260.00, 15, 0),
    ('2023-08-05', 250.00, 16, 0);

-- 2024
INSERT INTO [Order] (OrderDate, TotalPrice, CustomerID, Cancelled)
VALUES
    ('2024-01-05', 290.00, 17, 0),
    ('2024-02-18', 280.00, 18, 0),
    ('2024-03-12', 310.00, 19, 0),
    ('2024-04-09', 320.00, 20, 0),
    ('2024-05-24', 300.00, 21, 0),
    ('2024-06-27', 270.00, 22, 0),
    ('2024-07-30', 260.00, 23, 0),
    ('2024-08-14', 290.00, 24, 0);

-- Lägg till försäljningar (orderdetaljer)
-- För varje beställning, lägg till produkter som har köpts
-- 2022
INSERT INTO Sale (Name, SaleDate, QuantitySold, TotalPrice, ProductID, OrderID)
VALUES
    ('General Lös', '2022-01-15', 2, 100.00, 1, 1),
    ('Skruf Original Portion', '2022-02-20', 3, 150.00, 2, 2),
    ('Göteborgs Rapé Vit Portion', '2022-03-10', 2, 140.00, 3, 3),
    ('General G.4 All White Slim Mint', '2022-04-05', 1, 80.00, 4, 4),
    ('General Lös', '2022-05-18', 2, 90.00, 1, 5),
    ('Skruf Original Portion', '2022-06-22', 3, 120.00, 2, 6),
    ('Göteborgs Rapé Vit Portion', '2022-07-30', 2, 130.00, 3, 7),
    ('General G.4 All White Slim Mint', '2022-08-12', 1, 90.00, 4, 8);

-- 2023
INSERT INTO Sale (Name, SaleDate, QuantitySold, TotalPrice, ProductID, OrderID)
VALUES
    ('General Lös', '2023-01-10', 2, 100.00, 1, 9),
    ('Skruf Original Portion', '2023-02-25', 3, 150.00, 2, 10),
    ('Göteborgs Rapé Vit Portion', '2023-03-18', 2, 140.00, 3, 11),
    ('General G.4 All White Slim Mint', '2023-04-02', 1, 90.00, 4, 12),
    ('General Lös', '2023-05-20', 2, 90.00, 1, 13),
    ('Skruf Original Portion', '2023-06-15', 3, 120.00, 2, 14),
    ('Göteborgs Rapé Vit Portion', '2023-07-28', 2, 130.00, 3, 15),
    ('General G.4 All White Slim Mint', '2023-08-05', 1, 100.00, 4, 16);

-- 2024
INSERT INTO Sale (Name, SaleDate, QuantitySold, TotalPrice, ProductID, OrderID)
VALUES
    ('General Lös', '2024-01-05', 2, 100.00, 1, 17),
    ('Skruf Original Portion', '2024-02-18', 3, 150.00, 2, 18),
    ('Göteborgs Rapé Vit Portion', '2024-03-12', 2, 140.00, 3, 19),
    ('General G.4 All White Slim Mint', '2024-04-09', 1, 90.00, 4, 20),
    ('General Lös', '2024-05-24', 2, 90.00, 1, 21),
    ('Skruf Original Portion', '2024-06-27', 3, 120.00, 2, 22),
    ('Göteborgs Rapé Vit Portion', '2024-07-30', 2, 130.00, 3, 23),
    ('General G.4 All White Slim Mint', '2024-08-14', 1, 100.00, 4, 24);

-- Lägg till leverantörstyper
-- Varje produkt har en specifik leverantörstyp
INSERT INTO SupplierType (Name, Description, SupplierID)
VALUES
    ('Snus Manufacturer', 'Tillverkare av snus', 1),
    ('Snus Manufacturer', 'Tillverkare av snus', 2),
    ('Snus Manufacturer', 'Tillverkare av snus', 3),
    ('Snus Manufacturer', 'Tillverkare av snus', 4);

ALTER TABLE [Order]
ADD CONSTRAINT FK_Order_Customer
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO
ALTER TABLE [Order]
CHECK CONSTRAINT FK_Order_Customer;
GO

ALTER TABLE Address
ADD CONSTRAINT FK_Customer_Address
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO
ALTER TABLE Address
CHECK CONSTRAINT FK_Customer_Address;
GO


ALTER TABLE Product
ADD CONSTRAINT FK_Product_ProductCategory
FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(CategoryID);

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