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
DROP TYPE IF EXISTS sex_status;

CREATE TYPE sex_status AS ENUM ('male', 'female', 'indeterminate', 'unknown');

DROP TABLE IF EXISTS persons;

CREATE TABLE IF NOT EXISTS persons (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(200) NOT NULL,  
  middle_name VARCHAR(200) NOT NULL DEFAULT '',
  last_name VARCHAR(200) NOT NULL,
  suffix_name VARCHAR(200),
  sex sex_status,
  location_home INT REFERENCES locations (id),
  phone_home INT REFERENCES phones (id),
  phone_cell INT REFERENCES phones (id),
  phone_professional INT REFERENCES phones (id),
  email_personal INT REFERENCES emails (id),
  email_professional INT REFERENCES emails (id),
  photo_path VARCHAR(400),
  last_contact TIMESTAMP,
  next_contact TIMESTAMP,
  date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (first_name, last_name, middle_name)
);