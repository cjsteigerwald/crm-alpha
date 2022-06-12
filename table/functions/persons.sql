-- DROP FUNCTION insert_person;

-- Trigger BEFORE INSERT to normalize data --
CREATE OR REPLACE FUNCTION capitalize_person_names()
  RETURNS TRIGGER AS $process_city$
  BEGIN
    NEW.first_name := INITCAP(NEW.first_name);
    NEW.middle_name := INITCAP(NEW.middle_name);
    NEW.last_name := INITCAP(NEW.last_name);
    RETURN NEW;
  END;
  $process_city$ LANGUAGE plpgsql;

  CREATE OR REPLACE TRIGGER process_person_name
    BEFORE INSERT OR UPDATE OF first_name, middle_name, last_name
    ON persons
    FOR EACH ROW EXECUTE FUNCTION capitalize_person_names();




-- CREATE OR REPLACE FUNCTION insert_person(
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200),
--   i_suffix_name VARCHAR(200)
-- )
-- RETURNS INT
--  AS
-- $$
-- BEGIN
--   RETURN (SELECT insert_person(
--     i_first_name,
--     i_middle_name,
--     i_last_name,
--     i_suffix_name,
--     'unknown'
--   ));
-- END;
-- $$ LANGUAGE plpgsql;

-- DROP FUNCTION insert_person(
--   OUT return_id INT,
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200),
--   i_suffix_name VARCHAR(200),
--   i_sex sex_status
-- );

-- CREATE OR REPLACE FUNCTION insert_person(
--   OUT return_id INT,
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200),
--   i_suffix_name VARCHAR(200),
--   i_sex sex_status
-- )
-- LANGUAGE plpgsql AS
-- $$
-- BEGIN
--   IF NOT EXISTS (
--     SELECT first_name, middle_name, last_name, suffix_name
--     FROM persons
--     WHERE 
--       first_name = i_first_name AND
--       middle_name = i_middle_name AND
--       last_name = i_last_name AND
--       suffix_name = i_suffix_name
--     ) THEN
--       WITH input_rows(
--         first_name,
--         middle_name,
--         last_name,
--         suffix_name,     
--         sex
--       ) AS (
--         VALUES (
--           i_first_name,
--           i_middle_name,
--           i_last_name,
--           i_suffix_name,
--           i_sex
--           )
--       ),
--       ins AS (
--         INSERT INTO persons (first_name, middle_name, last_name, suffix_name, sex)
--         SELECT * FROM input_rows
--         ON CONFLICT (first_name, middle_name, last_name, suffix_name) DO NOTHING
--         RETURNING id into return_id      
--       )
--       SELECT id   
--       FROM ins
--       UNION ALL
--       SELECT p.id
--       FROM input_rows
--       JOIN persons p USING (first_name, middle_name, last_name, suffix_name);
--   else
--     SELECT INTO return_id id FROM persons WHERE 
--       first_name = i_first_name AND
--       middle_name = i_middle_name AND
--       last_name = i_last_name AND
--       suffix_name = i_suffix_name;
-- end if;
-- END
-- $$;