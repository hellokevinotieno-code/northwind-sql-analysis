-- Business Question: On average, how many different products are included in a single order?
-- Uses a subquery to first count distinct products per order, then averages that count across all orders.
-- Database: Northwind

SELECT AVG(TotalProductsPerOrder) AS AvgProductsPerOrder
FROM (
    SELECT OrderID, COUNT(ProductID) AS TotalProductsPerOrder
    FROM [Order Details]
    GROUP BY OrderID
) AS OrderProductCounts
