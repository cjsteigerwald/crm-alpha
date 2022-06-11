/*
  Persons entity depends on the following entities:
    locations
    phones
    emails

  Requires following fields:
    first_name    
    middle_name
    last_name
*/
-- DROP TYPE IF EXISTS sex_status;

-- CREATE TYPE sex_status AS ENUM ('male', 'female', 'indeterminate', 'unknown');

DROP TABLE IF EXISTS persons;

CREATE TABLE IF NOT EXISTS persons (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(200) NOT NULL,  
  middle_name VARCHAR(200) NOT NULL DEFAULT '',
  last_name VARCHAR(200) NOT NULL,
  suffix_name VARCHAR(200) NOT NULL DEFAULT '',
  sex sex_status,
  date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (first_name, middle_name, last_name, suffix_name)
);