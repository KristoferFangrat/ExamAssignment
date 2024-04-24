SELECT * 
FROM Review
WHERE EventID NOT IN (SELECT EventID FROM Event);


USE PhantomFestivities;
GO
SELECT u.UserID, u.FirstName, u.LastName, b.NumberOfTickets, b.TotalPrice
FROM Booking b
JOIN [User] u ON b.UserID = u.UserID
ORDER BY u.UserID; 

SELECT * 
FROM Event e
JOIN EventLocation el ON e.EventID = el.EventID
JOIN EventAdvertisement ea on e.EventID = ea.EventID;

SELECT *
FROM HauntedPlace;