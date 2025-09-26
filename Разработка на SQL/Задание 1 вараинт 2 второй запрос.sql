-- Получим общие продажи по каждому товару за период
WITH PSales AS (
    SELECT 
        sa.IDProd,
        SUM(sa.Quantity) AS TotalPSales
    FROM 
        Sales sa
    WHERE 
        sa.SDate BETWEEN '2013-10-01' AND '2013-10-07'
    GROUP BY 
        sa.IDProd
),
-- Получим продажи каждого сотрудника по каждому товару за период
SellerPSales AS (
    SELECT 
        sa.IDProd,
        sa.IDSel,
        SUM(sa.Quantity) AS SellerSales
    FROM 
        Sales sa
    WHERE 
        sa.SDate BETWEEN '2013-10-01' AND '2013-10-07'
    GROUP BY 
        sa.IDProd, sa.IDSel
),
-- Получим продукцию, поступившаю в указанный период
AProducts AS (
    SELECT DISTINCT 
        IDProd
    FROM 
        Arrivals
    WHERE 
        ADate BETWEEN '2013-09-07' AND '2013-10-07'
)

SELECT 
    p.Name AS "Наименование продукции",
    s.Surname AS "Фамилия",
    s.Name AS "Имя",

    ROUND(
        CASE 
            WHEN ps.TotalPSales = 0 THEN 0
            ELSE ((sps.SellerSales / ps.TotalPSales)* 100.0)
        END::numeric, 2
    ) AS "Процент продаж"
FROM 
    SellerPSales sps
INNER JOIN 
    PSales ps ON sps.IDProd = ps.IDProd
INNER JOIN 
    Sellers s ON sps.IDSel = s.ID
INNER JOIN 
    Products p ON sps.IDProd = p.ID
INNER JOIN 
    AProducts ap ON sps.IDProd = ap.IDProd
ORDER BY 
    p.Name, s.Surname, s.Name