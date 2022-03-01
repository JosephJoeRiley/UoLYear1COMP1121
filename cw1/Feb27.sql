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
	e_1.LastName,
	e_1.FirstName,
	e_1.EmployeeId,
	'0' AS TotalCustomer
FROM employees e_1
LEFT OUTER JOIN customers c_1
ON (c_1.SupportRepId = e_1.EmployeeId)
WHERE c_1.SupportRepId IS NULL
ORDER BY e.EmployeeId ASC;
