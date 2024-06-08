-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title,release_year,worldwide_gross
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross ASC
LIMIT 1;

--Semi-Tough, 1977, $37,187,139

-- 2. What year has the highest average imdb rating?
SELECT release_year,AVG(imdb_rating) AS average_rating
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY release_year
ORDER BY average_rating DESC
LIMIT 1;

--1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title,company_name,worldwide_gross
FROM specs
INNER JOIN distributors
	ON distributors.distributor_id = specs.domestic_distributor_id	
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- Toy Story 4, Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name,COUNT(film_title) AS total_films
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name
ORDER BY total_films DESC;

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name, AVG(film_budget) AS average_budget
FROM distributors
INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY average_budget DESC
LIMIT 5;

-- "Walt Disney " 148735526.31578947
--"Sony Pictures" 139129032.25806452
--"Lionsgate" 122600000.00000000
--"DreamWorks" 121352941.17647059
--"Warner Bros." 103430985.91549296

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT company_name,film_title,imdb_rating,headquarters
FROM specs
INNER JOIN distributors
	ON distributors.distributor_id = specs.domestic_distributor_id	
INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE headquarters NOT LIKE '%CA'
	AND headquarters NOT LIKE '%California%'
ORDER BY imdb_rating DESC;

-- 2 movies, "Dirty Dancing"

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT (length_in_min/60.0) AS length_in_hours, AVG(imdb_rating) AS average_rating
FROM specs
INNER JOIN rating 
ON specs.movie_id = rating.movie_id
GROUP BY length_in_hours
ORDER BY average_rating DESC;

--Movies over two hours