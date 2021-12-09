/*
Query the two cities in STATION with the shortest and longest CITY names, as
well as their respective lengths (i.e.: number of characters in the name).
If there is more than one smallest or largest city, choose the one that comes
first when ordered alphabetically.
*/

(SELECT city,
       LENGTH(city)
FROM station
ORDER BY 2, 1
LIMIT 1)

UNION

(SELECT city,
       LENGTH(city)
FROM station
ORDER BY 2 DESC, 1
LIMIT 1);

/*
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u)
from STATION. Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION.
Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE RIGHT(city, 1) IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names from STATION which have vowels
(i.e., a, e, i, o, and u) as both their first and last characters.
Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) IN ('A','a','E','e','I','i','O','o','U','u')
      AND RIGHT(city, 1) IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names from STATION that do not start with vowels.
Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE LEFT(city) NOT IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names from STATION that do not end with vowels.
Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE RIGHT(city,1) NOT IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names from STATION that either do not start with vowels
or do not end with vowels. Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) NOT IN ('A','a','E','e','I','i','O','o','U','u') OR
RIGHT(city,1) NOT IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the list of CITY names from STATION that do not start with vowels and do
not end with vowels. Your result cannot contain duplicates.
*/

SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) NOT IN ('A','a','E','e','I','i','O','o','U','u') AND
RIGHT(city,1) NOT IN ('A','a','E','e','I','i','O','o','U','u');

/*
Query the Name of any student in STUDENTS who scored higher than 75 Marks.
Order your output by the last three characters of each name. If two or more
students both have names ending in the same last three characters
(i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/

SELECT name
FROM students
WHERE marks > 75
ORDER BY RIGHT(name,3), id;

/*
Write a query that prints a list of employee names (i.e.: the name attribute)
for employees in Employee having a salary greater than $2000 per month who have
been employees for less than 10 months. Sort your result by
ascending employee_id.
*/

SELECT name
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;
