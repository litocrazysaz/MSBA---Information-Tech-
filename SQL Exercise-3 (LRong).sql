use AdventureWorksDW2012;


/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales 
in 1st quarter each year in each country. Note: your result set should produce a total of 18 rows. */

USE AdventureWorksDW2012;
Select
Count (S.SalesOrderNumber) as Number_of_Orders,
Sum(S.SalesAmount) as Sales_Amount,
T.SalesTerritoryCountry, D.CalendarYear
From dbo.FactInternetSales as S 
Inner Join dbo.DimSalesTerritory as T on S.SalesTerritoryKey = T.SalesTerritoryKey
Inner join dbo.DimDate as D on S.OrderDateKey = D.DateKey
Where  D.CalendarQuarter = 1 
Group BY T.SalesTerritoryCountry, D.CalendarYear
Order by sum(S.SalesAmount) DESC



/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, 
product category name and reseller’s business type by quarter by category and by business type 
in 2006. Note: your result set should produce a total of 44 rows. */

USE AdventureWorksDW2012;
Select
 R.BusinessType, d.CalendarQuarter, c.EnglishProductCategoryName, Sum(SalesAmount) as Sales_Amount
From dbo.FactResellerSales as S 
Inner join dbo.DimDate as D on S.OrderDateKey = D.DateKey 
Inner join dbo.DimProduct as P on s.ProductKey = p.ProductKey
Inner join dbo.DimProductSubcategory as B on p.ProductSubcategoryKey = b.ProductSubcategoryKey 
Inner Join dbo.DimProductCategory as C on b.ProductCategoryKey=c.ProductCategoryKey
Inner join dbo.DimReseller as R on s.ResellerKey = R.ResellerKey
Where D.CalendarYear = 2006
Group By d.CalendarQuarter, c.EnglishProductCategoryName, R.BusinessType
Order by sum(S.SalesAmount) DESC


/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing,
 i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/

USE AdventureWorksDW2012;
Select
 R.BusinessType, d.CalendarQuarter, c.EnglishProductCategoryName, Sum(SalesAmount) as Sales_Amount
From dbo.FactResellerSales as S 
Inner join dbo.DimDate as D on S.OrderDateKey = D.DateKey 
Inner join dbo.DimProduct as P on s.ProductKey = p.ProductKey
Inner join dbo.DimProductSubcategory as B on p.ProductSubcategoryKey = b.ProductSubcategoryKey 
Inner Join dbo.DimProductCategory as C on b.ProductCategoryKey=c.ProductCategoryKey
Inner join dbo.DimReseller as R on s.ResellerKey = R.ResellerKey
Where D.CalendarYear = 2006 and c.EnglishProductCategoryName = 'Bikes'
Group By d.CalendarQuarter, c.EnglishProductCategoryName, R.BusinessType
Order by sum(S.SalesAmount) DESC

/*I created an additional where clause focusing on the product categories of “Bikes”. Which would reduce the dimension of the dataset. 
Now the data set has only the timing (Quarters), Business types that sold only Bikes. This is an operation of 
slicing because I’m focusing only a portion of the data. */

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down,
 i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/
USE AdventureWorksDW2012;
Select
 R.BusinessType, d.CalendarQuarter, c.EnglishProductCategoryName, b.EnglishProductSubcategoryName, Sum(SalesAmount) as Sales_Amount
From dbo.FactResellerSales as S 
Inner join dbo.DimDate as D on S.OrderDateKey = D.DateKey 
Inner join dbo.DimProduct as P on s.ProductKey = p.ProductKey
Inner join dbo.DimProductSubcategory as B on p.ProductSubcategoryKey = b.ProductSubcategoryKey 
Inner Join dbo.DimProductCategory as C on b.ProductCategoryKey=c.ProductCategoryKey
Inner join dbo.DimReseller as R on s.ResellerKey = R.ResellerKey
Where D.CalendarYear = 2006 
Group By d.CalendarQuarter, c.EnglishProductCategoryName, R.BusinessType, b.EnglishProductSubcategoryName
Order by sum(S.SalesAmount) DESC

/*I added another table header from a subcategory which would list out a lower level of detail of the categories. 
Which increased the number of rows from 44 to 126. This is an operation of drilling-down because it gives a lower 
level of detail of the data set. Which adds a sublevel of detail within the set of data. */