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

/*
Write a query identifying the type of each record in the TRIANGLES table using
its three side lengths. Output one of the following statements for each record
in the table:

Equilateral: It's a triangle with sides of equal length.
Isosceles: It's a triangle with sides of equal length.
Scalene: It's a triangle with sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/

SELECT CASE
       WHEN A + B <= C THEN 'Not A Triangle'
       WHEN A = B AND B = C THEN 'Equilateral'
       WHEN A = B OR A = C OR B = C THEN 'Isosceles'
       WHEN A != B AND B != C THEN 'Scalene'
       END AS result
FROM triangles;

/*
Generate the following two result sets:
  1. Query an alphabetically ordered list of all names in OCCUPATIONS,
  immediately followed by the first letter of each profession as a parenthetical
  (i.e.: enclosed in parentheses). For example: AnActorName (A), ADoctorName (D)
  AProfessorName(P), and ASingerName(S).
  2. Query the number of occurrences of each occupation in OCCUPATIONS. Sort the
  occurrences in ascending order, and output them in the following format:

  There are a total of [occupation_count] [occupation]s.

  Where occupation_count is the number of ocurrences of an occupation in
  OCCUPATIONS and [occupation] is the lowercase occupation name. If more than
  one Occupation has the same [occupation_count], they should be ordered
  alphabetically.

Note: there will be at least two entries in the table for each type of
occupation.
*/

SELECT
      CONCAT(name, '(', LEFT(occupation, 1), ')') AS Name
FROM occupations
ORDER BY Name;

SELECT
     CONCAT('There are a total of ', COUNT(Occupation), ' ',
            LOWER(Occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(Occupation), Occupation;

/*
Pivot the Occupation column in OCCUPATIONS so that each name is sorted
alphabetically and displayed underneath its corresponding Occupation. The output
column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.
*/
SELECT doctor, -- step 3 query step 2 output 
       professor,
       singer,
       actor
FROM
(SELECT -- step 2 query the step 1 output grouping each ranking
      r,
      MAX(CASE WHEN occupation = "Doctor" THEN name ELSE NULL END) doctor,
      MAX(CASE WHEN occupation = "Professor" THEN name ELSE NULL END) professor,
      MAX(CASE WHEN occupation = "Singer" THEN name ELSE NULL END) singer,
      MAX(CASE WHEN occupation = "Actor" THEN name ELSE NULL END) actor
FROM (SELECT name, -- step 1 rank and partition by occupation
       occupation,
       RANK() OVER (PARTITION BY occupation ORDER BY name ASC) r
      FROM occupations) s1
GROUP BY 1) s2;
