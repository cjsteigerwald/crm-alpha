-- DROP TABLE IF EXISTS phones;

-- CREATE TABLE phones (
--   id SERIAL PRIMARY KEY,
--   phone VARCHAR(10),
--   UNIQUE(phone)
-- );

DROP TABLE IF EXISTS clothes;

CREATE TABLE clothes (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(100),
  color VARCHAR(100),
  price INT,
  phone INT REFERENCES phones(id)
);

-- DROP TABLE phones;

