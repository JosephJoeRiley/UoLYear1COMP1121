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
SELECT 
	g.name, 
	COUNT(i.Quantity) Sales 
FROM genres g
LEFT OUTER JOIN tracks t
ON (g.GenreId = t.GenreId)
LEFT OUTER JOIN invoice_items i
ON (t.TrackId = i.TrackId)
GROUP BY t.GenreId
ORDER BY Sales ASC
LIMIT 10;



/*
============================================================================
Question 3:
Complete the query for vBestSellingGenreAlbum
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW vBestSellingGenreAlbum AS"
============================================================================
*/
CREATE VIEW vBestSellingGenreAlbum  AS
SELECT 
	Genre, 
	Album, 
	Artist, 
	MAX(Sales) AS Sales
FROM
(SELECT
	g.GenreId AS Id,
    g.Name AS Genre,
	al.Title AS Album,
	ar.name AS Artist,
	COUNT(i.Quantity) AS Sales
FROM invoice_items i
JOIN tracks t
ON i.TrackId = t.TrackId
JOIN albums al
ON t.AlbumId = al.AlbumId
JOIN artists ar
ON al.ArtistId = ar.ArtistId
JOIN genres g
ON t.GenreId = g.GenreId
GROUP BY t.GenreId, al.AlbumId
ORDER BY Sales DESC)
GROUP BY Genre
ORDER BY Id;


/*
============================================================================
Question 4:
Complete the query for v10BestSellingArtists
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW v10BestSellingArtists AS"
============================================================================
*/

CREATE VIEW v10BestSellingArtists AS
SELECT
                AlbumSales.Artist,
                AlbumSales.TotalAlbum,
                TrackSales.TotalTrackSales
FROM
 (SELECT
	COUNT(invoice_items.Quantity) TotalTrackSales,
    artists.ArtistId Artist
FROM tracks
JOIN invoice_items
	ON tracks.TrackId = invoice_items.TrackId
JOIN albums
    ON  albums.AlbumId = tracks.AlbumId
JOIN artists
	ON artists.ArtistId = albums.ArtistId
GROUP BY albums.ArtistId
) TrackSales
JOIN (SELECT DISTINCT
    artists.Name Artist,
    artists.ArtistId,
    COUNT(*) TotalAlbum
FROM albums
JOIN artists
ON albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId) AlbumSales
ON AlbumSales.ArtistId = TrackSales.Artist
ORDER BY TotalTrackSales DESC
LIMIT 10;



/*
============================================================================
Question 5:
Complete the query for vTopCustomerEachGenre
WARNNIG: DO NOT REMOVE THE STATEMENT "CREATE VIEW vTopCustomerEachGenre AS" 
============================================================================
*/
CREATE VIEW vTopCustomerEachGenre AS
SELECT
    Genre,
    Spender TopSpender,
    printf('%.2f', MAX(EachTotalSpending)) TotalSpending
FROM
(SELECT
       genres.Name Genre,
       SUM(invoice_items.Quantity * invoice_items.UnitPrice) EachTotalSpending,
       customers.FirstName || ' ' || customers.LastName Spender
FROM customers
JOIN invoices
    ON customers.CustomerId = invoices.CustomerId
JOIN invoice_items
    ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks
    ON invoice_items.TrackId = tracks.TrackId
JOIN genres
    ON tracks.GenreId = genres.GenreId
GROUP BY Genre, customers.CustomerId
ORDER BY EachTotalSpending DESC)
GROUP BY Genre
ORDER BY Genre;
