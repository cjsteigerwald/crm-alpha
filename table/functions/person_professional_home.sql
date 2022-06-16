-- DROP FUNCTION get_person_id_by_professional_phone_id;

-- update with new phone number return true if success, else false
CREATE OR REPLACE FUNCTION update_person_professional_phone(
  i_id INT,
  i_country_code CHAR (1),
  i_area_code CHAR (3),
  i_phone_number CHAR (7)
)
  RETURNS BOOLEAN
  AS $$
  DECLARE
    i_phone_id INT := insert_phone(i_country_code, i_area_code, i_phone_number);
  BEGIN  
      UPDATE person_professional_phone AS p
      SET phone_id = COALESCE(i_phone_id, p.phone_id)
      WHERE p.id = i_id;
      RETURN FOUND;
      EXCEPTION
        WHEN unique_violation THEN
            -- RAISE NOTICE 'Unique violation';
        RETURN FALSE;
  END
$$ LANGUAGE plpgsql;

-- return TRUE if record deleted, else false
CREATE OR REPLACE FUNCTION delete_person_professional_phone(
  i_id INT
)
  RETURNS BOOLEAN
  AS $$
  BEGIN  
      DELETE FROM person_professional_phone AS p
      WHERE p.id = i_id;
      RETURN FOUND;
  END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_person_professional_phone(
  i_person_id INT,
  i_phone_id INT
)
  RETURNS BOOLEAN
  AS $$
  BEGIN  
      DELETE FROM person_professional_phone AS p
      WHERE p.person_id = i_person_id AND
            p.phone_id = i_phone_id;
      RETURN FOUND;
  END
$$ LANGUAGE plpgsql;


-- -- returns person_id if phone_id found, else NULL
-- CREATE OR REPLACE FUNCTION get_person_id_by_professional_phone_id(
--   i_phone_id INT
-- )
--   RETURNS INT
--   AS $$
--   BEGIN
--   RETURN (
--         SELECT p.person_id
--     FROM person_professional_phone AS p
--     WHERE p.phone_id = i_phone_id
--   );

--   END
-- $$ LANGUAGE plpgsql;

-- -- returns table of phone numbers associated with person_id
-- CREATE OR REPLACE FUNCTION get_professional_phone_by_person_id(
--   i_person_id INT
-- )
--   RETURNS TABLE (person_id INT, phone_id INT)
--   AS $$
--   -- DECLARE 
--   --   var_r record;
--   BEGIN
--     -- for var_r IN (
--     --   SELECT p.person_id, p.phone_id
--     --   FROM   person_professional_phone AS p
--     --   WHERE p.person_id = i_person_id
--     -- ) LOOP 
--     --     person_id := var_r.person_id;
--     --     phone_id := var_r.phone_id;
--     --     return next;
--     --   END LOOP;
--   RETURN QUERY (
--         SELECT p.person_id, p.phone_id
--     FROM person_professional_phone AS p
--     WHERE p.person_id = i_person_id
--   );
-- END
-- $$ LANGUAGE plpgsql;

-- DROP FUNCTION insert_person_professional_phone;

-- On successful insertion return TRUE, else FALSE

-- CREATE OR REPLACE FUNCTION insert_person_professional_phone(
--   i_person_id INT,
--   i_phone_id INT
-- )
--   RETURNS BOOLEAN
--   AS $$
--   BEGIN
--   IF EXISTS (SELECT id FROM persons WHERE id = i_person_id AND
--   (SELECT EXISTS (SELECT id FROM phones WHERE id = i_phone_id))) THEN
--     INSERT INTO person_professional_phone (person_id, phone_id) 
--     VALUES (i_person_id, i_phone_id);
--     RETURN TRUE;
--   ELSE
--     RETURN FALSE;
--   END IF;
--   EXCEPTION
--         WHEN unique_violation THEN
--             -- RAISE NOTICE 'Unique violation';
--             RETURN FALSE;
--   END
-- $$ LANGUAGE plpgsql;

