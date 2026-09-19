--Business Question: Which 10 products have generated the most total revenue?
--Revenue = UnitPrice * Quantity * (1 - Discount), reflecting the actual amount charged per order line, not list price.
--Database: Northwind

SELECT TOP 10 p.ProductName,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 2) AS TotalRevenue
FROM [dbo].[Products] p
JOIN [dbo].[Order Details] od
	ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC
