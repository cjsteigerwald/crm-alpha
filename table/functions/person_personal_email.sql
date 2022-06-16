-- On successful insertion return TRUE, else FALSE
CREATE OR REPLACE FUNCTION insert_person_personal_email(
  i_person_id INT,
  i_email_id INT
)
  RETURNS BOOLEAN
  AS $$
  BEGIN
  IF EXISTS (SELECT id FROM persons WHERE id = i_person_id AND
  (SELECT EXISTS (SELECT id FROM emails WHERE id = i_email_id))) THEN
    INSERT INTO person_personal_email (person_id, email_id) 
    VALUES (i_person_id, i_email_id);
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
  EXCEPTION
        WHEN unique_violation THEN
            -- RAISE NOTICE 'Unique violation';
            RETURN FALSE;
  END
$$ LANGUAGE plpgsql;