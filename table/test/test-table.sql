DROP TABLE IF EXISTS test_table;

CREATE TABLE IF NOT EXISTS test_table (
  id SERIAL PRIMARY KEY,
  country_id INT REFERENCES countries(id) NOT NULL,
  state_id INT REFERENCES us_states(id) NOT NULL, -- state
  -- county_name VARCHAR(100), -- county
  city_id INT REFERENCES cities(id) NOT NULL, -- city/town  
  postal_code CHAR(10) NOT NULL,
  street_address VARCHAR(100) NOT NULL, -- street address
  address_line_2 VARCHAR(100) DEFAULT '' NOT NULL, -- apartment, suite, box number, etc, PO Box
  UNIQUE (country_id, state_id, city_id, postal_code, street_address, address_line_2)
);