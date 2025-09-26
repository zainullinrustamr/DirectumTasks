SELECT 
    Se.Surname AS Фамилия,
    Se.Name AS Имя,
    SUM(COALESCE(Sa.Quantity, 0) * COALESCE(P.Price, 0)) AS Объем_продаж
FROM 
    Sellers Se
LEFT JOIN 
    Sales Sa ON Sa.IDSel = Se.ID and Sa.SDate BETWEEN '2013-10-01' AND '2013-10-07'
LEFT JOIN
	Products P ON P.ID = Sa.IDProd  	
GROUP BY 
    Se.ID, Se.Surname, Se.Name
ORDER BY 
    Объем_продаж DESC
	
	

	
	
	
	