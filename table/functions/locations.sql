-- DROP FUNCTION insert_location;

CREATE OR REPLACE FUNCTION insert_location(
  i_id INOUT INT,
  i_country_name VARCHAR (100),
  i_state_name CHAR(128),
  i_county_name VARCHAR DEFAULT NULL,
  i_city_name VARCHAR(300),
  i_department_name VARCHAR (300) DEFAULT NULL,
  i_postal_code CHAR (10),
  i_street_address VARCHAR (100)
  i_premise VARCHAR (50) DEFAULT '',
  i_sub_premise_name VARCHAR (50) DEFAULT NULL
LANGUAGE plpgsql AS
$$
BEGIN
  IF NOT EXISTS (SELECT i_street_address, i_postal_code, i_premise 
    FROM locations 
    WHERE 
      i_street_address = thoroughfare AND
      i_postal_code = postal_code AND
      i_premise  = premise
    ) THEN
      WITH input_rows(
        country_id,
        administrative_area,
        sub_administrative_area,
        locality,
        dependent_locality,
        
      ) AS (
        VALUES (i_country_code, i_area_code, i_phone_number)
      ),
      ins AS (
        INSERT INTO phones (country_code, area_code, phone_number)
        SELECT * FROM input_rows
        ON CONFLICT (country_code, area_code, phone_number) DO NOTHING
        RETURNING id into i_id      
      )
      SELECT id   
      FROM ins
      UNION ALL
      SELECT p.id
      FROM input_rows
      JOIN phones p USING (country_code, area_code, phone_number);
  else
    SELECT INTO i_id id FROM phones WHERE 
      i_country_code = country_code AND
      i_area_code = area_code AND
      i_phone_number = phone_number;
end if;
END
$$;