--1.Using a UNION, get all customers information for people with postal number 0-50000 as upper area
--and people with 50001 and above as lower area. (Note that this would require  
--u to create a new column based on the condition)
SELECT [Customer ID],[Customer Name],[Postal Code], '0 - 50000' as upper_area 
FROM spin_Customer where [Postal Code] < 50000
union
select [Customer ID], [Customer Name], [Postal Code], '> 50001' as Lower_area
from spin_Customer where [Postal Code] > 50001

--Get me the name,id of all customers and the products name and id they purchased. 
--
SELECT C.[Customer Name], C.[Customer ID],  p.[Product ID], p.[Product Name], S.[Order ID], S.[Product ID], s.[Customer ID], c.State
from Spin_Products as P join spin_SALES as S ON p.[Product ID] = s.[Product ID] join Spin_Customer as C ON  c.[Customer ID] = s.[Customer ID]

--2b. get me all customers information from the state of carlifornia and the number of products purchased by this 
--customers.
SELECT C.[Customer Name], C.[Customer ID], COUNT(S.[Product ID]) no_of_products,C.State
from SPIN_Products as P join SPIN_SALES as S ON p.[Product ID] = s.[Product ID] join SPIN_Customer as C ON  c.[Customer ID] = s.[Customer ID]
 where c.State = 'california'
 GROUP BY C.[Customer Name],C.[Customer ID],C.State

 --3.I need the count of all office supplies and furniture purchased and the sum of the profit that came from both products.
select category, COUNT(P.Category) AS no_of_sales, SUM(S.Profit) AS TOTAL_PROFIT from
Spin_Products P JOIN Spin_Sales S ON P.[Product ID]= S.[Product ID] 
WHERE P.Category IN ( 'OFFICE SUPPLIES', 'FURNITURE' ) GROUP BY Category


--4. i want a count of all sub category products sold and the sum of profits made. 
--i should only see counts greater than 5
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


