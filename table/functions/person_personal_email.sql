

-- update with new phone number return true if success, else false
CREATE OR REPLACE FUNCTION update_person_personal_email(
  i_id INT,
  i_username VARCHAR (300),
  i_domain_name VARCHAR (300),
  i_extension VARCHAR (300)

  RETURNS BOOLEAN
  AS $$
  DECLARE
    i_phone_id INT := insert_phone(i_country_code, i_area_code, i_phone_number);
  BEGIN  
      UPDATE person_home_phone AS p
      SET phone_id = COALESCE(i_phone_id, p.phone_id)
      WHERE p.id = i_id;
      RETURN FOUND;
      EXCEPTION
        WHEN unique_violation THEN
            -- RAISE NOTICE 'Unique violation';
        RETURN FALSE;
  END
$$ LANGUAGE plpgsql;


-- returns table of emails associated with id, if none empty table
-- CREATE OR REPLACE FUNCTION get_person_id_by_email_id(
--   i_email_id INT
-- )
--   RETURNS TABLE (person_id INT, email_id INT)
--   AS $$
--   BEGIN
--     RETURN QUERY (
--       SELECT e.person_id, e.email_id
--       FROM person_personal_email AS e
--       WHERE e.email_id = i_email_id
--     );
--   END
-- $$ LANGUAGE plpgsql;


-- returns table of emails associated with id, if none empty table
-- CREATE OR REPLACE FUNCTION get_personal_email_by_person_id(
--   i_person_id INT
-- )
--   RETURNS TABLE (person_id INT, email_id INT)
--   AS $$
--   BEGIN
--     RETURN QUERY (
--       SELECT e.person_id, e.email_id
--       FROM person_personal_email AS e
--       WHERE e.person_id = i_person_id
--     );
--   END
-- $$ LANGUAGE plpgsql;

-- On successful insertion return TRUE, else FALSE
-- CREATE OR REPLACE FUNCTION insert_person_personal_email(
--   i_person_id INT,
--   i_email_id INT
-- )
--   RETURNS BOOLEAN
--   AS $$
--   BEGIN
--   IF EXISTS (SELECT id FROM persons WHERE id = i_person_id AND
--   (SELECT EXISTS (SELECT id FROM emails WHERE id = i_email_id))) THEN
--     INSERT INTO person_personal_email (person_id, email_id) 
--     VALUES (i_person_id, i_email_id);
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