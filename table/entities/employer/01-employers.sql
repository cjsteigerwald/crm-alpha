DROP TABLE IF EXISTS appointments;

CREATE TABLE IF NOT EXISTS notes (
  id SERIAL PRIMARY KEY,  
  name VARCHAR (300) UNIQUE NOT NULL 
)