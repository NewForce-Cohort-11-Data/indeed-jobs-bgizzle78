-- 1. How many rows are in the data_analyst_jobs table?

SELECT
COUNT (*)
FROM data_analyst_jobs;

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT
COUNT(CASE WHEN location = 'TN' THEN 1 END) AS tn_postings,
COUNT(CASE WHEN location = 'KY' THEN 1 END) AS ky_postings,
COUNT(CASE WHEN location IN ('TN', 'KY') THEN 1 END) AS tn_or_ky_postings
FROM data_analyst_jobs;

-- 4. How many postings in Tennessee have a star rating above 4?

SELECT
COUNT(CASE WHEN location = 'TN' AND star_rating > 4 THEN 1 END)
AS above_4star_rating_tn
FROM data_analyst_jobs;

-- 5. How many postings in the dataset have a review count between 500 and 1000?

SELECT
COUNT(CASE WHEN review_count >= 500 OR review_count <= 1000 THEN 1 END)
AS review_count_500_1000
FROM data_analyst_jobs;

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT
location AS state,
ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location;

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT
COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- 8. How many unique job titles are there for California companies?

SELECT
COUNT(DISTINCT title) AS unique_cali_job_titles
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company,
AVG(star_rating) AS avg_rating,
SUM(review_count) AS total_reviews
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL AND company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY avg_rating DESC;





