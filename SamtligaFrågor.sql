
-- topp 10 produkter
SELECT TOP 10 p.Name, p.ProductID, SUM(s.QuantitySold) AS TotalSales, CONCAT_WS(' - ', r.Rating, r.Text) As RatingWithText
FROM Product p
JOIN Sale s ON p.ProductID = s.ProductID
JOIN Review r ON p.ReviewID = r.ReviewID
GROUP BY p.Name, p.ProductID, r.Rating, r.Text
ORDER BY TotalSales DESC;
-- största kunden
SELECT TOP 1 c.CustomerID, CONCAT_WS(' ', c.FirstName, c.LastName) AS FullName
FROM Customer c
JOIN [Order] o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY FullName DESC;
--revenue
SELECT SUM(s.TotalPrice) AS TotalRevenue
FROM Sale s
JOIN Product p ON s.ProductID = p.ProductID;
--bäst säljande månad
SELECT SUM(o.OrderID) As BestSellingMonth, o.OrderDate, o.OrderID
FROM [Order] o
WHERE o.OrderDate > '2023-10-01'
GROUP BY o.OrderID, o.OrderDate
ORDER BY o.OrderDate;
--produkter med högst och lägst betyg
SELECT p.Name AS ProductName, CONCAT_WS(' - ', r.Rating, r.Text) AS RatingWithText
FROM Review r
JOIN Product p ON r.ReviewID = p.ReviewID
WHERE r.Rating = 5 OR r.Rating = 1; 

SELECT AVG(p.ProductID) AS AverageProductsInOrder
FROM [Order] o
JOIN Product p ON o.OrderID = p.OrderID
WHERE o.OrderID = 1;

SELECT *
FROM ProductCategory pc
JOIN Product p ON pc.CategoryID = p.ProductCategoryID;

SELECT COUNT(s.SupplierID) BiggestSupplier, s.Name
	FROM Supplier s
JOIN SupplierType st ON s.SupplierID = st.SupplierID
JOIN Product p ON s.SupplierID = p.SupplierID
GROUP BY s.Name, s.SupplierID;