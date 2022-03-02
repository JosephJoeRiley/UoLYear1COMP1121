SELECT  artists.Name Artist, TotalTrackSales, TotalAlbum
FROM
artists,
(SELECT
	COUNT(*) TotalTrackSales
FROM tracks
JOIN invoice_items
	ON tracks.TrackId = invoice_items.TrackId
JOIN albums
    ON  albums.AlbumId =tracks.AlbumId
JOIN artists
	ON artists.ArtistId = albums.ArtistId
GROUP BY artists.ArtistId) TrackSales,
(SELECT DISTINCT
    COUNT(*) TotalAlbum
FROM albums
JOIN artists
    ON albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId)
ORDER BY TotalTrackSales DESC
LIMIT 10;
