
--EASY QUERIES
--Q1. Who is the senior most employee based on job title?
		SELECT first_name, last_name, title
		FROM employee ORDER BY levels DESC
		LIMIT 1;
--Q2. Which countries have the most invoices?
		SELECT billing_country, COUNT(*) AS total_invoices
		FROM invoice GROUP BY billing_country
		ORDER BY total_invoices DESC;
--Q3. What are the top 3 values of total invoice?
		SELECT total
		FROM invoice ORDER BY total DESC
		LIMIT 3;
--Q4. Which city has the best customers?
		SELECT billing_city, SUM(total) AS total_invoice_amount
		FROM invoice GROUP BY billing_city
		ORDER BY total_invoice_amount DESC
		LIMIT 1;
--Q5. Who is the best customer?
		SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
		FROM customer c
		JOIN invoice i
		ON c.customer_id = i.customer_id GROUP BY c.customer_id, c.first_name, c.last_name
		ORDER BY total_spent DESC
		LIMIT 1;

--MODERATE QUERIES
--Q1. Write a query to return the email, first name, last name, and genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.

		SELECT DISTINCT email, first_name, last_name
		FROM customer
		JOIN invoice ON customer.customer_id = invoice.customer_id
		JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
		WHERE track_id IN (
		    SELECT track_id FROM track
		    JOIN genre ON track.genre_id = genre.genre_id
		    WHERE genre.name LIKE 'Rock'
		)
		ORDER BY email;
--Q2.Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the artist name and total track count of the top 10 rock bands.
		SELECT ar.name AS artist_name, COUNT(t.track_id) AS track_count
		FROM artist ar
		JOIN album al
		ON ar.artist_id = al.artist_id
		JOIN track t
		ON al.album_id = t.album_id
		JOIN genre g
		ON t.genre_id = g.genre_id
		WHERE g.name = 'Rock'
		GROUP BY ar.name
		ORDER BY track_count DESC
		LIMIT 10;
--Q3.Return all the track names that have a song length longer than the average song length. Return the name and milliseconds for each track. Order by the song length with the longest songs first.
		SELECT name, milliseconds
		FROM track
		WHERE milliseconds > (
		    SELECT AVG(milliseconds)
		    FROM track
		)
		ORDER BY milliseconds DESC;






		