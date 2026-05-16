SELECT 
    JourneyID,
    CustomerID,
    ProductID,
    VisitDate,
    UPPER(Stage) AS Stage,
    Action,
    COALESCE(Duration,AVG(Duration) OVER(PARTITION BY VisitDate)) AS Duration

FROM ( 
    SELECT *,
    
           ROW_NUMBER() OVER(
               PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
               ORDER BY JourneyID
           ) AS rn
    FROM dbo.customer_journey

) t
    
WHERE rn = 1 ;