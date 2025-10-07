-- Query 1: What is the total volume and time range of the data?
SELECT
    COUNT(*) AS total_records,
    MIN(datetime) AS start_date,
    MAX(datetime) AS end_date
FROM
    air_quality;


-- Query 2: What are the overall average and extreme values for key metrics?
SELECT
    ROUND(AVG(aqi), 2) AS average_aqi,
    MIN(aqi) AS minimum_aqi,
    MAX(aqi) AS maximum_aqi,
    ROUND(AVG(temperature), 2) AS average_temp,
    ROUND(AVG(pm2_5), 2) AS average_pm2_5
FROM
    air_quality;


-- Query 3: How has air quality changed year-over-year?
-- This query identifies the long-term trend in pollution.
SELECT
    EXTRACT(YEAR FROM datetime) AS year,
    ROUND(AVG(aqi), 2) AS avg_yearly_aqi
FROM
    air_quality
GROUP BY
    year
ORDER BY
    year ASC;


-- Query 4: Is there a seasonal pattern in pollution?
-- This query aggregates data by month to see if certain times of the year are worse than others.
SELECT
    EXTRACT(MONTH FROM datetime) AS month_number,
    ROUND(AVG(aqi), 2) AS avg_monthly_aqi
FROM
    air_quality
GROUP BY
    month_number
ORDER BY
    avg_monthly_aqi DESC;


-- Query 5: Initial Test - What is the average AQI for different wind speed categories?
-- This query tests the initial hypothesis that stronger winds lead to lower pollution.
SELECT
    CASE
        WHEN wind_speed < 5 THEN '0-5 (Calm to Light Air)'
        WHEN wind_speed >= 5 AND wind_speed < 10 THEN '5-10 (Light Breeze)'
        WHEN wind_speed >= 10 AND wind_speed < 15 THEN '10-15 (Gentle Breeze)'
        ELSE '15+ (Moderate to Strong Wind)'
    END AS wind_category,
    COUNT(*) as number_of_hours,
    ROUND(AVG(aqi), 2) AS average_aqi_in_category
FROM
    air_quality
GROUP BY
    wind_category
ORDER BY
    average_aqi_in_category ASC;
-- Initial Conclusion: The results are counter-intuitive, suggesting a confounding variable.

-- Query 6: Final Test - Isolating the analysis to a single month (January).
-- By filtering for only one month, we can remove the seasonal effect and see the true impact of wind.
SELECT
    CASE
        WHEN wind_speed < 5 THEN '0-5 (Calm to Light Air)'
        WHEN wind_speed >= 5 AND wind_speed < 10 THEN '5-10 (Light Breeze)'
        WHEN wind_speed >= 10 AND wind_speed < 15 THEN '10-15 (Gentle Breeze)'
        ELSE '15+ (Moderate to Strong Wind)'
    END AS wind_category,
    COUNT(*) as number_of_hours,
    ROUND(AVG(aqi), 2) AS average_aqi_in_category
FROM
    air_quality
WHERE
    EXTRACT(MONTH FROM datetime) = 1 -- Filtering for January ONLY
GROUP BY
    wind_category
ORDER BY
    average_aqi_in_category ASC;
-- Final Conclusion: When the seasonal variable is removed, the data (though still affected by its
-- synthetic nature) shows a more logical, albeit weak, trend.


-- Query 7: What were the conditions during the 20 most polluted hours on record?
SELECT
    datetime,
    ROUND(aqi, 2) AS aqi,
    ROUND(temperature, 2) AS temp,
    ROUND(wind_speed, 2) AS wind_speed,
    ROUND(humidity, 2) AS humidity
FROM
    air_quality
ORDER BY
    aqi DESC
LIMIT 20;