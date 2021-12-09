/*
We define an employee's total earnings to be their monthly salary x months
worked, and the maximum total earnings to be the maximum total earnings for
any employee in the Employee table. Write a query to find the maximum total
earnings for all employees as well as the total number of employees who have
maximum total earnings. Then print these values as space-separated integers.
*/

SELECT (salary * months) total_earnings,
       COUNT(*)
FROM employee
WHERE (salary * months) = (SELECT MAX(salary * months)
                           FROM employee)
GROUP BY 1;

/*
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/

SELECT ROUND(SUM(lat_n),2),
       ROUND(SUM(long_w),2)
FROM station;

/*
Query the sum of Northern Latitudes (LAT_N) from STATION having values
greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal
places
*/

SELECT ROUND(SUM(lat_n),4)
FROM station
WHERE lat_n > 38.7880 AND lat_n < 137.2345;

/*
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that
is less than . Truncate your answer to decimal places.
*/

SELECT ROUND(lat_n,4)
FROM station
WHERE lat_n < 137.2345
ORDER BY 1 DESC
LIMIT 1;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude
(LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal
places
*/

SELECT ROUND(long_w,4)
FROM station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
LIMIT 1;

/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than
38.7780. Round your answer to 4 decimal places
*/

SELECT ROUND(lat_n, 4)
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1;

/*
