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