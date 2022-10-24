-- all customers information for people with postal number 0-50000 as upper area
--and people with 50001 and above as lower area.
SELECT [Customer ID],[Customer Name],[Postal Code], '0 - 50000' as upper_area 
FROM spin_Customer where [Postal Code] < 50000
union
select [Customer ID], [Customer Name], [Postal Code], '> 50001' as Lower_area
from spin_Customer where [Postal Code] > 50001

-- the name,id of all customers and the products name and id they purchased. 
--
SELECT C.[Customer Name], C.[Customer ID],  p.[Product ID], p.[Product Name], S.[Order ID], S.[Product ID], s.[Customer ID], c.State
from Spin_Products as P join spin_SALES as S ON p.[Product ID] = s.[Product ID] join Spin_Customer as C ON  c.[Customer ID] = s.[Customer ID]

-- all customers information from the state of carlifornia and the number of products purchased by this customers.
SELECT C.[Customer Name], C.[Customer ID], COUNT(S.[Product ID]) no_of_products,C.State
from SPIN_Products as P join SPIN_SALES as S ON p.[Product ID] = s.[Product ID] join SPIN_Customer as C ON  c.[Customer ID] = s.[Customer ID]
 where c.State = 'california'
 GROUP BY C.[Customer Name],C.[Customer ID],C.State

 -- count of all office supplies and furniture purchased and the sum of the profit that came from both products.
select category, COUNT(P.Category) AS no_of_sales, SUM(S.Profit) AS TOTAL_PROFIT from
Spin_Products P JOIN Spin_Sales S ON P.[Product ID]= S.[Product ID] 
WHERE P.Category IN ( 'OFFICE SUPPLIES', 'FURNITURE' ) GROUP BY Category


--  count of all sub category products sold and the sum of profits made with counts greater than 5
select p.[Sub-Category], COUNT(S.Sales) AS total_sales, SUM(S.Profit) AS TOTAL_PROFIT from
spin_Products P JOIN Spin_Sales S ON P.[Product ID]= S.[Product ID]
GROUP BY p.[Sub-Category]
HAVING count( s.Sales) >5


--Create a new table cointaining data of customers who bought only technology products and what products they bought exactly
SELECT C.[Customer ID],C.[Customer Name], p.Category,p.[Sub-Category],P.[Product Name] into Gcoustomer_that_bought_tech2
FROM Spin_Customer C JOIN  Spin_Sales S ON C.[Customer ID]= S.[Customer ID]
 JOIN Spin_Products P ON P.[Product ID]= S.[Product ID] 
WHERE P.Category = 'TECHNOLOGY'

select * from Gcoustomer_that_bought_tech2


-- all movies with dvd_bluray sales that are null, replace the null values with zero
SELECT [Movie Title], Genre, [Production Company], ISNULL([U#S# DVD + BluRay Sales ($)],'0')DVD_BLUERAY_SALES FROM Movie

-- The name of all of customers and the product purchased between jan 2016  and jan 2017.
--create a new column to capture the Month name alongside your result.
SELECT C.[Customer Name], P.[Product Name],S.[Order Date],DATENAME(MM,S.[Order Date])monthnames,
cast(year(s.[Order Date])as varchar)+ ' ' + Datename(MM,S.[Order Date]) as YearMonth
FROM  GCustomer C 
JOIN GSales S ON C.[Customer ID]= S.[Customer ID] 
JOIN GProducts P ON  P.[Product ID] = S.[Product ID] WHERE S.[Order Date] BETWEEN '2016-01-01' AND '2017-01-01' 
ORDER BY S.[Order Date]
 --The count of all product purchased within june 2015 and june 2016.I want to see the month Name
--group by the months and order by the year and month
SELECT P.[Product Name], DATENAME(MM,S.[Order Date])MONTHNAMES, YEAR(S.[Order Date])YEARTIME,
DATEPART(MM,[Order Date])MonthNo ,COUNT(S.Sales)NUMBEROFPRODUCT
FROM  GCustomer C JOIN GSales S ON C.[Customer ID]= S.[Customer ID] 
JOIN GProducts P ON  P.[Product ID] = S.[Product ID]WHERE S.[Order Date] >= DATEADD (YEAR, -1, '2016-06-01') 
AND s.[Order Date] <= '2016-06-01'
GROUP BY p.[Product Name],DATENAME(MM,S.[Order Date]),YEAR(S.[Order Date]),DATEPART(MM,[Order Date])
ORDER BY YEARTIME,MonthNo
/*to order months based on a date column, use monthno*/

-- Top 10 product names, product id and profit with the highest profits in our database
SELECT TOP 10 P.[Product Name],p.[Product ID], s.Profit FROM Spin_Sales S
JOIN Spin_Products P ON  P.[Product ID] = S.[Product ID] ORDER BY s.Profit DESC

