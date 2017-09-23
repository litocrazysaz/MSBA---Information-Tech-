USE AdventureWorks2012; /*Set current database*/

SELECT*
FROM Sales.SalesOrderHeader

/*1, Display the total amount collected from the orders for each order date. */

SELECT OrderDate, 
Count (SalesOrderID) as Number_of_Orders, 
Sum (Totaldue) as Total_Due
FROM Sales.SalesOrderHeader
Group By OrderDate

/*2, Display the total amount collected from selling each of the products, 774 and 777.*/

SELECT  p.ProductID, Sum(Totaldue) as Total_Amount
From sales.SalesOrderHeader as s,  sales.SalesOrderDetail as p
Where s.SalesOrderID=p.SalesOrderID and (p.productid=774 or p.productid=777)
Group By p.ProductID

/*3, Write a query to display the sales person BusinessEntityID, last name and first name of 
ALL the sales persons and the name of the territory to which they belong, even though they 
don't belong to any territory.*/

Select p.BusinessEntityID, p.LastName, p.FirstName, j.Jobtitle, s.TerritoryID, t.Name
FROM (((Person.Person as p 
inner Join HumanResources.Employee as j  On p.BusinessEntityID=j.BusinessEntityID)
inner Join Sales.SalesPerson as s on p.BusinessEntityID=s.BusinessEntityID)
Full Join Sales.SalesTerritory as t on s.TerritoryID=t.TerritoryID)


/*4,  Write a query to display the Business Entities (IDs, names) of the customers that have the 'Vista' credit card.*/

/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/


Select p.BusinessEntityID, p.FirstName, p.LastName, c.CreditCardID, t.CardType
From ((Person.Person as p 
inner join Sales.PersonCreditCard as c on p.businessEntityID=c.BusinessEntityID)
inner join Sales.CreditCard as t on c.CreditCardID=t.CreditCardID)
Where t.CardType = 'Vista'


/*5, Write a query to display ALL the countries/regions along with their corresponding territory IDs, 
including those the countries/regions that do not belong to any territory.*/

/* tables: Sales.SalesTerritory and Person.CountryRegion*/


Select t.TerritoryID, t.Name as Region, p.Name as Country 
From (Sales.SalesTerritory  as t 
full join Person.CountryRegion as p on t.CountryRegionCode=p.CountryRegionCode)


/*6, Find out the average of the total dues of all the orders.*/

Select 
Count(SalesOrderID) as Number_of_Orders, 
Avg(Totaldue) as Avg_Due 
FROM Sales.SalesOrderHeader


/*7, Write a query to report the sales order ID of those orders where the total due 
is greater than the average of the total dues of all the orders*/


Select SalesOrderID, (Select  Avg (Totaldue)
FROM Sales.SalesOrderHeader) as Avg_Due, Sum(TotalDue) as Total_Due
FROM Sales.SalesOrderHeader
Group by SalesOrderID 
Having Sum(totaldue) > = (Select  Avg (Totaldue)
FROM Sales.SalesOrderHeader)

