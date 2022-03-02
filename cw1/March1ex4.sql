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