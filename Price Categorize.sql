SELECT ProductID,
	   ProductName,
	   Category,
	   Price,
CASE 
WHEN Price <50 then 'Low'
WHEN Price Between 50 AND 200 THEN 'Meduim'
ELSE 'High'
END AS PriceCategory
	   FROM products

