-- 1. How many rows are in the data_analyst_jobs table?
-- Answer: 1793

SELECT
COUNT (*) AS rows_count
FROM data_analyst_jobs;

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
-- Answer: ExxonMobil

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
-- Answer: 21, 27

SELECT
COUNT(CASE WHEN location = 'TN' THEN 1 END) AS tn_postings,
COUNT(CASE WHEN location = 'KY' THEN 1 END) AS ky_postings,
COUNT(CASE WHEN location IN ('TN', 'KY') THEN 1 END) AS tn_or_ky_postings
FROM data_analyst_jobs;

-- 4. How many postings in Tennessee have a star rating above 4?
-- Answer: 4

SELECT
COUNT(*) AS above_4star_rating_tn
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >4;

-- 5. How many postings in the dataset have a review count between 500 and 1000?
-- Answer: 151

SELECT
COUNT(CASE WHEN review_count >= 500 AND review_count <= 1000 THEN 1 END)
AS review_count_500_1000
FROM data_analyst_jobs;

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
-- Answer: NE 4.20

SELECT
location AS state,
ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC
LIMIT 1;

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
-- Answer: 881

SELECT
COUNT(DISTINCT title) AS unique_titles
FROM data_analyst_jobs;

-- 8. How many unique job titles are there for California companies?
-- Answer: 230

SELECT
COUNT(DISTINCT title) AS unique_cali_titles
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
-- Answer: 70

SELECT company,
ROUND(AVG(star_rating), 2) AS avg_rating,
SUM(review_count) AS total_reviews
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL AND company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000;

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
-- Answer: Google, 4.30

SELECT company,
ROUND(AVG(star_rating), 2) AS avg_rating,
SUM(review_count) AS total_reviews
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL AND company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY avg_rating DESC
LIMIT 1;

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
-- Answer: 774

SELECT
DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

SELECT
COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
-- Answer: 4, Tableau

SELECT
DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';

SELECT
COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';



-- WITH 
--   total_positions AS (SELECT COUNT(*) AS total
--   FROM data_analyst_jobs), words_in_titles AS (
--     SELECT 
--       LOWER(word) AS word,                      -- make words lowercase so "Manager" and "manager" match
--       title                                     -- keep title to count distinct later
--     FROM data_analyst_jobs,
--       LATERAL unnest(string_to_array(title, ' ')) AS word ),     -- split title into words
--   word_counts AS (
--     SELECT word,
--       COUNT(DISTINCT title) AS count_titles   -- count how many titles have this word
--     FROM words_in_titles
--     GROUP BY word)
-- SELECT word
-- FROM word_counts, total_positions
-- WHERE count_titles = total     -- the word appears in every title
-- ORDER BY word;


-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
-- Answer: Banks and Financial Services-63, Internet and Software-63, Consulting and Business Services-62, Health Care-54

SELECT domain,
COUNT (*) AS hard_to_fill
FROM data_analyst_jobs
WHERE domain IS NOT NULL AND skill ILIKE '%sql%' AND days_since_posting >= 21
GROUP BY domain
ORDER BY hard_to_fill DESC
LIMIT 4;



