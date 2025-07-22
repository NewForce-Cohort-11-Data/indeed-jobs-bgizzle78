--1. How many rows are in the data_analyst_jobs table?

SELECT
COUNT (*)
FROM data_analyst_jobs;

--2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT
COUNT(CASE WHEN location = 'TN' THEN 1 END) AS tn_postings,
COUNT(CASE WHEN location = 'KY' THEN 1 END) AS ky_postings,
COUNT(CASE WHEN location IN ('TN', 'KY') THEN 1 END) AS tn_or_ky_postings
FROM data_analyst_jobs;