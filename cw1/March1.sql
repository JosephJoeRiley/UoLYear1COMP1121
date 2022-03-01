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

