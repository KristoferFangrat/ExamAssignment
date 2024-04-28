CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    SupplierAddress VARCHAR(255),
    SupplierContactInfo VARCHAR(100)
);

-- Skapa CustomerSegment Table
CREATE TABLE CustomerSegment (
    CustomerSegmentID INT PRIMARY KEY,
    SegmentName VARCHAR(100)
);


-- Skapa Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Skapa Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
	ProductID INT,
    CategoryName VARCHAR(100),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Skapa Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
	CustomerSegmentID INT,
	CountryID INT,
    CustomerName VARCHAR(100),
    Gender VARCHAR(10),
    Address VARCHAR(255),
    Birthday DATE,
    PersonalNumber VARCHAR(20),
    ContactInfo VARCHAR(100),
    FOREIGN KEY (CustomerSegmentID) REFERENCES CustomerSegment(CustomerSegmentID)
);

CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
	CustomerID INT,
    CountryName VARCHAR(100),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- Skapa Order Table
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
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
    ProductID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    CustomerID INT,
    SaleChannelID INT,
    SalePersonID INT,
    RegionID INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SaleChannelID) REFERENCES SaleChannel(SaleChannelID),
    FOREIGN KEY (SalePersonID) REFERENCES SalePerson(SalePersonID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Lägg till leverantörer
INSERT INTO Supplier (SupplierID, SupplierName, SupplierAddress, SupplierContactInfo)
VALUES 
(1, 'Svensk Teknik AB', 'Storgatan 15', 'info@svenskteknik.se'),
(2, 'ModeSverige AB', 'Götgatan 25', 'info@modesverige.se'),
(3, 'Norsk IT AS', 'Karl Johans gate 12', 'info@norskit.no');

-- Lägg till segment
INSERT INTO CustomerSegment (CustomerSegmentID, SegmentName)
VALUES 
(1, 'Premium'),
(2, 'Standard'),
(3, 'Economy');

-- Lägg till produkter
INSERT INTO Product (ProductID, ProductName, SupplierID)
VALUES 
(1, 'Smartphone', 1),
(2, 'Designer Dress', 2),
(3, 'Smart Home Kit', 3);

-- Lägg till kategorier
INSERT INTO Category (CategoryID, ProductID, CategoryName)
VALUES 
(1, 1, 'Electronics'),
(2, 2, 'Fashion'),
(3, 3, 'Home Appliances');

-- Lägg till kunder
INSERT INTO Customer (CustomerID, CustomerSegmentID, CountryID, CustomerName, Gender, Address, Birthday, PersonalNumber, ContactInfo)
VALUES 
(1, 1, 1, 'Anna Andersson', 'Female', 'Storgatan 1', '1980-05-10', '800510-1234', 'anna@example.com'),
(2, 1, 1, 'Eva Svensson', 'Female', 'Götgatan 10', '1985-08-20', '850820-4567', 'eva@example.com'),
(3, 2, 1, 'Per Nilsson', 'Male', 'Storgatan 5', '1978-04-15', '780415-7890', 'per@example.com'),
(4, 3, 1, 'Lena Andersson', 'Female', 'Drottninggatan 3', '1992-11-25', '921125-1234', 'lena@example.com'),
(5, 1, 1, 'Anders Karlsson', 'Male', 'Kungsgatan 15', '1982-03-12', '820312-7890', 'anders@example.com'),
(6, 2, 1, 'Lina Berg', 'Female', 'Vasagatan 20', '1976-09-05', '760905-2345', 'lina@example.com'),
(7, 3, 1, 'Mikaela Eriksson', 'Female', 'Sveavägen 8', '1995-07-18', '950718-5678', 'mikaela@example.com'),
(8, 2, 2, 'Ole Olsen', 'Male', 'Karl Johans gate 2', '1975-09-15', '750915-5678', 'ole@example.com'),
(10, 1, 2, 'Lars Olsen', 'Male', 'Karl Johans gate 5', '1983-06-25', '830625-1234', 'lars@example.com'),
(11, 2, 2, 'Ingrid Hansen', 'Female', 'Dronningens gate 12', '1979-11-10', '791110-5678', 'ingrid@example.com'),
(12, 3, 2, 'Erik Pedersen', 'Male', 'Kongens gate 8', '1990-02-18', '900218-9012', 'erik@example.com'),
(13, 1, 2, 'Andreas Johansen', 'Male', 'Karl Johans gate 15', '1984-09-12', '840912-1234', 'andreas@example.com'),
(14, 2, 2, 'Marte Berg', 'Female', 'Dronningens gate 20', '1977-05-18', '770518-5678', 'marte@example.com'),
(15, 3, 2, 'Jonas Eriksen', 'Male', 'Kongens gate 10', '1993-03-25', '930325-9012', 'jonas@example.com'),
(16, 3, 3, 'Matti Meikäläinen', 'Male', 'Mannerheimintie 3', '1990-03-20', '900320-9876', 'matti@example.com'),
(17, 1, 3, 'Mikko Virtanen', 'Male', 'Mannerheimintie 15', '1987-10-22', '871022-1234', 'mikko@example.com'),
(18, 2, 3, 'Sari Kinnunen', 'Female', 'Aleksanterinkatu 20', '1980-04-28', '800428-5678', 'sari@example.com'),
(19, 3, 3, 'Tuomas Niemi', 'Male', 'Erottajankatu 10', '1995-12-05', '951205-9012', 'tuomas@example.com'),
(20, 1, 3, 'Hanna Lehtonen', 'Female', 'Keskuskatu 5', '1982-07-15', '820715-1234', 'hanna@example.com'),
(21, 2, 3, 'Jari Virtanen', 'Male', 'Pohjoisesplanadi 10', '1979-02-28', '790228-5678', 'jari@example.com'),
(22, 3, 3, 'Sanna Mäkinen', 'Female', 'Esplanadikatu 8', '1990-11-10', '901110-9012', 'sanna@example.com'),
(23, 1, 1, 'Karin Svensson', 'Female', 'Storgatan 10', '1980-06-15', '800615-1234', 'karin@example.com'),
(24, 2, 2, 'Håkon Olsen', 'Male', 'Karl Johans gate 8', '1976-03-20', '760320-5678', 'hakon@example.com'),
(25, 3, 3, 'Leena Virtanen', 'Female', 'Mannerheimintie 5', '1992-09-25', '920925-9012', 'leena@example.com'),
(26, 1, 1, 'Anders Andersson', 'Male', 'Götgatan 5', '1985-11-10', '851110-1234', 'anders@example.com'),
(27, 2, 1,'Ingrid Berg', 'Female', 'Dronningens gate 15', '1979-08-18', '790818-5678', 'ingrid@example.com'),
(28, 3, 3, 'Mikko Niemi', 'Male', 'Erottajankatu 15', '1993-05-30', '930530-9012', 'mikko@example.com'),
(29, 1, 1, 'Emma Gustafsson', 'Female', 'Drottninggatan 12', '1984-08-22', '840822-1234', 'emma@example.com'),
(30, 2, 1, 'Johan Persson', 'Male', 'Sveavägen 5', '1979-04-30', '790430-5678', 'johan@example.com'),
(31, 3, 1, 'Maria Svensson', 'Female', 'Götgatan 8', '1992-12-15', '921215-9012', 'maria@example.com'),
(32, 1, 2, 'Knut Andersen', 'Male', 'Karl Johans gate 18', '1986-07-10', '860710-1234', 'knut@example.com'),
(33, 2, 2, 'Lise Hansen', 'Female', 'Dronningens gate 5', '1977-02-25', '770225-5678', 'lise@example.com'),
(34, 3, 2, 'Oskar Pedersen', 'Male', 'Kongens gate 12', '1994-09-20', '940920-9012', 'oskar@example.com'),
(35, 1, 3, 'Laura Virtanen', 'Female', 'Mannerheimintie 10', '1981-06-18', '810618-1234', 'laura@example.com'),
(36, 2, 3, 'Ville Lahtinen', 'Male', 'Aleksanterinkatu 15', '1978-03-05', '780305-5678', 'ville@example.com'),
(37, 3, 3, 'Tiina Mäki', 'Female', 'Esplanadikatu 3', '1991-11-30', '911130-9012', 'tiina@example.com'),
(38, 1, 1, 'Lotta Eriksson', 'Female', 'Kungsgatan 20', '1983-09-22', '830922-1234', 'lotta@example.com'),
(39, 2, 1, 'Stefan Lundqvist', 'Male', 'Vasagatan 8', '1975-05-28', '750528-5678', 'stefan@example.com'),
(40, 3, 1, 'Sofia Johansson', 'Female', 'Storgatan 18', '1990-12-10', '901210-9012', 'sofia@example.com'),
(41, 1, 2, 'Elin Olsen', 'Female', 'Karl Johans gate 25', '1985-07-15', '850715-1234', 'elin@example.com'),
(42, 2, 2, 'Ole Kristoffersen', 'Male', 'Dronningens gate 18', '1979-04-28', '790428-5678', 'ole@example.com'),
(43, 3, 2, 'Sofie Larsen', 'Female', 'Kongens gate 15', '1992-10-05', '921005-9012', 'sofie@example.com');

-- Lägg till länder
INSERT INTO Country (CountryID, CountryName)
VALUES 
(1, 'Sverige'),
(2, 'Norge'),
(3, 'Finland');

-- Lägg till beställningar
INSERT INTO [Order] (OrderID, CustomerID, OrderDate, TotalAmount)
SELECT 
    ROW_NUMBER() OVER (ORDER BY c.CustomerID) AS OrderID,
    c.CustomerID,
    DATEADD(day, -(ABS(CHECKSUM(NEWID())) % 365), GETDATE()) AS OrderDate, -- slumpmässigt datum under det senaste året
    ROUND(RAND() * 10000, 2) AS TotalAmount -- slumpmässigt belopp upp till 10000
FROM 
    Customer c;

-- Lägg till försäljningskanaler
INSERT INTO SaleChannel (SaleChannelID, ChannelName)
VALUES 
(1, 'Online'),
(2, 'In-Store'),
(3, 'Distributors');

-- Lägg till säljare
INSERT INTO SalePerson (SalePersonID, SalePersonName)
VALUES 
(1, 'Erik Svensson'),
(2, 'Maria Olsen'),
(3, 'Jukka Virtanen');

-- Lägg till regioner
INSERT INTO Region (RegionID, RegionName)
VALUES 
(1, 'Nordic');

-- Lägg till försäljning
INSERT INTO Sale (SaleID, ProductID, SaleDate, SaleAmount, CustomerID, SaleChannelID, SalePersonID, RegionID)
VALUES 
(1, 1, '2021-01-05', 5000, 1, 1, 1, 1),
(2, 2, '2022-02-10', 7000, 1, 1, 1, 1),
(3, 3, '2022-03-15', 10000, 2, 2, 2, 1),
(4, 1, '2023-04-20', 6000, 2, 2, 2, 1),
(5, 2, '2023-05-25', 8000, 3, 1, 1, 1),
(6, 3, '2024-06-30', 9000, 3, 1, 1, 1);


