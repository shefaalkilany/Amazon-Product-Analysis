-- Average Rating by Category
SELECT category, ROUND(AVG(rating), 2) AS avg_rating
FROM amazon_data
GROUP BY category
ORDER BY avg_rating DESC;

-- Average Discount by Category
SELECT category, ROUND(AVG(discount_percentage), 2) AS avg_discount
FROM amazon_data
GROUP BY category
ORDER BY avg_discount DESC;

-- Rating Count Buckets (Customer Engagement Segments
SELECT 
  CASE 
    WHEN CAST(REPLACE(rating_count, ',', '') AS UNSIGNED) >= 1000 THEN '1,000+ ratings'
    WHEN CAST(REPLACE(rating_count, ',', '') AS UNSIGNED) >= 500 THEN '500–999 ratings'
    WHEN CAST(REPLACE(rating_count, ',', '') AS UNSIGNED) >= 100 THEN '100–499 ratings'
    ELSE 'Less than 100 ratings'
  END AS rating_volume_group,
  COUNT(*) AS product_count
FROM amazon_data
GROUP BY rating_volume_group
ORDER BY product_count DESC;

-- Discount Range vs Average Rating
SELECT 
  CASE 
    WHEN discount_percentage >= 0.70 THEN '70%+'
    WHEN discount_percentage >= 0.50 THEN '50–69%'
    WHEN discount_percentage >= 0.30 THEN '30–49%'
    WHEN discount_percentage >= 0.10 THEN '10–29%'
    ELSE 'Less than 10%'
  END AS discount_range,
  ROUND(AVG(rating), 2) AS avg_rating,
  COUNT(*) AS product_count
FROM amazon
GROUP BY discount_range
ORDER BY discount_range;

-- Number of Products per Category
SELECT category,
       COUNT(*) AS product_count
FROM amazon
GROUP BY category
ORDER BY product_count DESC;

-- Top 5 Highest-Rated Products (with at least 50 reviews)
SELECT product_name, rating, rating_count, discounted_price, category
FROM amazon_data
WHERE rating_count >= 50
ORDER BY rating DESC, rating_count DESC
LIMIT 5;

-- Bottom 5 Lowest-Rated Products (with at least 50 reviews)
SELECT product_name, rating, rating_count, discounted_price, category
FROM amazon_data
WHERE rating_count >= 50
ORDER BY rating ASC
LIMIT 5;

-- Bottom 5 Least Reviewed Products Overall
SELECT product_name, rating_count, rating, category
FROM amazon_data
ORDER BY rating_count ASC
LIMIT 5;

-- Top 5 Discounted Products with Good Ratings (Rating ≥ 4)
SELECT product_name, discount_percentage, rating, rating_count, actual_price, discounted_price
FROM amazon_data
WHERE rating >= 4
ORDER BY discount_percentage DESC
LIMIT 5;

-- Bottom 5 Low-Rated Products with High Review Counts
SELECT product_name, rating, rating_count, category
FROM amazon_data
WHERE rating <= 3 AND rating_count >= 100
ORDER BY rating ASC
LIMIT 5;

-- Top 5 Products by Rating (Price vs Rating Correlation Sample)
SELECT product_name,category, actual_price, discounted_price, rating
FROM amazon_data
WHERE rating IS NOT NULL AND actual_price > 0
ORDER BY rating DESC
LIMIT 5;

-- Bottom 5 Products by Rating (Price vs Rating Correlation Sample)
SELECT product_name,category, actual_price, discounted_price, rating
FROM amazon_data
WHERE rating IS NOT NULL AND actual_price > 0
ORDER BY rating ASC
LIMIT 5;

-- Average Discounted Price
SELECT ROUND(AVG(discounted_price), 2) AS "Avg Discounted Price" FROM amazon_data;

-- Average Actual Price
SELECT ROUND(AVG(actual_price), 2) AS "Avg Actual Price" FROM amazon_data;

-- Average Discount Percentage
SELECT ROUND(AVG(discount_percentage), 2) As "Avg Discounted Pct" FROM amazon_data;

-- Maximum Discount Given
SELECT MAX(discount_percentage) As "Maximum Discount Given"  FROM amazon_data;

-- Minimum Discounted Price
SELECT MIN(discounted_price) As "Minimum Discounted Price"  FROM amazon_data;

-- Average Product Rating
SELECT ROUND(AVG(rating), 2) As "Avg Product Rating"  FROM amazon_data;

-- Highest Product Rating
SELECT MAX(rating) As "Highest Product Rating"  FROM amazon_data;

-- Total Number of Ratings (sum of all rating counts)
SELECT SUM(rating_count) As "Total # of Rating" FROM amazon_data;

-- Average Number of Ratings per Product
SELECT ROUND(AVG(rating_count), 0) AS "Avg # of Ratings per Product" FROM amazon_data;

-- Number of 5-Star Rating Products
SELECT COUNT(*) AS "5-Star Products Count" FROM amazon_data WHERE rating = 5;

-- Total Number of Products
SELECT COUNT(*) As "Total # of Products" FROM amazon_data;

-- Number of Unique Categories
SELECT COUNT(DISTINCT category) As "Number of Categories" FROM amazon_data;

-- Number of Products with Rating Count ≥ 100
SELECT COUNT(*) AS "# of Products with High Rating Count" FROM amazon_data WHERE rating_count >= 100;

-- Number of Products with Rating ≤ 3
SELECT COUNT(*) AS "# of Products with Low Rating"  FROM amazon_data WHERE rating <= 3;

-- Number of Products with Discount ≥ 50%
SELECT COUNT(*) AS "# of Products with Discount ≥ 50%" FROM amazon_data WHERE discount_percentage >= 0.50;