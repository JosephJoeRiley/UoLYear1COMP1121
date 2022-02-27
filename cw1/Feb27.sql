SELECT 
	e.LastName, 
	e.FirstName, 
	EmployeeId, 
	COUNT(c.SupportRepId) AS TotalCustomer
FROM employees e 
INNER JOIN customers c 
ON (c.SupportRepId = e.EmployeeId )
GROUP BY c.SupportRepId
UNION
SELECT
	LastName,
	FirstName,
	EmployeeId,
	'0' AS TotalCustomer
FROM employees
ORDER BY e.EmployeeId ASC;
