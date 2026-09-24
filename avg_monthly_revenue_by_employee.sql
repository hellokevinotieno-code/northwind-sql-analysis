-- Business Question: Which employees generate the highest average monthly revenue?
-- Uses a subquery to first calculate total revenue per employee per calendar month
-- (UnitPrice * Quantity * (1 - Discount), summed and grouped by year/month),
-- then averages those monthly totals per employee.
-- Database: Northwind

SELECT EmployeeID, LastName, FirstName,
       ROUND(AVG(MonthlyRevenue), 2) AS AvgMonthlyRevenue
FROM (
    SELECT e.EmployeeID, e.LastName, e.FirstName,
           YEAR(o.OrderDate) AS OrderYear,
           MONTH(o.OrderDate) AS OrderMonth,
           SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS MonthlyRevenue
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY e.EmployeeID, e.LastName, e.FirstName, YEAR(o.OrderDate), MONTH(o.OrderDate)
) AS EmployeeMonthlyRevenue
GROUP BY EmployeeID, LastName, FirstName
ORDER BY AvgMonthlyRevenue DESC
