CREATE DATABASE SaleDB;
GO
USE SaleDB;
GO

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(100),
    Adress VARCHAR(255),
    Region VARCHAR(50),
    LastOrderDate DATE,
    TotalOrders INT,
    TotalAmount DECIMAL(10,2),
    Rating INT,
	Active BIT
);

-- Skapa Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- Skapa Product-tabellen med kostnadskolumnen
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductPrice DECIMAL(10,2),
    SupplierID INT,
    CategoryID INT,
    Cost DECIMAL(10,2), -- Lägg till kostnadskolumnen
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Skapa ProductInventory-tabellen
CREATE TABLE ProductInventory (
    InventoryID INT PRIMARY KEY IDENTITY,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Skapa Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
	CountryID INT,
    CustomerName VARCHAR(100),
    Gender VARCHAR(10),
    Address VARCHAR(255),
    Birthday DATE,
    SSN VARCHAR(20),
    ContactInfo VARCHAR(100)
);

CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100)
);


-- Skapa Order Table
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
	ProductID INT,
	SupplierID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Skapa SalesChannel Table
CREATE TABLE SaleChannel (
    SaleChannelID INT PRIMARY KEY,
    ChannelName VARCHAR(100)
);

-- Skapa SalesPerson Table
CREATE TABLE SalePerson (
    SalePersonID INT PRIMARY KEY,
    SalePersonName VARCHAR(100)
);

-- Skapa Region Table
CREATE TABLE Region (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100)
);

-- Skapa Sales Table
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
	ProductID INT,
    CustomerID INT,
    SaleChannelID INT,
    SalePersonID INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SaleChannelID) REFERENCES SaleChannel(SaleChannelID),
    FOREIGN KEY (SalePersonID) REFERENCES SalePerson(SalePersonID)
);

-- Skapa tabell för orderdetaljer
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Skapa kopplingstabell för kundland
CREATE TABLE CustomerCountry (
    CustomerID INT,
    CountryID INT,
    PRIMARY KEY (CustomerID, CountryID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Skapa kopplingstabell för försäljningskanal och säljare
CREATE TABLE ChannelSalePerson (
    SaleChannelID INT,
    SalePersonID INT,
    PRIMARY KEY (SaleChannelID, SalePersonID),
    FOREIGN KEY (SaleChannelID) REFERENCES SaleChannel(SaleChannelID),
    FOREIGN KEY (SalePersonID) REFERENCES SalePerson(SalePersonID)
);

-- Skapa kopplingstabell för försäljning och region
CREATE TABLE SaleRegion (
    SaleID INT,
    RegionID INT,
    PRIMARY KEY (SaleID, RegionID),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Skapa data för Supplier-tabellen
INSERT INTO Supplier (SupplierID, Name, Contact, Adress, Region, LastOrderDate, TotalOrders, TotalAmount, Rating, Active)
VALUES 
    (1, 'Swedish Tech AB', 'info@swedishtech.com', 'Storgatan 1, Stockholm', 'Sweden', NULL, 0, 0.00, 0, 1),
    (2, 'Norwegian Gadgets AS', 'contact@norwegiangadgets.no', 'Karl Johans gate 2, Oslo', 'Norway', NULL, 0, 0.00, 0, 1),
    (3, 'Finnish Electronics Oy', 'sales@finnishelectronics.fi', 'Aleksanterinkatu 3, Helsinki', 'Finland', NULL, 0, 0.00, 0, 1),
	(4, 'Danish Electronics A/S', 'peter.jensen@danishelectronics.dk', 'Vesterbrogade 2, Copenhagen', 'Denmark', NULL, 0, 0.00, 0, 0);


-- Lägg till data i Category-tabellen
INSERT INTO Category (CategoryID, CategoryName)
VALUES 
    (1, 'Electronics'),
    (2, 'Appliances'),
    (3, 'Home & Garden'),
	(4, 'Mobile Devices'),
    (5, 'Kitchen Appliances');

-- Lägg till befintliga produkter i amerikanska dollar och matcha med kategorier
DECLARE @exchangeRate DECIMAL(10,2) = 9.0; -- Växelkursen mellan SEK och USD

-- Fyll Cost-kolumnen med slumpmässig kostnadsinformation
INSERT INTO Product (ProductID, ProductName, ProductPrice, SupplierID, CategoryID, Cost)
VALUES 
    (1, 'Smartphone X', ROUND(RAND()*(1000-500)+500, 2), 1, 1, ROUND(RAND()*(500-100)+100, 2)),
    (2, 'Laptop Pro', ROUND(RAND()*(2000-1000)+1000, 2), 1, 1, ROUND(RAND()*(500-100)+100, 2)),
    (3, 'Smart TV 55"', ROUND(RAND()*(1500-800)+800, 2), 2, 1, ROUND(RAND()*(500-100)+100, 2)),
    (4, 'Blender Deluxe', ROUND(RAND()*(100-50)+50, 2), 2, 2, ROUND(RAND()*(500-100)+100, 2)),
    (5, 'Coffee Maker', ROUND(RAND()*(150-80)+80, 2), 3, 2, ROUND(RAND()*(500-100)+100, 2)),
    (6, 'LED Light Bulbs (4-pack)', ROUND(RAND()*(30-10)+10, 2), 3, 3, ROUND(RAND()*(500-100)+100, 2)),
    (7, 'Tablet Lite', ROUND(RAND()*(800-400)+400, 2), 1, 4, ROUND(RAND()*(500-100)+100, 2)),
    (8, 'Desktop Computer', ROUND(RAND()*(2500-1500)+1500, 2), 1, 4, ROUND(RAND()*(500-100)+100, 2)),
    (9, 'Wireless Headphones', ROUND(RAND()*(200-100)+100, 2), 2, 4, ROUND(RAND()*(500-100)+100, 2)),
    (10, 'Toaster', ROUND(RAND()*(60-30)+30, 2), 2, 5, ROUND(RAND()*(500-100)+100, 2)),
    (11, 'Electric Kettle', ROUND(RAND()*(70-40)+40, 2), 3, 5, ROUND(RAND()*(500-100)+100, 2)),
    (12, 'Desk Lamp', ROUND(RAND()*(40-20)+20, 2), 3, 5, ROUND(RAND()*(500-100)+100, 2));

-- Skapa data för ProductInventory-tabellen baserat på Product-tabellen
INSERT INTO ProductInventory (ProductID, Quantity)
SELECT p.ProductID,
       q.RandomQuantity -- Slumpmässigt valda kvantiteter
FROM Product p
CROSS APPLY (VALUES 
    (FLOOR(RAND()*(100-10)+10)),
    (FLOOR(RAND()*(100-10)+10)),
    (FLOOR(RAND()*(100-10)+10))
) AS q(RandomQuantity);

-- Lägg till kunder
INSERT INTO Customer (CustomerID, CountryID, CustomerName, Gender, Address, Birthday, SSN, ContactInfo)
VALUES 
(1, 1, 'Anna Andersson', 'Female', 'Storgatan 1', '1980-05-10', '800510-1234', 'anna@example.com'),
(2, 1, 'Eva Svensson', 'Female', 'Götgatan 10', '1985-08-20', '850820-4567', 'eva@example.com'),
(3, 1, 'Per Nilsson', 'Male', 'Storgatan 5', '1978-04-15', '780415-7890', 'per@example.com'),
(4, 1, 'Lena Andersson', 'Female', 'Drottninggatan 3', '1992-11-25', '921125-1234', 'lena@example.com'),
(5, 1, 'Anders Karlsson', 'Male', 'Kungsgatan 15', '1982-03-12', '820312-7890', 'anders@example.com'),
(6, 1, 'Lina Berg', 'Female', 'Vasagatan 20', '1976-09-05', '760905-2345', 'lina@example.com'),
(7, 1, 'Mikaela Eriksson', 'Female', 'Sveavägen 8', '1995-07-18', '950718-5678', 'mikaela@example.com'),
(8, 2, 'Ole Olsen', 'Male', 'Karl Johans gate 2', '1975-09-15', '750915-5678', 'ole@example.com'),
(9, 2, 'Lars Olsen', 'Male', 'Karl Johans gate 5', '1983-06-25', '830625-1234', 'lars@example.com'),
(10, 2, 'Ingrid Hansen', 'Female', 'Dronningens gate 12', '1979-11-10', '791110-5678', 'ingrid@example.com'),
(11, 2, 'Erik Pedersen', 'Male', 'Kongens gate 8', '1990-02-18', '900218-9012', 'erik@example.com'),
(12, 2, 'Andreas Johansen', 'Male', 'Karl Johans gate 15', '1984-09-12', '840912-1234', 'andreas@example.com'),
(13, 2, 'Marte Berg', 'Female', 'Dronningens gate 20', '1977-05-18', '770518-5678', 'marte@example.com'),
(14, 2, 'Jonas Eriksen', 'Male', 'Kongens gate 10', '1993-03-25', '930325-9012', 'jonas@example.com'),
(15, 3, 'Matti Meikäläinen', 'Male', 'Mannerheimintie 3', '1990-03-20', '900320-9876', 'matti@example.com'),
(16, 3, 'Mikko Virtanen', 'Male', 'Mannerheimintie 15', '1987-10-22', '871022-1234', 'mikko@example.com'),
(17, 3, 'Sari Kinnunen', 'Female', 'Aleksanterinkatu 20', '1980-04-28', '800428-5678', 'sari@example.com'),
(18, 3, 'Tuomas Niemi', 'Male', 'Erottajankatu 10', '1995-12-05', '951205-9012', 'tuomas@example.com'),
(19, 3, 'Hanna Lehtonen', 'Female', 'Keskuskatu 5', '1982-07-15', '820715-1234', 'hanna@example.com'),
(20, 3, 'Jari Virtanen', 'Male', 'Pohjoisesplanadi 10', '1979-02-28', '790228-5678', 'jari@example.com'),
(21, 3, 'Sanna Mäkinen', 'Female', 'Esplanadikatu 8', '1990-11-10', '901110-9012', 'sanna@example.com'),
(22, 1, 'Karin Svensson', 'Female', 'Storgatan 10', '1980-06-15', '800615-1234', 'karin@example.com'),
(23, 2, 'Håkon Olsen', 'Male', 'Karl Johans gate 8', '1976-03-20', '760320-5678', 'hakon@example.com'),
(24, 3, 'Leena Virtanen', 'Female', 'Mannerheimintie 5', '1992-09-25', '920925-9012', 'leena@example.com'),
(25, 1, 'Anders Andersson', 'Male', 'Götgatan 5', '1985-11-10', '851110-1234', 'anders@example.com'),
(26, 1,'Ingrid Berg', 'Female', 'Dronningens gate 15', '1979-08-18', '790818-5678', 'ingrid@example.com'),
(27, 3, 'Mikko Niemi', 'Male', 'Erottajankatu 15', '1993-05-30', '930530-9012', 'mikko@example.com'),
(28, 1, 'Emma Gustafsson', 'Female', 'Drottninggatan 12', '1984-08-22', '840822-1234', 'emma@example.com'),
(29, 1, 'Johan Persson', 'Male', 'Sveavägen 5', '1979-04-30', '790430-5678', 'johan@example.com'),
(30, 1, 'Maria Svensson', 'Female', 'Götgatan 8', '1992-12-15', '921215-9012', 'maria@example.com'),
(31, 2, 'Knut Andersen', 'Male', 'Karl Johans gate 18', '1986-07-10', '860710-1234', 'knut@example.com'),
(32, 2, 'Lise Hansen', 'Female', 'Dronningens gate 5', '1977-02-25', '770225-5678', 'lise@example.com'),
(33, 2, 'Oskar Pedersen', 'Male', 'Kongens gate 12', '1994-09-20', '940920-9012', 'oskar@example.com'),
(34, 3, 'Laura Virtanen', 'Female', 'Mannerheimintie 10', '1981-06-18', '810618-1234', 'laura@example.com'),
(35, 3, 'Ville Lahtinen', 'Male', 'Aleksanterinkatu 15', '1978-03-05', '780305-5678', 'ville@example.com'),
(36, 3, 'Tiina Mäki', 'Female', 'Esplanadikatu 3', '1991-11-30', '911130-9012', 'tiina@example.com'),
(37, 1, 'Lotta Eriksson', 'Female', 'Kungsgatan 20', '1983-09-22', '830922-1234', 'lotta@example.com'),
(38, 1, 'Stefan Lundqvist', 'Male', 'Vasagatan 8', '1975-05-28', '750528-5678', 'stefan@example.com'),
(39, 1, 'Sofia Johansson', 'Female', 'Storgatan 18', '1990-12-10', '901210-9012', 'sofia@example.com'),
(40, 2, 'Elin Olsen', 'Female', 'Karl Johans gate 25', '1985-07-15', '850715-1234', 'elin@example.com'),
(41, 2, 'Ole Kristoffersen', 'Male', 'Dronningens gate 18', '1979-04-28', '790428-5678', 'ole@example.com'),
(42, 2, 'Sofie Larsen', 'Female', 'Kongens gate 15', '1992-10-05', '921005-9012', 'sofie@example.com');

-- Lägg till data i Country-tabellen
INSERT INTO Country (CountryID, CountryName)
VALUES 
    (1, 'Sweden'),
    (2, 'Norway'),
    (3, 'Finland'),
	(4, 'Denmark');

-- Skapa en gemensam CTE för att generera alla månader för åren 2021, 2022 och 2023
WITH Months AS (
    SELECT DATEFROMPARTS(2021, 1, 1) AS OrderDate
    UNION ALL
    SELECT DATEADD(MONTH, 1, OrderDate)
    FROM Months
    WHERE OrderDate < '2024-03-31'
)

-- Skapa data för Order-tabellen med alla månader för åren 2021, 2022 och 2023
INSERT INTO [Order] (OrderID, CustomerID, ProductID, SupplierID, OrderDate, TotalAmount)
SELECT 
    ROW_NUMBER() OVER (ORDER BY NEWID()) AS OrderID,
    CustomerID,
    ABS(CHECKSUM(NEWID())) % 12 + 1 AS ProductID, -- Slumpmässigt välj en produkt
    ABS(CHECKSUM(NEWID())) % 3 + 1 AS SupplierID, -- Slumpmässigt välj en leverantör
    m.OrderDate, -- Datum för varje månad
    ABS(CHECKSUM(NEWID())) % 1500 + 500 AS TotalAmount -- Slumpmässigt välj ett belopp mellan 500 och 2000
FROM
    Customer
CROSS JOIN
    Months m;



-- Lägg till data i SaleChannel-tabellen
INSERT INTO SaleChannel (SaleChannelID, ChannelName)
VALUES 
    (1, 'Online'),
    (2, 'Physical Store'),
    (3, 'Telesales'),
    (4, 'Wholesale'),
    (5, 'E-commerce'),
    (6, 'Catalog'),
    (7, 'Trade Show');

-- Lägg till data i SalePerson-tabellen
INSERT INTO SalePerson (SalePersonID, SalePersonName)
VALUES 
    (1, 'Emma Smith'),
    (2, 'John Johnson'),
    (3, 'Maria Garcia'),
    (4, 'Michael Brown'),
    (5, 'Jennifer Miller');

-- Lägg till data i Region-tabellen som matchar länderna
INSERT INTO Region (RegionID, RegionName)
VALUES 
    (1, 'Sweden'),
    (2, 'Norway'),
    (3, 'Finland'),
	(4, 'Denmark');


-- Skapa en temporär tabell med datum för varje månad från januari 2023 till december 2024
WITH Months AS (
    SELECT DATEFROMPARTS(2021, 1, 1) AS SaleDate
    UNION ALL
    SELECT DATEADD(MONTH, 1, SaleDate)
    FROM Months
    WHERE SaleDate < '2024-03-31'
)

-- Skapa data för Sale-tabellen med försäljningar för varje månad och kund
INSERT INTO Sale (SaleID, SaleDate, SaleAmount, ProductID, CustomerID, SaleChannelID, SalePersonID)
SELECT 
    ROW_NUMBER() OVER (ORDER BY NEWID()) AS SaleID,
    m.SaleDate,
    ABS(CHECKSUM(NEWID())) % 4790 + 500 AS SaleAmount, -- Slumpmässigt välj ett belopp mellan 500 och 2000
    ABS(CHECKSUM(NEWID())) % 12 + 1 AS ProductID, -- Slumpmässigt välj en produkt
    c.CustomerID,
    ABS(CHECKSUM(NEWID())) % 7 + 1 AS SaleChannelID, -- Slumpmässigt välj en försäljningskanal
    ABS(CHECKSUM(NEWID())) % 5 + 1 AS SalePersonID -- Slumpmässigt välj en säljare
FROM
    Customer c
CROSS JOIN
    Months m;


-- Skapa data för OrderDetail-tabellen som matchar befintliga ordrar och produkter
INSERT INTO OrderDetail (OrderDetailID, OrderID, ProductID, Quantity, Price)
SELECT 
    ROW_NUMBER() OVER (ORDER BY NEWID()) AS OrderDetailID,
    [Order].OrderID,
    [Order].ProductID,
    ABS(CHECKSUM(NEWID())) % 12 + 1 AS Quantity, -- Slumpmässigt antal produkter mellan 1 och 12
    Product.ProductPrice AS Price -- Använd produktens pris
FROM 
    [Order]
INNER JOIN 
    Product ON [Order].ProductID = Product.ProductID;

-- Skapa data för CustomerCountry-tabellen som matchar befintliga kunder och länder
INSERT INTO CustomerCountry (CustomerID, CountryID)
SELECT 
    Customer.CustomerID,
    Customer.CountryID
FROM 
    Customer;

-- Skapa data för ChannelSalesPerson-tabellen med unika kombinationer av försäljningskanaler och säljare
INSERT INTO ChannelSalePerson (SaleChannelID, SalePersonID)
SELECT DISTINCT
    s.SaleChannelID,
    s.SalePersonID
FROM 
    (
        SELECT DISTINCT
            ABS(CHECKSUM(NEWID())) % 7 + 1 AS SaleChannelID,
            ABS(CHECKSUM(NEWID())) % 5 + 1 AS SalePersonID
        FROM 
            Sale
    ) AS s
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM ChannelSalePerson csp
        WHERE csp.SaleChannelID = s.SaleChannelID
        AND csp.SalePersonID = s.SalePersonID
    );


-- Lägg till data i SaleRegion-tabellen med slumpmässiga regioner
INSERT INTO SaleRegion (SaleID, RegionID)
SELECT s.SaleID, ABS(CHECKSUM(NEWID())) % 3 + 1 AS RegionID
FROM Sale s;

UPDATE Supplier
SET LastOrderDate = (
    SELECT MAX(OrderDate)
    FROM [Order]
    WHERE [Order].SupplierID = Supplier.SupplierID
);

UPDATE Supplier
SET TotalOrders = (
    SELECT COUNT(*)
    FROM [Order]
    WHERE [Order].SupplierID = Supplier.SupplierID
);


UPDATE Supplier
SET TotalAmount = (
    SELECT SUM(TotalAmount)
    FROM [Order]
    WHERE [Order].SupplierID = Supplier.SupplierID
);

UPDATE Supplier
SET Rating = (
    SELECT CASE 
               WHEN TotalOrders >= 100 THEN 5
               WHEN TotalOrders >= 50 THEN 4
               WHEN TotalOrders >= 20 THEN 3
               WHEN TotalOrders >= 10 THEN 2
               ELSE 1
           END
    FROM (
        SELECT COUNT(*) AS TotalOrders
        FROM [Order]
        WHERE [Order].SupplierID = Supplier.SupplierID
    ) AS SupplierOrders
);

UPDATE Supplier
SET LastOrderDate = '2022-05-10',
    TotalOrders = 3,
    TotalAmount = 5200.00,
    Rating = CASE 
                 WHEN TotalOrders >= 100 THEN 5
                 WHEN TotalOrders >= 50 THEN 4
                 WHEN TotalOrders >= 20 THEN 3
                 WHEN TotalOrders >= 10 THEN 2
                 ELSE 1
             END
WHERE SupplierID = 4;