CREATE DATABASE Project
USE Project

SELECT * FROM SalesData
SELECT * FROM CustomerData


--- Month-Wise Sales---

SELECT [Month Name],[Month],SUM(SalesAmount) AS "Revenue"
FROM SalesData JOIN CustomerData ON
SalesData.[CustomerID]=CustomerData.[CustomerID]

GROUP BY [Month Name],[Month]
ORDER BY [Month]

--- Week-Wise Sales ---

SELECT [Day Name],DATEPART(WEEKDAY,OrderDate) AS"Week Number",
SUM(SalesAmount) AS "Revenue"
FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomeriD] =[CustomerData].[CustomerID]

GROUP BY [Day Name],DATEPART(WEEKDAY,OrderDate)
ORDER BY DATEPART(WEEKDAY,OrderDate)

---  Cities -Wise Sales  ---

SELECT City, SUM(SalesAmount) AS "Revenue" 
FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID] =[CustomerData].[CustomerID]

GROUP BY City
ORDER BY Revenue DESC

--- Gender Percentage ---

SELECT Gender,SUM(SalesAmount) AS "Revenue",
CONCAT(ROUND(SUM(SalesAmount)*100/SUM(SUM(SalesAmount)) OVER(),2),'%')
AS "Percentages" FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID]=[CustomerData].[CustomerID]

GROUP BY Gender

--- TOP 5 Customer---
SELECT  Top 5 CustomerName, SUM(SalesAmount) AS "Revenue"
FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID] = [CustomerData].[CustomerID]

GROUP BY CustomerName
ORDER BY Revenue DESC

--- Payment Mode ---

SELECT PaymentMode ,
CONCAT(ROUND(SUM(SalesAmount)*100/SUM(SUM(SalesAmount)) OVER(),2),'%')
AS "Percent" FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID] =[CustomerData].[CustomerID]

GROUP BY PaymentMode

--- Product-Wise Sales ---

SELECT Product,SUM(SalesAmount) AS "Revenue"
FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID] =[CustomerData].[CustomerID]

GROUP BY Product
ORDER BY Revenue DESC

--- Age_Distribution ---

SELECT 
CASE
WHEN Age>18 AND  Age <=20  THEN 'Under 20'
WHEN Age>21 AND  Age <=30  THEN 'Under 30'
WHEN Age>31 AND  Age <=40  THEN 'Under 40'
WHEN Age>41 AND  Age <=50  THEN 'Under 50'
ELSE 
'Under60' END  AS "Age Distribution",
COUNT(OrderID) AS "Orders" ,
SUM(SalesAmount) AS "Revenue"
FROM [SalesData] JOIN [CustomerData] ON
[SalesData].[CustomerID] = [CustomerData].[CustomerID]

GROUP BY
CASE
WHEN Age>18 AND  Age <=20  THEN 'Under 20'
WHEN Age>21 AND  Age <=30  THEN 'Under 30'
WHEN Age>31 AND  Age <=40  THEN 'Under 40'
WHEN Age>41 AND  Age <=50  THEN 'Under 50'
ELSE 
'Under60' END
ORDER BY Orders DESC

--- Week_Distribution ---

SELECT 
    DATEADD(DAY, 1 - DATEPART(WEEKDAY, OrderDate), CAST(OrderDate AS DATE)) AS WeekStart,
    DATEADD(DAY, 7 - DATEPART(WEEKDAY, OrderDate), CAST(OrderDate AS DATE)) AS WeekEnd,
    SUM(SalesAmount) AS "Revenue"
FROM [SalesData]
JOIN [CustomerData]
    ON [SalesData].[CustomerID] =[SalesData].[CustomerID]
GROUP BY 
    DATEADD(DAY, 1 - DATEPART(WEEKDAY, OrderDate), CAST(OrderDate AS DATE)),
    DATEADD(DAY, 7 - DATEPART(WEEKDAY, OrderDate), CAST(OrderDate AS DATE))
ORDER BY WeekStart

--- Running Total ---

SELECT [Month Name],
DATEPART(MONTH,OrderDate) AS "MonthNumber",SUM(SalesAmount) AS "Revenue",
SUM(SUM(SalesAmount)) OVER (ORDER BY DATEPART(MONTH,OrderDate)) AS "Running Total"
FROM [SalesData] JOIN [CustomerData] ON [SalesData].[CustomerID] =[CustomerData].[CustomerID]

GROUP BY [Month Name],
DATEPART(MONTH,OrderDate)

ORDER BY MonthNumber

--- Camparision Of Month ---

SELECT [Month Name],
DATEPART(MONTH,OrderDate) AS "Month Number",
SUM(SalesAmount) AS "Revenue",
SUM(SalesAmount)-LAG(SUM(SalesAmount)) OVER(ORDER BY DATEPART(MONTH,OrderDate)) 
AS "Month Diff",
CONCAT(ROUND((SUM(SalesAmount)-LAG(SUM(SalesAmount)) 
OVER(ORDER BY DATEPART(MONTH,OrderDate)))/
LAG(SUM(SalesAmount)) OVER(ORDER BY DATEPART(MONTH,OrderDate))*100,2),'%') 
AS "Percentage"
FROM [SalesData]  JOIN [CustomerData] ON 
[SalesData].[CustomerID]=[CustomerData].[CustomerID]

GROUP BY [Month Name] ,
DATEPART(MONTH,OrderDate)

ORDER BY [Month Number]

--- Key Points Indicator (KPI's) ---
--Total Sales--
SELECT SUM(SalesAmount) AS "Revenue" 
FROM [SalesData] LEFT JOIN [CustomerData] ON
[SalesData].[CustomerID] = [CustomerData].[CustomerID]

--Total Orders---

SELECT DISTINCT(COUNT(OrderID)) AS "Total Orders" 
FROM [SalesData]  LEFT JOIN [CustomerData] ON
[SalesData].[CustomerID] = [CustomerData].[CustomerID]




--- Average Order Value (AOV) ---
SELECT ROUND((SUM(SalesAmount)*100/COUNT(OrderID)),0)
AS "AOV" FROM [SalesData]  LEFT  JOIN [CustomerData] ON
[SalesData].[CustomerID] = [CustomerData].[CustomerID]