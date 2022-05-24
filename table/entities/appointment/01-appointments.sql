DROP TABLE IF EXISTS appointments;

CREATE TABLE IF NOT EXISTS appointments (
  id SERIAL PRIMARY KEY,
  person_set_id INT REFERENCES person_id NOT NULL,
  date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  datetime_appointment TIMESTAMP NOT NULL,
  date_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (person_set_id, datetime_appointment)
)