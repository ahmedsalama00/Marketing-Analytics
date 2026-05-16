SELECT * FROM customers;
SELECT * FROM geography;
 
SELECT c.CustomerID,c.CustomerName,c.Email,c.Gender,c.Age,g.Country,g.City
FROM customers AS c
 JOIN geography as g
ON c.GeographyID=G.GeographyID; 