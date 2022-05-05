SELECT cities.name AS city, countries.name AS country FROM cities 
INNER JOIN countries ON countries.id = cities.country_id;