DROP TABLE IF EXISTS person_personal_email;

CREATE TABLE IF NOT EXISTS person_personal_email (
  id SERIAL PRIMARY KEY,
  person_id INT REFERENCES persons(id) NOT NULL,
  email_id INT REFERENCES emails(id) NOT NULL,
  UNIQUE (person_id, email_id)
);