DROP TABLE IF EXISTS clients;

CREATE TABLE IF NOT EXISTS clients (
  id SERIAL PRIMARY KEY,
  person_id INT REFERENCES persons (id) NOT NULL,
  date_of_birth DATETIME,
  gender VARCHAR (300),
  UNIQUE (person, date_of_brith)
);