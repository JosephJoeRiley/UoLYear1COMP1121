SELECT 
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
ON al.ArtistId = al.ArtistId
JOIN genres g
ON t.GenreId = t.TrackId
GROUP BY Genre;

-- SELECT 
--     g.Name AS Genre,
-- 	al.Title AS Album,
-- 	ar.name AS Artist,
-- 	COUNT(i.Quantity) AS Sales
-- FROM albums al
-- INNER JOIN genres g
-- ON (t.GenreId = g.GenreId)
-- LEFT JOIN tracks t
-- --ON (t.AlbumId = al.AlbumId)
-- ON (t.GenreId = g.GenreId)  
-- INNER JOIN artists ar
-- ON (al.ArtistId = ar.ArtistId)
-- INNER JOIN invoice_items i 
-- ON (t.TrackId = i.TrackId)
-- GROUP BY Genre
-- ORDER BY Sales ASC; 