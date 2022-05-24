-- This file will create entities used in database

-- Locations --

-- DROP TABLE IF EXISTS countries;

-- CREATE TABLE IF NOT EXISTS countries (
--   id INT PRIMARY KEY,
--   name CHAR(100) NOT NULL UNIQUE,
--   two_char_code CHAR(2) NOT NULL UNIQUE,
--   three_char_code CHAR(3) NOT NULL UNIQUE,
--   UNIQUE (three_char_code)
-- );


-- DROP TABLE IF EXISTS cities;

-- CREATE TABLE IF NOT EXISTS cities (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(200),
--   country_id INT REFERENCES countries(id)
-- );

-- DROP TABLE IF EXISTS us_states;

-- CREATE TABLE IF NOT EXISTS us_states (
--   id SERIAL PRIMARY KEY,
--   postal CHAR(2) NOT NULL UNIQUE,
--   name CHAR(128) NOT NULL UNIQUE,
--   UNIQUE (postal)
-- );


-- DROP TABLE IF EXISTS locations;

-- CREATE TABLE IF NOT EXISTS locations (
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

-- -- phones --

DROP TABLE IF EXISTS phones;

CREATE TABLE IF NOT EXISTS phones (
  id SERIAL PRIMARY KEY,
  country_code CHAR(1) NOT NULL DEFAULT '1',
  area_code CHAR(3) NOT NULL CHECK(LENGTH(area_code) = 3),
  phone_number CHAR(7) NOT NULL CHECK(LENGTH(phone_number) = 7),
  UNIQUE (country_code, area_code, phone_number)
);

-- -- email --

-- DROP TABLE IF EXISTS emails;

-- CREATE TABLE IF NOT EXISTS emails (
--   id SERIAL PRIMARY KEY,
--   username VARCHAR (300) NOT NULL,
--   domain_name VARCHAR (300) NOT NULL,
--   extension VARCHAR (300) NOT NULL,
--   UNIQUE (username, domain_name, extension)
-- );

-- Persons --

-- DROP TYPE IF EXISTS sex_status;

-- CREATE TYPE sex_status AS ENUM ('male', 'female', 'indeterminate', 'unknown');

-- DROP TABLE IF EXISTS persons;

-- CREATE TABLE IF NOT EXISTS persons (
--   id SERIAL PRIMARY KEY,
--   first_name VARCHAR(200) NOT NULL,  
--   middle_name VARCHAR(200) NOT NULL DEFAULT '',
--   last_name VARCHAR(200) NOT NULL,
--   suffix_name VARCHAR(200),
--   sex sex_status,
--   location_home INT REFERENCES locations (id),
--   phone_home INT REFERENCES phones (id),
--   phone_cell INT REFERENCES phones (id),
--   phone_professional INT REFERENCES phones (id),
--   email_personal INT REFERENCES emails (id),
--   email_professional INT REFERENCES emails (id),
--   photo_path VARCHAR(400),
--   last_contact TIMESTAMP,
--   next_contact TIMESTAMP,
--   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE (first_name, last_name, middle_name)
-- );

-- Clients --

-- DROP TABLE IF EXISTS clients;

-- CREATE TABLE IF NOT EXISTS clients (
--   id SERIAL PRIMARY KEY,
--   person_id INT REFERENCES persons (id) NOT NULL,
--   date_of_birth DATE,
--   gender VARCHAR (300),
--   UNIQUE (person_id, date_of_birth)
-- );

-- Medical Professionals --

-- DROP TABLE IF EXISTS medical_professionals;

-- CREATE TABLE IF NOT EXISTS medical_professionals (
--   id SERIAL PRIMARY KEY,
--   person_id INT REFERENCES persons (id) NOT NULL,
--   date_of_birth DATE,
--   gender VARCHAR (300),
--   primary_specialty VARCHAR (300),
--   department VARCHAR (300),
--   medical_title VARCHAR (300),
--   UNIQUE (person_id)
-- );