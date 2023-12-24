Create TABLE appleStore_description_combined as 

SELECT * FROM appleStore_description1

UNION ALL 

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4

-- check the number of unique apps in both tables.

SELECT COUNT(DISTINCT id) AS uniqueAppIDs
FROM AppleStore

SELECT COUNT(DISTINCT id) AS uniqueAppIDs
FROM appleStore_description_combined

--Check for any NA values in cell

SELECT COUNT(*) AS naCell 
FROM AppleStore
WHERE user_rating IS NULL OR prime_genre IS NULL OR track_name is NULL


-- Checking how many apps are in genre

SELECT prime_genre ,Count(*) AS NumApps
FROM AppleStore
GROUP By prime_genre
ORDER BY NumApps DESC

-- Checking average rating of each genre in App store and order them 

SELECT prime_genre, AVG(user_rating)
FROM AppleStore
GROUP BY prime_genre
ORDER BY AVG(user_rating) DESC

-- Getting overview of the apps' rating

SELECT min(user_rating) AS MinRating,
	   max(user_rating) AS MaxRating,
       avg(user_rating) as AvgRating
FROM AppleStore

**DATA ANALYSIS**

-- Determine whether paid apps have higher ratings than free apps

SELECT CASE
			WHEN price > 0 THEN 'Paid'
            ELSE 'Free'
       end AS App_type,
       AVG(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY App_type

-- Determine how number of language supported plays on user_rating

SELECT CASe
			WHEN lang_num < 10 THEN '<10 language'
            WHEN lang_num BETWEEN 10 and 20 THEN '10-20 language'
            ELSE '>20 language'
       END AS lang_bucket,
       AVG(user_rating) AS Avg_rating
 FROM AppleStore
 GROUP BY lang_bucket
 ORDER BY Avg_rating DESC

-- Check the genre sector with low user rating

SELECT prime_genre, avg(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_rating
LIMIT 5


-- Check to see if there is correlation between length of description and user rating

SELECT CASE
			WHEN length(B.app_desc) < 500 Then 'SHORT'
            WHEN length(B.app_desc) BETWEEN 500 And 1000 then 'MEDIUM'
            Else 'LONG'
       END As description_bucket, avg(A.user_rating) As Avg_rating 
FROM 
	AppleStore as A
Join 
	appleStore_description_combined As B
on 
	A.id = B.id
GROUP BY description_bucket
ORDEr BY Avg_rating DESC

-- Few insights can be derived from the anaysis
-- 1. Paid app generally have better user rating
-- 2. Lauguage suppored on an app can have effect in user rating. I realized that apps with 10 to 20 language supported have best average user rating.
-- 3. Catalog, Finance, and Book genre apps have lowest user rating which can be interpreted as market opportunity for new app in those genre.
-- 4. Well descripted app have higher user rating based on the analysisAppleStore
-- 5. Game and entertainment genre is very competitive due to high volume of apps are published.