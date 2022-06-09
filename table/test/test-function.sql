-- CREATE OR REPLACE FUNCTION insert_location_test(
--   -- OUT return_id INT,
--   i_country_name VARCHAR (100),
--   i_state_name CHAR(128),
--   i_city_name VARCHAR(300),
--   i_postal_code CHAR (10),
--   i_street_address VARCHAR (100)
--   -- i_address_line_3 VARCHAR (100) DEFAULT NULL
-- )
-- RETURNS INT
-- AS
-- $$
-- BEGIN
--   RETURN (SELECT insert_location(
--     i_country_name,
--     i_state_name,
--     i_city_name,
--     i_postal_code,
--     i_street_address,
--     ''
--   ));
-- END
-- $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_location(
  OUT return_id INT,
  i_country_name VARCHAR (100),
  i_state_name CHAR(128),
  i_city_name VARCHAR(300),
  i_postal_code CHAR (10),
  i_street_address VARCHAR (100),
  i_address_line_2 VARCHAR (100),
)
LANGUAGE plpgsql AS
$$
DECLARE 
i_country_id INT;
i_state_id INT;
i_city_id INT;

BEGIN
  i_country_id := get_country_id_by_name(i_country_name);
  i_state_id := get_us_state_id_by_name(i_state_name);
  i_city_id := insert_city(i_city_name);
  IF NOT EXISTS (
    SELECT country_id, state_id, city_id, postal_code, street_address, address_line_2 
    FROM test_table 
    WHERE 
      country_id = i_country_id AND
      state_id = i_state_id AND
      city_id = i_city_id AND
      postal_code = i_postal_code AND
      street_address = i_street_address AND
      address_line_2 = i_address_line_2
    ) THEN
      WITH input_rows(
        country_id,
        state_id,
        city_id,
        postal_code,     
        street_address,
        address_line_2
      ) AS (
        VALUES (
          i_country_id,
          i_state_id,
          i_city_id,
          i_postal_code,
          i_street_address,
          i_address_line_2
          )
      ),
      ins AS (
        INSERT INTO test_table (country_id, state_id, city_id, postal_code, street_address, address_line_2)
        SELECT * FROM input_rows
        ON CONFLICT (country_id, state_id, city_id, postal_code, street_address, address_line_2) DO NOTHING
        RETURNING id into return_id      
      )
      SELECT id   
      FROM ins
      UNION ALL
      SELECT t.id
      FROM input_rows
      JOIN test_table t USING (country_id, state_id, city_id, postal_code, street_address, address_line_2);
  else
    SELECT INTO return_id id FROM test_table WHERE 
      country_id = i_country_id AND
      state_id = i_state_id AND
      city_id = i_city_id AND
      postal_code = i_postal_code AND
      street_address = i_street_address AND
      address_line_2 = i_address_line_2
      ;
end if;
END
$$;