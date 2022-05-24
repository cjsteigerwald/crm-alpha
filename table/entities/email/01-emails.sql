DROP TABLE IF EXISTS emails;

CREATE TABLE IF NOT EXISTS emails (
  id SERIAL PRIMARY KEY,
  username VARCHAR (300) NOT NULL,
  domain_name VARCHAR (300) NOT NULL,
  extension VARCHAR (300) NOT NULL,
  UNIQUE (username, domain_name, extension)
);