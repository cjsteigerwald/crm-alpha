-- Trigger BEFORE INSERT to normalize data --

-- CREATE OR REPLACE FUNCTION process_city_insert()
--   RETURNS TRIGGER AS $process_city$
--   BEGIN
--     IF (TG_OP = 'INSERT') THEN
--       NEW.name := initcap(NEW.name);
--       RETURN NEW;
--     ELSEIF (TG_OP = 'UPDATE') THEN
--       NEW.name := initcap(NEW.name);
--       RETURN NEW;
--     END IF;
--   end;
--   $process_city$ LANGUAGE plpgsql;

--   CREATE OR REPLACE TRIGGER process_city
--   BEFORE INSERT OR UPDATE OR DELETE ON cities
--     FOR EACH ROW EXECUTE FUNCTION process_city_insert();


-- DROP FUNCTION insert_city;
-- CREATE OR REPLACE FUNCTION insert_city(
--     city_name VARCHAR (300)
--   )
-- LANGUAGE plpgsql AS 
-- $$
-- -- DECLARE new_name VARCHAR(300)
-- BEGIN
-- --  city_name := initcap(city_name);
--   INSERT INTO cities(name) VALUES(initcap(city_name));
-- END
-- $$;


-- CREATE OR REPLACE FUNCTION insert_city(
--   i_id INOUT INT,
--   i_city_name VARCHAR (300)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- DECLARE
--   n_city_name VARCHAR(300);
-- BEGIN
-- n_city_name := initcap(i_city_name);
--   IF NOT EXISTS (SELECT n_city_name  
--     FROM cities 
--     WHERE 
--       n_city_name = name
--     ) THEN
--       WITH input_rows(name) AS (
--         VALUES (i_city_name)
--       ),
--       ins AS (
--         INSERT INTO cities (name)
--         SELECT * FROM input_rows
--         ON CONFLICT (name) DO NOTHING
--         RETURNING id into i_id      
--       )
--       SELECT id   
--       FROM ins
--       UNION ALL
--       SELECT c.id
--       FROM input_rows
--       JOIN cities c USING (name);
--   else
--     SELECT INTO i_id id FROM cities WHERE 
--       n_city_name = name;
-- end if;
-- END
-- $$;

