DROP TABLE IF EXISTS phones;
CREATE TABLE IF NOT EXISTS phones (
  id INT PRIMARY KEY,
  country_code CHAR(1) NOT NULL DEFAULT '1',
  area_code CHAR(3) NOT NULL CHECK(LENGTH(area_code) = 3),
  phone_number CHAR(7) NOT NULL CHECK(LENGTH(phone_number) = 7),
  UNIQUE (country_code, area_code, phone_number)
);