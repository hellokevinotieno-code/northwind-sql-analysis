-- Business Question: Which customers have an average order value above $1000?
-- Uses a subquery to first calculate total revenue per order (UnitPrice * Quantity * (1 - Discount), summed per OrderID),
-- then averages those order totals per customer and filters to those averaging above $1000.
-- Database: Northwind

SELECT CustomerID, CompanyName, AVG(OrderTotal) AS AvgOrderValue
FROM (
    SELECT c.CustomerID, c.CompanyName, o.OrderID,
           SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS OrderTotal
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CompanyName, o.OrderID
) AS CustomerOrderTotals
GROUP BY CustomerID, CompanyName
HAVING AVG(OrderTotal) > 1000
