/*
Given the CITY and COUNTRY tables, query the sum of the populations of all
cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT SUM(c1.population) AS population
FROM city AS c1
JOIN country AS c2
ON c1.countrycode = c2.code
WHERE c2.continent = 'Asia';

/*
Given the CITY and COUNTRY tables, query the names of all cities where the
CONTINENT is 'Africa'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT c1.name AS name
FROM city AS c1
JOIN country AS c2
ON c1.countrycode = c2.code
WHERE c2.continent = 'Africa';

/*
Given the CITY and COUNTRY tables, query the names of all the continents
(COUNTRY.Continent) and their respective average city populations
(CITY.Population) rounded down to the nearest integer.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT c2.continent, FLOOR(AVG(c1.population)) AS avg_pop
FROM city AS c1
JOIN country AS c2
ON c1.countrycode = c2.code
GROUP BY 1;

/*
You are given two tables: Students and Grades.
Ketty gives Eve a task to generate a report containing three columns: Name,
Grade and Mark. Ketty doesn't want the NAMES of those students who received a
grade lower than 8. The report must be in descending order by grade -- i.e.
higher grades are entered first. If there is more than one student with the
same grade (8-10) assigned to them, order those particular students by their
name alphabetically. Finally, if the grade is lower than 8, use "NULL" as
their name and list them by their grades in descending order. If there is
more than one student with the same grade (1-7) assigned to them, order
those particular students by their marks in ascending order.

Write a query to help Eve.
*/

SELECT CASE WHEN g.grade < 8 THEN NULL ELSE s.name END as name,
    g.grade, s.marks
FROM students AS s
JOIN grades AS g
ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY 2 DESC, 1;

/*
Julia just finished conducting a coding contest, and she needs your help
assembling the leaderboard! Write a query to print the respective hacker_id
and name of hackers who achieved full scores for more than one challenge.
Order your output in descending order by the total number of challenges in
which the hacker earned a full score. If more than one hacker received full
scores in same number of challenges, then sort them by ascending hacker_id.
*/

SELECT h.hacker_id,
       h.name
FROM submissions AS s
JOIN hackers AS h
ON s.hacker_id = h.hacker_id
JOIN challenges AS c
ON s.challenge_id = c.challenge_id
JOIN difficulty AS d
ON c.difficulty_level = d.difficulty_level
WHERE s.score = d.score
GROUP BY 1, 2
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, 1;

/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing
Charlie's old broken wand. Hermione decides the best way to choose is by
determining the minimum number of gold galleons needed to buy each non-evil
wand of high power and age. Write a query to print the id, age, coins_needed,
and power of the wands that Ron's interested in, sorted in order of descending
power. If more than one wand has same power, sort the result in order of
descending age.
*/
SELECT w1.id,
       wp1.age,
       w1.coins_needed,
       w1.power
FROM wands AS w1
JOIN wands_property AS wp1
ON w1.code = wp1.code
WHERE wp1.is_evil = 0 AND w1.coins_needed = (
    SELECT MIN(w2.coins_needed)
    FROM wands AS w2
    JOIN wands_property AS wp2
    ON w2.code = wp2.code
    WHERE wp1.age = wp2.age
    AND w1.power = w2.power
)
ORDER BY 4 DESC, 2 DESC;
