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

-- CREATE TABLE locations (
--   id SERIAL PRIMARY KEY,
--   country_id INT REFERENCES countries(id) NOT NULL,
--   administrative_area INT REFERENCES us_states(id) NOT NULL, -- state
--   sub_administrative_area VARCHAR(100), -- county
--   locality INT REFERENCES cities(id) NOT NULL, -- city/town
--   dependent_locality VARCHAR(200), -- department
--   postal_code CHAR(10) NOT NULL,
--   thoroughfare VARCHAR(100) NOT NULL, -- street address
--   premise VARCHAR(50) DEFAULT '' NOT NULL, -- apartment, suite, box number, etc, PO Box
--   sub_premise VARCHAR(50),
--   UNIQUE (thoroughfare, postal_code, premise)
-- );

-- CREATE TABLE emails (
--   id SERIAL PRIMARY KEY,
--   extension VARCHAR (25),
--   domain_name VARCHAR (100),
--   user_name VARCHAR (200),
--   UNIQUE (user_name, domain_name, extension)
-- );

-- CREATE TYPE phone_type AS ENUM ('home', 'cell', 'business', 'fax');

-- CREATE TABLE phones (
--   id SERIAL PRIMARY KEY,
--   country_code CHAR (1),
--   area_code CHAR (3),
--   phone_number CHAR (7),
--   phone_type phone_type,
--   UNIQUE (country_code, area_code, phone_number)
-- );



-- CREATE TYPE sex_status AS ENUM ('male', 'female', 'indeterminate', 'unknown');

-- CREATE TABLE persons (
--   id SERIAL PRIMARY KEY,
--   first_name VARCHAR(200) NOT NULL,
--   last_name VARCHAR(200) NOT NULL,
--   middle_name VARCHAR(200),
--   suffix_name VARCHAR(200),
--   sex sex_status,
--   location_home INT REFERENCES locations (id),
--   phone_home CHAR(10),
--   phone_cell CHAR(10),
--   phone_professional CHAR(10),
--   email_personal VARCHAR(200),
--   email_professional VARCHAR(200),
--   photo_path VARCHAR(400),
--   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );



