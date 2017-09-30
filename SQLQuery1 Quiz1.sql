use AdventureWorks2012;

/*a.	Show First name and last name of employees whose job title is “Sales Representative”, 
ranking from oldest to youngest. You may use HumanResources.Employee table and Person.Person table. (14 rows)*/
use AdventureWorks2012;
Select P.FirstName, P.LastName, H.JobTitle, H.BirthDate
FROM HumanResources.Employee as H 
Inner Join Person.Person as P on H.BusinessEntityID=P.BusinessEntityID
Where Jobtitle = 'Sales Representative'
Order by H.BirthDate ASC


/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and total
 amount collected after selling the products. You may use LineTotal from Sales.SalesOrderDetail table and
  Production.Product table. (254 rows)*/


use AdventureWorks2012;
Select S.ProductID, Sum (s.LineTotal) as Total_Amount , p.Name
FROM Sales.SalesOrderDetail as S 
Inner Join Production.Product as P on S.ProductID = P.ProductID
Group By S.ProductID, P.Name
Having Sum(s.lineTotal) >5000 
Order by sum(s.Linetotal) DESC 




/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is greater 
than $500,000, regardless of whether they are assigned a territory. You may use Sales.SalesPerson table and 
Sales.SalesTerritory table. (16 rows)*/

use AdventureWorks2012;
Select P.BusinessEntityID, T.Name, P.SalesYTD
FROM Sales.SalesPerson as P left outer join Sales.SalesTerritory as T on P.TerritoryID = T.TerritoryID
Group By P.BusinessEntityID, T.Name, P.SalesYTD
Having P.SalesYTD > 500000 
Order By P.SalesYTD DESC


/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is greater than the 
average total due of all the orders of the same year. (3200 rows)*/

Select SalesOrderID, Totaldue 
From Sales.SalesOrderHeader
Where OrderDate >='2008'
Group by SalesOrderID, Totaldue
Having Totaldue > (Select Avg(totaldue) From Sales.SalesOrderHeader where Orderdate >='2008')
Order By Totaldue DESC 

