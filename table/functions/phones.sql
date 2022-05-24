CREATE OR REPLACE FUNCTION insertPhone(
  i_id INOUT INT,
  i_country_code CHAR(1),
  i_area_code CHAR(3),
  i_phone_number CHAR(7)
)
LANGUAGE plpgsql AS
$$
BEGIN
  IF NOT EXISTS (SELECT i_country_code, i_area_code, i_phone_number 
    FROM phones 
    WHERE 
    i_country_code = country_code AND
    i_area_code = area_code AND
    i_phone_number = phone_number
    ) THEN
    WITH input_rows(country_code, area_code, phone_number) AS (
      VALUES (i_country_code, i_area_code, i_phone_number)
    ),
    ins AS (
      INSERT INTO phones (country_code, area_code, phone_number)
      SELECT * FROM input_rows
      ON CONFLICT (country_code, area_code, phone_number) DO NOTHING
      RETURNING id into i_id, country_code      
    )
    SELECT id, country_code, area_code, phone_number   
    FROM ins
    UNION ALL
    SELECT p.id, p.country_code, p.area_code, p.phone_number
    FROM input_rows
    JOIN phones p USING (country_code, area_code, phone_number);
  else
    SELECT INTO i_id id FROM phones WHERE i_phone = phone;
end if;
END
$$;