-- CREATE TABLE countries (
--   id INT PRIMARY KEY,
--   name CHAR(100) NOT NULL UNIQUE,
--   two_char_code CHAR(2) NOT NULL UNIQUE,
--   three_char_code CHAR(3) NOT NULL UNIQUE
-- )

-- CREATE TABLE us_states (
--   id SERIAL PRIMARY KEY,
--   postal CHAR(2) NOT NULL UNIQUE,
--   name CHAR(128) NOT NULL UNIQUE
-- )

-- CREATE TABLE cities (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(200),
--   country_id INT REFERENCES countries(id)
-- )

CREATE TABLE locations (
  id SERIAL,
  administrative_area INT REFERENCES us_states(id) NOT NULL, -- state
  sub_administrative_area VARCHAR(100), -- county
  locality INT REFERENCES cities(id) NOT NULL, -- city/town
  dependent_locality VARCHAR(200), -- department
  postal_code CHAR(10) NOT NULL,
  thoroughfare VARCHAR(100) NOT NULL, -- street address
  premise VARCHAR(50) DEFAULT '' NOT NULL, -- apartment, suite, box number, etc, PO Box
  sub_premise VARCHAR(50),
  PRIMARY KEY (thoroughfare, postal_code, premise)
);