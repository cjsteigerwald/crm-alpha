-- DROP FUNCTION insert_person;





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