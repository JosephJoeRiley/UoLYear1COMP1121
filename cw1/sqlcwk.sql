/*
This is an sql file to put your queries for SQL coursework. 
You can write your comment in sqlite with -- or /* * /

To read the sql and execute it in the sqlite, simply
type .read sqlcwk.sql on the terminal after sqlite3 chinook.db.
*/

/* =====================================================
   WARNNIG: DO NOT REMOVE THE DROP VIEW
   Dropping existing views if exists
   =====================================================
*/
DROP VIEW IF EXISTS vCustomerPerEmployee;
DROP VIEW IF EXISTS v10WorstSellingGenres ;
DROP VIEW IF EXISTS vBestSellingGenreAlbum ;
DROP VIEW IF EXISTS v10BestSellingArtists;
DROP VIEW IF EXISTS vTopCustomerEachGenre;

/*
============================================================================
Question 1: Complete the query for vCustomerPerEmployee.
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW vCustomerPerEmployee AS"
============================================================================
*/
CREATE VIEW vCustomerPerEmployee  AS 
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



/*
============================================================================
Question 2: Complete the query for v10WorstSellingGenres.
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW v10WorstSellingGenres AS"
============================================================================
*/
CREATE VIEW v10WorstSellingGenres  AS




/*
============================================================================
Question 3:
Complete the query for vBestSellingGenreAlbum
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW vBestSellingGenreAlbum AS"
============================================================================
*/
CREATE VIEW vBestSellingGenreAlbum  AS




/*
============================================================================
Question 4:
Complete the query for v10BestSellingArtists
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW v10BestSellingArtists AS"
============================================================================
*/

CREATE VIEW v10BestSellingArtists AS

--Remove this line and complete your query for question 4 here



/*
============================================================================
Question 5:
Complete the query for vTopCustomerEachGenre
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW vTopCustomerEachGenre AS" 
============================================================================
*/
CREATE VIEW vTopCustomerEachGenre AS

--Remove this line and complete your query for question 5 here
