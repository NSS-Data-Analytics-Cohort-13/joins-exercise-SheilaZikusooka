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

