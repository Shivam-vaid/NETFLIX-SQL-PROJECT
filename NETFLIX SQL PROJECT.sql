USE Netflix_database;
SHOW tables;

SELECT * FROM netflix_data  LIMIT 10;

DESC netflix_data;

-- 1.	What is the total number of 'Movies' and 'TV Shows' on Netflix?

SELECT TYPE,
	 COUNT(*) AS Total_count
     FROM netflix_data
     GROUP BY type;
     
-- 2. Which country has produced the most content (Movies + TV Shows) on
-- Netflix? List the top 5 countries

SELECT country,
		COUNT(*) AS total_content
FROM netflix_data
GROUP BY country 
ORDER BY total_content DESC
LIMIT 5;

-- 3. Retrieve a list of all movies and TV shows released in the year 2020.

SELECT title,
		type
FROM netflix_data
WHERE release_year = 2020
LIMIT 10;

SELECT COUNT(*)
from netflix_data
WHERE release_year = 2020;

-- 4. What are the titles of all movies directed by 'Kirsten Johnson'?

SELECT title
FROM netflix_data
WHERE type = 'movie' and director = 'Kirsten Johnson';

-- 5. Which content rating is the most common on Netflix? (Count of titles by
-- rating).

SELECT rating,
	COUNT(*) as total_titles
FROM netflix_data
GROUP BY rating
ORDER BY total_titles DESC;

-- 6. Find the list of all 'TV Shows' that have 5 or more seasons.

SELECT title, duration
FROM netflix_data
WHERE type = 'TV Show'
AND SUBSTRING_INDEX(duration,' ',1) + 0 >= 5;

-- 7. List all the movies produced in 'India' that belong to the 'Comedies' category.
 
 SELECT title,
	listed_in
FROM netflix_data
WHERE type = 'movie' AND
 country = 'India' AND
 listed_in LIKE '%Comedies%';
 
 SELECT COUNT(*)
 FROM netflix_data
 WHERE type = 'movie' AND
  country = 'India' AND
  listed_in LIKE '%Comedies%';
  
-- 8. How many new shows/movies were released each year? Sort the results in
-- descending order of the release year.
 
SELECT release_year,
	COUNT(*) AS total_releases
FROM netflix_data
GROUP BY release_year
ORDER BY release_year DESC
LIMIT 10;

SELECT COUNT(*) AS release_year
FROM netflix_data;

-- 9. Who are the top 5 directors with the highest number of directed movies
-- (excluding 'Not Given')?

SELECT director,
	COUNT(*) AS total_movies
FROM netflix_data
WHERE type = 'Movie' AND director != ''
GROUP BY  director
ORDER BY total_movies DESC
LIMIT 5;

-- 10. In which year did Netflix add the highest amount of content to its platform?

SELECT RIGHT(date_added, 4) AS year_added,
		COUNT(*) AS total_content
	FROM netflix_data
GROUP BY RIGHT(date_added, 4)
ORDER BY total_content DESC
LIMIT 1;

-- 11. Which are the 5 oldest movies released in India on Netflix?

SELECT title,
		release_year
FROM netflix_data
WHERE type = 'Movie' AND country = 'India'
ORDER BY release_year ASC
LIMIT 5;

-- 12. Find the titles of all movies listed as 'Documentaries' that were released
-- after the year 2015.
SELECT title,
	release_year,
    listed_in
FROM netflix_data
WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%'
				AND release_year = 2015
                
-- 13. Which movie has the longest duration in minutes on Netflix?

SELECT 
	title,
		CAST(SUBSTRING_INDEX(duration, ' ',1) AS UNSIGNED) AS duration_minutes
FROM netflix_data
WHERE type = 'Movie'
ORDER BY duration_minutes DESC
LIMIT 1;

SELECT title,
		CAST(substring_index(duration, ' ', 1) AS UNSIGNED) AS duration_minutes
FROM netflix_data
WHERE type = 'Movie'
ORDER BY duration_minutes DESC
LIMIT 1;


-- 14. What is the most recently released movie for each country?

WITH ranked_movies AS(
				SELECT 
					title,
                    country,
                    release_year,
                    ROW_NUMBER() OVER(PARTITION BY country ORDER BY release_year DESC)
					AS rnk
				FROM netflix_data
                WHERE type = 'movie' and country != '')
SELECT 
	country, 
    title AS letest_movie,
    release_year
FROM ranked_movies
WHERE rnk = 1;

-- 15. Identify the release years in which more than 50 movies from India were
-- released.
 SELECT release_year,
 COUNT(*) as total_movies
FROM netflix_data
WHERE type = 'Movie' AND country = 'India'
GROUP BY release_year
HAVING total_movies > 50
ORDER BY release_year DESC;


                










