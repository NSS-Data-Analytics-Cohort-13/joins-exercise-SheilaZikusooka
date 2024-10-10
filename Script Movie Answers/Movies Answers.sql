SELECT * FROM distributors
SELECT * FROM rating
SELECT * FROM revenue
SELECT * FROM specs

--1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
GROUP BY film_title, release_year, worldwide_gross
ORDER BY (worldwide_gross) ASC
LIMIT 1;

--Answer: Semi-Tough, 1977, 37187139





--2. What year has the highest average imdb rating?

SELECT specs.release_year, 
	ROUND(AVG(rating.imdb_rating),2) AS average_rating
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY AVG (rating.imdb_rating) DESC

--Answer: 1991, 7.45





--3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title, 
	s.mpaa_rating,
	d.company_name,
	r.worldwide_gross
FROM specs AS s
INNER JOIN distributors AS d
	ON s.domestic_distributor_id = d.distributor_id
INNER JOIN revenue AS r
	USING(movie_id)
WHERE s.mpaa_rating='G'
ORDER BY r.worldwide_gross DESC
LIMIT 1;

--Answer: Toy Story 4, Walt Disney





--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT d.company_name AS distributor,
	COUNT(s.movie_id) AS movie_count
FROM distributors AS d
LEFT JOIN specs AS s
	ON d.distributor_id = s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY movie_count DESC;

--Answer: The query provides 23 distributors and the number of movies associated





--5. Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, ROUND(AVG(film_budget),2) AS avg_movie_budget
FROM specs AS s
INNER JOIN distributors AS d
	ON s.domestic_distributor_id = d.distributor_id
INNER JOIN revenue AS r
	USING(movie_id)
GROUP BY d.company_name
ORDER BY avg_movie_budget DESC
LIMIT 5;

--Answer:





--6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT s.film_title, d.company_name, r.imdb_rating
FROM specs AS s
INNER JOIN distributors AS d
	ON s.domestic_distributor_id = d.distributor_id
INNER JOIN rating AS r
	USING (movie_id)
WHERE d.headquarters NOT ILIKE '%CA'
ORDER BY r.imdb_rating DESC;

--Answer: 2 movies, Dirting Dancing has the highest imdb rating at 7.0





--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours? 

SELECT 'Less than 2 hours' AS movie_length, 
	AVG(imdb_rating) avg_rating
FROM(
	SELECT r.imdb_rating
	FROM specs AS s
	INNER JOIN rating r 
		USING(movie_id)
	GROUP BY s.length_in_min, r.imdb_rating
	HAVING s.length_in_min<120
	)
UNION ALL 
SELECT 'Greater than 2 hours' AS movie_length,
AVG(imdb_rating) avg_rating
FROM(
	SELECT r.imdb_rating AS imdb_rating
	FROM specs AS s
	INNER JOIN rating r
		USING(movie_id)
	GROUP BY s.length_in_min, r.imdb_rating
	HAVING s.length_in_min>=120
)

--Answer: Movies less than 2 hours with average rating of 6.91 and Moves greater than 2 hours average rating of 7.27.