-- Skapa databas för Djurgårdens IF e-handel
CREATE DATABASE ehandel;
GO

-- Använd den skapade databasen
USE ehandel;
GO

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
	Gender NVARCHAR(10) NOT NULL,
	DateOfBirth DATE NOT NULL,
    Address NVARCHAR(255) NOT NULL,
	Region NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL
);

-- Skapa tabell för produkter
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
	OrderID INT
);


-- Skapa tabell för kategorier
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
	ProductID INT
);

-- Skapa tabell för beställningar
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    Status NVARCHAR(50) NOT NULL,
	ProductID INT,
	CustomerID INT NOT NULL,
);


-- Skapa tabell för varukorgar
CREATE TABLE ShoppingCart (
    ShoppingCartID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
);

-- Skapa tabell för transaktionsloggar
CREATE TABLE TransactionLog (
    LogID INT PRIMARY KEY,
    Timestamp DATETIME NOT NULL,
    Action NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
	OrderID INT
);

-- Skapa tabell för inventarier
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated DATETIME NOT NULL
);

-- Skapa tabellen Supplier
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(100),
	ProductID INT
);

-- Lägg till kunder
-- Lägg till kunder med kön baserat på önskad fördelning
INSERT INTO Customer (CustomerID, FirstName, LastName, Gender, Address, Region, Email)
-- Kvinnor
VALUES 
(1, 'Anna', 'Andersson', 'Female', 'Storgatan 1', 'Stockholm', 'anna.andersson@example.com'),
(2, 'Maria', 'Karlsson', 'Female', 'Kungsgatan 2', 'Östermalm', 'maria.karlsson@example.com'),
(3, 'Lena', 'Lindberg', 'Female', 'Karlavägen 3', 'Norrmalm', 'lena.lindberg@example.com'),
(4, 'Sara', 'Svensson', 'Female', 'Sveavägen 4', 'Sankt Eriksområdet', 'sara.svensson@example.com'),
(5, 'Caroline', 'Carlitsson', 'Female', 'Carlgatan 5', 'Östermalm', 'caroline.carlitsson@example.com'),
(6, 'Emelie', 'Emelieson', 'Female', 'Emeliegatan 6', 'Södermalm', 'emelie.emelieson@example.com'),
(7, 'Josefin', 'Josefinson', 'Female', 'Josefinsgatan 7', 'Vasastan', 'josefin.josefinson@example.com'),
(8, 'Sofia', 'Sofiasson', 'Female', 'Sofiatorget 8', 'Södermalm', 'sofia.sofiasson@example.com'),
(9, 'Helena', 'Helensson', 'Female', 'Helenagatan 9', 'Östermalm', 'helena.helensson@example.com'),
(10, 'Maja', 'Majasson', 'Female', 'Majagatan 10', 'Södermalm', 'maja.majasson@example.com'),
(11, 'Emma', 'Engström', 'Female', 'Rörstrandsgatan 11', 'Vasastan', 'emma.engstrom@example.com'),
(12, 'Therese', 'Theresesson', 'Female', 'Theresegatan 12', 'Östermalm', 'therese.theresesson@example.com'),
(13, 'Caroline', 'Carlitsson', 'Female', 'Carlgatan 13', 'Kungsholmen', 'caroline.carlitsson@example.com'),
(14, 'Elin', 'Elindotter', 'Female', 'Elinvägen 14', 'Norrmalm', 'elin.elindotter@example.com'),
(15, 'Anna', 'Annasson', 'Female', 'Annagatan 15', 'Gamla Stan', 'anna.annasson@example.com'),
(16, 'Linda', 'Lindsson', 'Female', 'Lindgatan 16', 'Södermalm', 'linda.lindsson@example.com'),
(17, 'Maria', 'Mariasdotter', 'Female', 'Mariavägen 17', 'Vasastan', 'maria.mariasdotter@example.com'),
(18, 'Josefin', 'Josefinson', 'Female', 'Josefinsgatan 18', 'Gamla Stan', 'josefin.josefinson@example.com'),
(19, 'Sara', 'Sarasdotter', 'Female', 'Sarasgatan 19', 'Södermalm', 'sara.sarasdotter@example.com'),
-- Män
(20, 'Erik', 'Eriksson', 'Male', 'Erikgatan 20', 'Kungsholmen', 'erik.eriksson@example.com'),
(21, 'Johan', 'Johansson', 'Male', 'Johansgatan 21', 'Gamla Stan', 'johan.johansson@example.com'),
(22, 'Anders', 'Andersson', 'Male', 'Andersgatan 22', 'Norrmalm', 'anders.andersson@example.com'),
(23, 'Oscar', 'Oscarsson', 'Male', 'Oscargatan 23', 'Vasastan', 'oscar.oscarsson@example.com'),
(24, 'Peter', 'Petersson', 'Male', 'Petergatan 24', 'Östermalm', 'peter.petersson@example.com'),
(25, 'Fredrik', 'Fredriksson', 'Male', 'Fredriksgatan 25', 'Södermalm', 'fredrik.fredriksson@example.com'),
(26, 'Niklas', 'Niklasson', 'Male', 'Niklasvägen 26', 'Norrmalm', 'niklas.niklasson@example.com'),
(27, 'Martin', 'Martinsson', 'Male', 'Martingatan 27', 'Gamla Stan', 'martin.martinsson@example.com'),
(28, 'Henrik', 'Henriksson', 'Male', 'Henriksgatan 28', 'Vasastan', 'henrik.henriksson@example.com'),
(29, 'David', 'Davidsson', 'Male', 'Davidsgatan 29', 'Östermalm', 'david.davidsson@example.com'),
(30, 'Andreas', 'Andersson', 'Male', 'Andersgatan 30', 'Kungsholmen', 'andreas.andersson@example.com'),
(31, 'Daniel', 'Danielsson', 'Male', 'Danielsgatan 31', 'Norrmalm', 'daniel.danielsson@example.com'),
(32, 'Linus', 'Linusson', 'Male', 'Linusgatan 32', 'Vasastan', 'linus.linusson@example.com'),
(33, 'Oskar', 'Oskarsson', 'Male', 'Oskargatan 33', 'Gamla Stan', 'oskar.oskarsson@example.com'),
(34, 'Hampus', 'Hampusson', 'Male', 'Hampusgatan 34', 'Södermalm', 'hampus.hampusson@example.com'),
(35, 'Jakob', 'Jakobsson', 'Male', 'Jakobsgatan 35', 'Norrmalm', 'jakob.jakobsson@example.com'),
(36, 'Jonathan', 'Jonathansson', 'Male', 'Jonathansgatan 36', 'Östermalm', 'jonathan.jonathansson@example.com'),
(37, 'Sebastian', 'Sebastiansson', 'Male', 'Sebastiansgatan 37', 'Kungsholmen', 'sebastian.sebastiansson@example.com'),
(38, 'Felix', 'Felixson', 'Male', 'Felixgatan 38', 'Vasastan', 'felix.felixson@example.com'),
(39, 'Markus', 'Markusson', 'Male', 'Markusgatan 39', 'Gamla Stan', 'markus.markusson@example.com'),
(40, 'Filip', 'Filipsson', 'Male', 'Filipsgatan 40', 'Kungsholmen', 'filip.filipsson@example.com'),
(41, 'Karl', 'Karlsson', 'Male', 'Karlsgatan 41', 'Östermalm', 'karl.karlsson@example.com'),
(42, 'Emil', 'Emilsson', 'Male', 'Emilsgatan 42', 'Södermalm', 'emil.emilsson@example.com');

-- Lägg till olika produkter för Djurgårdens IF
INSERT INTO Product (ProductID, Name, Description, Price, Stock, OrderID)
VALUES 
-- Kläder
(1, 'DIF Fotbollströja Junior', 'Officiell fotbollströja för barn', 299.99, 50, NULL),
(2, 'DIF Barnmössa', 'En varm mössa med Djurgårdens IF-logotyp för barn', 99.99, 100, NULL),
(3, 'DIF Barn T-shirt', 'En T-shirt med Djurgårdens IF-tryck för barn', 149.99, 80, NULL),
(4, 'DIF Barn Hoodie', 'En mysig hoodie med Djurgårdens IF-emblem för barn', 199.99, 30, NULL),
(5, 'DIF Barn Jeans', 'Jeans i barnstorlek med Djurgårdens IF-logotyp', 349.99, 60, NULL),
-- Merchandise
(6, 'DIF Nyckelring', 'En nyckelring med Djurgårdens IF-logotyp', 59.99, 120, NULL),
(7, 'DIF Magnet', 'En magnet att pryda kylskåpet med', 19.99, 200, NULL),
(8, 'DIF Flagga', 'En flagga att visa support för Djurgårdens IF', 99.99, 70, NULL),
-- Utrustning
(9, 'DIF Fotboll', 'Officiell matchboll för Djurgårdens IF', 1999.99, 40, NULL),
(10, 'DIF Fotbollsskor', 'Specialdesignade fotbollsskor för spelare i Djurgårdens IF', 2499.99, 30, NULL),
-- Accessoarer
(11, 'DIF Barn Keps', 'En snygg keps med justerbar rem för barn', 99.99, 100, NULL),
(12, 'DIF Vattenflaska', 'En vattenflaska med Djurgårdens IF-logotyp', 49.99, 150, NULL),
-- Lyxiga produkter
(13, 'DIF Guldarmband', 'Ett exklusivt armband i 18 karats guld med Djurgårdens IF-emblem', 9999.99, 5, NULL),
(14, 'DIF Lyxklocka', 'En lyxig klocka med diamantinläggningar och Djurgårdens IF-logotyp', 14999.99, 3, NULL),
-- Övrigt
(15, 'DIF Teddybjörn', 'En gosig teddybjörn med Djurgårdens IF-tröja', 199.99, 200, NULL),
(16, 'DIF Muggset', 'Ett set med två muggar med Djurgårdens IF-tryck', 49.99, 150, NULL),
(17, 'DIF Väggkonst', 'En konstnärlig tavla med motiv från Djurgårdens IF', 499.99, 20, NULL),
-- Kläder (fortsättning)
(18, 'DIF Baby Body', 'En söt baby body med Djurgårdens IF-logotyp', 149.99, 50, NULL),
(19, 'DIF Baby Mössa', 'En mjuk och varm mössa för de minsta', 79.99, 80, NULL),
(20, 'DIF Baby Tossor', 'Tossor för bebisar med Djurgårdens IF-tryck', 99.99, 60, NULL),
-- Merchandise (fortsättning)
(21, 'DIF Nyckelband', 'Ett nyckelband med Djurgårdens IF-logo', 29.99, 200, NULL),
(22, 'DIF Armband', 'Ett armband med Djurgårdens IF-emblem', 39.99, 150, NULL),
(23, 'DIF Pennset', 'Ett set med tre pennor med Djurgårdens IF-tryck', 59.99, 100, NULL),
-- Utrustning (fortsättning)
(24, 'DIF Fotbollsstrumpor', 'Fotbollsstrumpor för träning och matchspel', 99.99, 120, NULL),
(25, 'DIF Träningsväst', 'En träningsväst för uppvärmning och träning', 199.99, 80, NULL),
(26, 'DIF Fotbollshandskar', 'Målvaktshandskar för bästa skydd', 399.99, 40, NULL),
-- Accessoarer (fortsättning)
(27, 'DIF Barn Ryggsäck', 'En barnryggsäck med Djurgårdens IF-logo', 249.99, 50, NULL),
(28, 'DIF Nyckelring', 'En nyckelring med Djurgårdens IF-emblem', 29.99, 120, NULL),
(29, 'DIF Scarf', 'En scarf i klubbfärger för att hålla värmen', 149.99, 80, NULL),
-- Lyxiga produkter (fortsättning)
(30, 'DIF Diamantörhängen', 'Elegant örhängen med inläggningar av äkta diamanter', 29999.99, 2, NULL),
(31, 'DIF Lyxig Fotboll', 'En fotboll i äkta läder med guldpläterade detaljer', 4999.99, 5, NULL),
-- Övrigt (fortsättning)
(32, 'DIF Kylskåpsmagnet', 'En magnet att pryda kylskåpet med', 19.99, 200, NULL),
(33, 'DIF Nyckelband', 'Ett nyckelband med avtagbart spänne', 49.99, 150, NULL),
(34, 'DIF Väggklocka', 'En väggklocka med Djurgårdens IF-logo',699.99, 20, NULL),
-- Kläder (fortsättning)
(35, 'DIF Baby T-shirt', 'En T-shirt med Djurgårdens IF-tryck för spädbarn', 99.99, 70, NULL),
(36, 'DIF Vinteroverall Barn', 'En varm overall för kalla dagar', 599.99, 30, NULL),
(37, 'DIF Fleecefilt Barn', 'En mjuk filt med Djurgårdens IF-logotyp för barn', 199.99, 40, NULL),
-- Merchandise (fortsättning)
(38, 'DIF Hårband', 'Ett hårband med Djurgårdens IF-emblem', 19.99, 100, NULL),
(39, 'DIF Nyckelband', 'Ett nyckelband med Djurgårdens IF-logo', 29.99, 200, NULL),
(40, 'DIF Plånbok', 'En plånbok med Djurgårdens IF-tryck', 99.99, 150, NULL),
-- Utrustning (fortsättning)
(41, 'DIF Fotbollsskor', 'Specialdesignade fotbollsskor för spelare i Djurgårdens IF', 2999.99, 20, NULL),
(42, 'DIF Fotbollsshorts', 'Andningsaktiva fotbollsshorts för träning och match', 499.99, 40, NULL),
(43, 'DIF Fotbollshandskar', 'Målvaktshandskar för bästa skydd', 899.99, 30, NULL),
-- Accessoarer (fortsättning)
(44, 'DIF Barn Keps', 'En snygg keps med justerbar rem för barn', 79.99, 80, NULL),
(45, 'DIF Scarf', 'En scarf i klubbfärger för att hålla värmen', 149.99, 60, NULL),
(46, 'DIF Nyckelring', 'En nyckelring med Djurgårdens IF-emblem', 49.99, 120, NULL),
-- Lyxiga produkter (fortsättning)
(47, 'DIF Diamantörhängen', 'Elegant örhängen med inläggningar av äkta diamanter', 59999.99, 1, NULL),
(48, 'DIF Lyxig Fotboll', 'En fotboll i äkta läder med guldpläterade detaljer', 9999.99, 3, NULL),
-- Övrigt (fortsättning)
(49, 'DIF Kylskåpsmagnet', 'En magnet att pryda kylskåpet med', 19.99, 200, NULL),
(50, 'DIF Nyckelband', 'Ett nyckelband med avtagbart spänne', 49.99, 150, NULL),
(51, 'DIF Väggklocka', 'En väggklocka med Djurgårdens IF-logo', 499.99, 20, NULL);

-- Lägg till kategorier för produkter
INSERT INTO Category (CategoryID, Name, ProductID)
VALUES 
-- Kläder
(1, 'Kläder', 1), -- DIF Fotbollströja Junior
(1, 'Kläder', 2), -- DIF Barnmössa
(1, 'Kläder', 3), -- DIF Barn T-shirt
(1, 'Kläder', 4), -- DIF Barn Hoodie
(1, 'Kläder', 5), -- DIF Barn Jeans
(1, 'Kläder', 18), -- DIF Baby Body
(1, 'Kläder', 19), -- DIF Baby Mössa
(1, 'Kläder', 20), -- DIF Baby Tossor
(1, 'Kläder', 52), -- DIF Baby Overall
(1, 'Kläder', 53), -- DIF Dam Träningstights
(1, 'Kläder', 54), -- DIF Herr Jacka
-- Merchandise
(2, 'Merchandise', 6), -- DIF Nyckelring
(2, 'Merchandise', 7), -- DIF Magnet
(2, 'Merchandise', 8), -- DIF Flagga
(2, 'Merchandise', 38), -- DIF Hårband
(2, 'Merchandise', 39), -- DIF Nyckelband
(2, 'Merchandise', 40), -- DIF Plånbok
(2, 'Merchandise', 55), -- DIF Nyckelring
(2, 'Merchandise', 56), -- DIF Väska
(2, 'Merchandise', 57), -- DIF Solglasögon
-- Utrustning
(3, 'Utrustning', 9), -- DIF Fotboll
(3, 'Utrustning', 10), -- DIF Fotbollsskor
(3, 'Utrustning', 58), -- DIF Fotbollsmål
(3, 'Utrustning', 59), -- DIF Fotbollsväska
(3, 'Utrustning', 60), -- DIF Vattenflaska
(3, 'Utrustning', 41), -- DIF Fotbollsskor
(3, 'Utrustning', 42), -- DIF Fotbollsshorts
(3, 'Utrustning', 43), -- DIF Fotbollshandskar
-- Accessoarer
(4, 'Accessoarer', 11), -- DIF Barn Keps
(4, 'Accessoarer', 12), -- DIF Vattenflaska
(4, 'Accessoarer', 61), -- DIF Sportarmband
(4, 'Accessoarer', 62), -- DIF Paraply
(4, 'Accessoarer', 63), -- DIF Näsduk
(4, 'Accessoarer', 44), -- DIF Barn Keps
(4, 'Accessoarer', 45), -- DIF Scarf
(4, 'Accessoarer', 46), -- DIF Nyckelring
-- Lyxiga produkter
(5, 'Lyxiga produkter', 13), -- DIF Guldarmband
(5, 'Lyxiga produkter', 14), -- DIF Lyxklocka
(5, 'Lyxiga produkter', 47), -- DIF Diamantörhängen
(5, 'Lyxiga produkter', 48), -- DIF Lyxig Fotboll
(5, 'Lyxiga produkter', 64), -- DIF Guldarmband
(5, 'Lyxiga produkter', 65), -- DIF Lyxig Fotbollssko
-- Övrigt
(6, 'Övrigt', 15), -- DIF Teddybjörn
(6, 'Övrigt', 16), -- DIF Muggset
(6, 'Övrigt', 17), -- DIF Väggkonst
(6, 'Övrigt', 66), -- DIF Kudde
(6, 'Övrigt', 67), -- DIF USB-minne
(6, 'Övrigt', 68) -- DIF Klockradio
-- Lägg till fler kategorier och produkter här om det behövs
;

-- Lägg till 100 slumpmässiga ordrar för åren 2022 och 2023
DECLARE @counter INT = 1;

WHILE @counter <= 100
BEGIN
    -- Generera slumpmässiga värden för OrderID, OrderDate, Status, ProductID och CustomerID
    DECLARE @OrderID INT = @counter;
    DECLARE @OrderDate DATE;

    -- Slumpmässigt välj mellan 2022 och 2023
    IF @counter % 2 = 0
        SET @OrderDate = DATEADD(year, 1, DATEADD(day, -@counter, '2022-01-01')); -- Slumpmässigt datum inom 2022
    ELSE
        SET @OrderDate = DATEADD(day, -@counter, '2023-01-01'); -- Slumpmässigt datum inom 2023

    DECLARE @Status NVARCHAR(50) = CASE WHEN @counter % 2 = 0 THEN 'Completed' ELSE 'In Progress' END;
    DECLARE @ProductID INT = ABS(CHECKSUM(NEWID())) % 100 + 1; -- Slumpmässigt ProductID mellan 1 och 100
    DECLARE @CustomerID INT = ABS(CHECKSUM(NEWID())) % 42 + 1; -- Slumpmässigt CustomerID mellan 1 och 42

    -- Lägg till den slumpmässiga ordern i tabellen
    INSERT INTO [Order] (OrderID, OrderDate, Status, ProductID, CustomerID)
    VALUES (@OrderID, @OrderDate, @Status, @ProductID, @CustomerID);

    SET @counter = @counter + 1;
END;

-- Lägg till data i tabellen ShoppingCart
INSERT INTO ShoppingCart (ShoppingCartID, CustomerID, ProductID, Quantity) VALUES (1, 10, 50, 3);
INSERT INTO ShoppingCart (ShoppingCartID, CustomerID, ProductID, Quantity) VALUES (2, 15, 20, 1);


-- Lägg till data i tabellen TransactionLog
INSERT INTO TransactionLog (LogID, Timestamp, Action, Description, OrderID) VALUES (1, '2024-04-26 15:30:00', 'Purchase', 'Successful transaction', 100);
INSERT INTO TransactionLog (LogID, Timestamp, Action, Description, OrderID) VALUES (2, '2024-04-25 11:00:00', 'Refund', 'Refunded transaction', 50);


-- Lägg till data i tabellen Inventory
INSERT INTO Inventory (InventoryID, ProductID, Quantity, LastUpdated) VALUES (1, 75, 20, '2024-04-26 10:00:00');
INSERT INTO Inventory (InventoryID, ProductID, Quantity, LastUpdated) VALUES (2, 30, 15, '2024-04-25 09:00:00');


-- Lägg till data i tabellen Supplier
INSERT INTO Supplier (SupplierID, Name, ContactInfo, ProductID) VALUES (1, 'Supplier A', 'contact@suppliera.com', 60);
INSERT INTO Supplier (SupplierID, Name, ContactInfo, ProductID) VALUES (2, 'Supplier B', 'contact@supplierb.com', 40);



ALTER TABLE [Order]
ADD CONSTRAINT FK_Order_Product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO
ALTER TABLE [Order]
CHECK CONSTRAINT FK_Order_Product;
GO

ALTER TABLE Category
ADD CONSTRAINT FK_Category_Product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO
ALTER TABLE Category
CHECK CONSTRAINT FK_Category_Product;
GO

ALTER TABLE ShoppingCart
ADD CONSTRAINT FK_ShoppingCart_Product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO
ALTER TABLE ShoppingCart
CHECK CONSTRAINT FK_ShoppingCart_Product;
GO

ALTER TABLE ShoppingCart
ADD CONSTRAINT FK_Customer_ShoppingCart
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO
ALTER TABLE ShoppingCart
CHECK CONSTRAINT FK_Customer_ShoppingCart;


ALTER TABLE [TransactionLog]
ADD CONSTRAINT FK_OrderID_TransactionLog
FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);
GO
ALTER TABLE [TransactionLog]
CHECK CONSTRAINT FK_OrderID_TransactionLog;
GO

ALTER TABLE Inventory
ADD CONSTRAINT FK_Product_Inventory
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO
ALTER TABLE Inventory
CHECK CONSTRAINT FK_Product_Inventory;
GO

ALTER TABLE Supplier
ADD CONSTRAINT FK_Product_supplier
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO
ALTER TABLE Supplier
CHECK CONSTRAINT FK_Product_Supplier;
GO