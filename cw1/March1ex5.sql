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