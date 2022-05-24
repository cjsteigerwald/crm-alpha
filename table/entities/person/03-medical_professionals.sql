DROP TABLE IF EXISTS medical_professionals;

CREATE TABLE IF NOT EXISTS medical_professionals (
  id SERIAL PRIMARY KEY,
  person_id INT REFERENCES persons (id) NOT NULL,
  date_of_birth DATETIME,
  gender VARCHAR (300),
  primary_specialty VARCHAR (300),
  department VARCHAR (300),
  medical_title VARCHAR (300),
  UNIQUE (person_id)
);