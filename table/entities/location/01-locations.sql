
-- DROP TABLE IF EXISTS countries;

-- CREATE TABLE IF NOT EXISTS countries (
--   id INT PRIMARY KEY,
--   name CHAR(100) NOT NULL UNIQUE,
--   two_char_code CHAR(2) NOT NULL UNIQUE,
--   three_char_code CHAR(3) NOT NULL UNIQUE,
--   UNIQUE (three_char_code)
-- )


-- DROP TABLE IF EXISTS us_states;

-- CREATE TABLE IF NOT EXISTS us_states (
--   id SERIAL PRIMARY KEY,
--   postal CHAR(2) NOT NULL UNIQUE,
--   name CHAR(128) NOT NULL UNIQUE,
--   UNIQUE (postal)
-- )

-- DROP TABLE IF EXISTS cities;

-- CREATE TABLE IF NOT EXISTS cities (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(300) NOT NULL UNIQUE
-- )

-- DROP TABLE IF EXISTS departments;

-- CREATE TABLE IF NOT EXISTS departments (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(300) NOT NULL UNIQUE
-- )


DROP TABLE IF EXISTS locations;

CREATE TABLE IF NOT EXISTS locations (
  id SERIAL PRIMARY KEY,
  country_id INT REFERENCES countries(id) NOT NULL,
  state_id INT REFERENCES us_states(id) NOT NULL, -- state
  county_name VARCHAR(100), -- county
  city_id INT REFERENCES cities(id) NOT NULL, -- city/town  
  postal_code CHAR(10) NOT NULL,
  street_address VARCHAR(100) NOT NULL, -- street address
  address_line_2 VARCHAR(100) DEFAULT '' NOT NULL, -- apartment, suite, box number, etc, PO Box
  address_line_3 VARCHAR(100),
  UNIQUE (country_id, state_id, city_id, postal_code, street_address,  address_line_2)
);