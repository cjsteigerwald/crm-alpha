DROP TABLE IF EXISTS person_home_phone;

CREATE TABLE IF NOT EXISTS person_home_phone (
  id SERIAL PRIMARY KEY,
  person_id INT REFERENCES persons(id) NOT NULL,
  phone_id INT REFERENCES phones(id) NOT NULL,
  UNIQUE (person_id, phone_id)
);