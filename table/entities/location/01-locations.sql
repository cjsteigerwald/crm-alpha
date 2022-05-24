
DROP TABLE IF EXISTS countries;

CREATE TABLE IF NOT EXISTS countries (
  id INT PRIMARY KEY,
  name CHAR(100) NOT NULL UNIQUE,
  two_char_code CHAR(2) NOT NULL UNIQUE,
  three_char_code CHAR(3) NOT NULL UNIQUE,
  UNIQUE (three_char_code)
)


DROP TABLE IF EXISTS us_states;

CREATE TABLE IF NOT EXISTS us_states (
  id SERIAL PRIMARY KEY,
  postal CHAR(2) NOT NULL UNIQUE,
  name CHAR(128) NOT NULL UNIQUE,
  UNIQUE (postal)
)


DROP TABLE IF EXISTS cities;

CREATE TABLE IF NOT EXISTS cities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  country_id INT REFERENCES countries(id)
)


DROP TABLE IF EXISTS locations;

CREATE TABLE IF NOT EXISTS locations (
  id SERIAL PRIMARY KEY,
  country_id INT REFERENCES countries(id) NOT NULL ON DELETE RESTRICT,
  administrative_area INT REFERENCES us_states(id) NOT NULL ON DELETE RESTRICT, -- state
  sub_administrative_area VARCHAR(100), -- county
  locality INT REFERENCES cities(id) NOT NULL ON DELETE RESTRICT, -- city/town
  dependent_locality VARCHAR(200), -- department
  postal_code CHAR(10) NOT NULL,
  thoroughfare VARCHAR(100) NOT NULL, -- street address
  premise VARCHAR(50) DEFAULT '' NOT NULL, -- apartment, suite, box number, etc, PO Box
  sub_premise VARCHAR(50),
  UNIQUE (thoroughfare, postal_code, premise)
);