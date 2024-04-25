SELECT COUNT(c.CustomerID)
FROM Customer c;

SELECT *
FROM Product;

SELECT *
FROM [Order] o
JOIN Product p ON o.OrderID = p.OrderID
JOIN Sale s ON o.OrderID = s.OrderID;