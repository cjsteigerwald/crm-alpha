-- DROP FUNCTION insert_person;


-- CREATE OR REPLACE FUNCTION delete_person(
--   i_id INT
-- )
-- RETURNS BOOLEAN
--  AS
-- $$
-- BEGIN
--   DELETE FROM persons
--   WHERE id = i_id;
--   RETURN FOUND;
-- END;
-- $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_person(
  i_id INT,
  i_first_name VARCHAR(200),
  i_middle_name VARCHAR(200),
  i_last_name VARCHAR(200),
  i_suffix_name VARCHAR(200),
  i_sex sex_status
)
  RETURNS BOOLEAN
  AS
  $$
  BEGIN
    -- IF EXISTS (SELECT p.id FROM persons AS p WHERE p.id = i_id) THEN
      UPDATE persons
      SET
        first_name = COALESCE(i_first_name, first_name),
        middle_name = COALESCE(i_middle_name, middle_name),
        last_name = COALESCE(i_last_name, last_name),
        sex = COALESCE(i_sex, sex)
      WHERE id = i_id; 
      RETURN FOUND;
    -- ELSE
    --   raise notice 'In: %', 'ELSE';
    --   RETURN FALSE;
    -- END IF;
    
      EXCEPTION
      WHEN unique_violation THEN
          -- RAISE NOTICE 'Unique violation';
          RETURN FALSE;
  END;
$$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION get_person_id(
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200)
-- )
-- RETURNS INT
--  AS
-- $$
-- BEGIN
--   RETURN (SELECT get_person_id(
--     i_first_name,
--     i_middle_name,
--     i_last_name,
--     ''
--   ));
-- END;
-- $$ LANGUAGE plpgsql;


-- DROP FUNCTION get_all_persons;
-- CREATE OR REPLACE FUNCTION get_all_persons()
--   RETURNS TABLE (
--     id INT,
--       first_name VARCHAR(200),
--       middle_name VARCHAR(200),
--       last_name VARCHAR(200),
--       suffix_name VARCHAR(200),
--       sex sex_status
--   )
--   AS
--   $$
--   BEGIN
--     RETURN QUERY (SELECT p.id, p.first_name, p.middle_name, p.last_name, p.suffix_name, p.sex
--             FROM persons AS p          
--     );
--   END;
-- $$ LANGUAGE plpgsql;


-- DROP FUNCTION get_person_by_id;

-- CREATE OR REPLACE FUNCTION get_person_by_id(
--   i_id INT
-- )
-- RETURNS TABLE (
--   id INT,
--     first_name VARCHAR(200),
--     middle_name VARCHAR(200),
--     last_name VARCHAR(200),
--     suffix_name VARCHAR(200),
--     sex sex_status
-- )
--  AS
-- $$
-- BEGIN
--   RETURN QUERY (SELECT p.id, p.first_name, p.middle_name, p.last_name, p.suffix_name, p.sex
--           FROM persons AS p
--           WHERE          
--             p.id = i_id
--   );
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION get_person_id(
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200)
-- )
-- RETURNS INT
--  AS
-- $$
-- BEGIN
--   RETURN (SELECT get_person_id(
--     i_first_name,
--     i_middle_name,
--     i_last_name,
--     ''
--   ));
-- END;
-- $$ LANGUAGE plpgsql;



-- CREATE OR REPLACE FUNCTION get_person_id(
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200),
--   i_suffix_name VARCHAR(200)
-- )
-- RETURNS INT
--  AS
-- $$
-- BEGIN
--   RETURN (SELECT id
--           FROM persons
--           WHERE          
--             first_name = INITCAP(i_first_name) AND
--             middle_name = INITCAP(i_middle_name) AND
--             last_name = INITCAP(i_last_name) AND
--             suffix_name = INITCAP(i_suffix_name)
--   );
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION get_person_id(
--   i_first_name VARCHAR(200),
--   i_middle_name VARCHAR(200),
--   i_last_name VARCHAR(200)
-- )
-- RETURNS INT
--  AS
-- $$
-- BEGIN
--   RETURN (SELECT get_person_id(
--     i_first_name,
--     i_middle_name,
--     i_last_name,
--     ''
--   ));
-- END;
-- $$ LANGUAGE plpgsql;





-- Trigger BEFORE INSERT to normalize data --
-- CREATE OR REPLACE FUNCTION capitalize_person_names()
--   RETURNS TRIGGER AS $process_city$
--   BEGIN
--     NEW.first_name := INITCAP(NEW.first_name);
--     NEW.middle_name := INITCAP(NEW.middle_name);
--     NEW.last_name := INITCAP(NEW.last_name);
--     RETURN NEW;
--   END;
--   $process_city$ LANGUAGE plpgsql;

--   CREATE OR REPLACE TRIGGER process_person_name
--     BEFORE INSERT OR UPDATE OF first_name, middle_name, last_name
--     ON persons
--     FOR EACH ROW EXECUTE FUNCTION capitalize_person_names();




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