SELECT 
EngagementID,
ContentID,
CampaignID,
ProductID,
Likes,
UPPER(REPLACE(ContentType,'Socialmedia','Social Media')) AS ContentType,
LEFT(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) AS Views,
Right(ViewsClicksCombined,LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)) AS Clicks,
FORMAT(CONVERT(DATE,EngagementDate),'MM-dd-yyyy') AS EngagementDate
FROM engagement_data
WHERE ContentType <> 'Newsletter';