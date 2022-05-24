-- https://stackoverflow.com/questions/20561254/insert-data-in-3-tables-at-a-time-using-postgres

WITH new_person (
  user_name, domain_name, extension,
  country_code, area_code, phone_number, phone_type,
  first_name, last_name
) AS (
  VALUES (
    'cmkreins', 'liveit', 'com',
    '1', '775', '8943', 'home',
    'christine', 'steigerwald'
  )
),
ins1 AS (
  INSERT INTO phones (country_code, area_code, phone_number)
  SELECT country_code, area_code, phone_number
  FROM new_person
  RETURNING id AS phone_id
),
ins2 AS (
  INSERT INTO emails (user_name, domain_name, extension)
  SELECT user_name, domain_name, extension
  FROM new_person
  -- RETURNING id AS email_id
  RETURNING id AS email_id
)

INSERT INTO persons (first_name, last_name, phone_home, email_personal)
SELECT new_person.first_name, new_person.last_name, ins1.phone_id, ins2.email_id
FROM new_person, ins1, ins2;
