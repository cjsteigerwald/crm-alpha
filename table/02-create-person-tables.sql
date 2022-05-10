CREATE TYPE sex_status AS ENUM ('male', 'female', 'indeterminate', 'unknown');

CREATE TABLE persons (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(200) NOT NULL,
  last_name VARCHAR(200) NOT NULL,
  middle_name VARCHAR(200),
  suffix_name VARCHAR(200),
  sex sex_status,
  location_home INT REFERENCES locations (id),
  phone_home INT REFERENCES phones (id),
  phone_cell INT REFERENCES phones (id),
  phone_professional INT REFERENCES phones (id),
  email_personal INT REFERENCES emails (id),
  email_professional INT REFERENCES emails (id),
  photo_path VARCHAR(400),
  date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);