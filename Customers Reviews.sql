SELECT * FROM customer_reviews;
SELECT ReviewID, CustomerID, ProductID, ReviewDate, Rating,
REPLACE(ReviewText,'  ',' ')
FROM customer_reviews;