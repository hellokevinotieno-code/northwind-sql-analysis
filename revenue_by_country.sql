-- Business Question: Which countries have generated the most total revenue?
-- Revenue = UnitPrice * Quantity * (1 - Discount), reflecting actual amount charged per order line, not list price.
-- Database: Northwind

SELECT c.Country,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-Discount)),2) AS TotalRevenue
FROM [dbo].[Customers] c
JOIN [dbo].[Orders] o
    ON c.CustomerID = o.CustomerID
JOIN [dbo].[Order Details] od
    ON o.OrderID = od.OrderID
GROUP BY c.Country
ORDER BY TotalRevenue DESC
