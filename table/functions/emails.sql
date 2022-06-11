-- DROP FUNCTION insert_email;

-- get_email_id returns email id if found, else NULL
-- CREATE OR REPLACE FUNCTION get_email_id(
--   i_username VARCHAR (300) DEFAULT NULL,
--   i_domain_name VARCHAR (300) DEFAULT NULL,
--   i_extension VARCHAR (300) DEFAULT NULL
-- ) RETURNS INT
-- LANGUAGE plpgsql SECURITY DEFINER AS
-- $$
-- BEGIN
--   RETURN (SELECT id    
--     FROM emails
--     WHERE 
--       username = i_username AND
--       domain_name = i_domain_name AND
--       extension = i_extension
--   );
-- END
-- $$;



-- CREATE OR REPLACE FUNCTION insert_email(
--   i_id OUT INT,
--   i_username VARCHAR (300),
--   i_domain_name VARCHAR (300),
--   i_extension VARCHAR (300)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- BEGIN
--   IF NOT EXISTS (SELECT i_username, i_domain_name, i_extension 
--     FROM emails 
--     WHERE 
--       i_username = username AND
--       i_domain_name = domain_name AND
--       i_extension = extension
--     ) THEN
--       WITH input_rows(username, domain_name, extension) AS (
--         VALUES (i_username, i_domain_name, i_extension)
--       ),
--       ins AS (
--         INSERT INTO emails (username, domain_name, extension)
--         SELECT * FROM input_rows
--         ON CONFLICT (username, domain_name, extension) DO NOTHING
--         RETURNING id into i_id      
--       )
--       SELECT id   
--       FROM ins
--       UNION ALL
--       SELECT e.id
--       FROM input_rows
--       JOIN emails e USING (username, domain_name, extension);
--   else
--     SELECT INTO i_id id FROM emails WHERE 
--       i_username = username AND
--       i_domain_name = domain_name AND
--       i_extension = extension;
-- end if;
-- END
-- $$;

-- DROP FUNCTION update_email;

-- CREATE OR REPLACE FUNCTION update_email(
--   id INT,
--   username VARCHAR (300) DEFAULT NULL,
--   domain_name VARCHAR (300) DEFAULT NULL,
--   extension VARCHAR (300) DEFAULT NULL
-- ) RETURNS BOOLEAN
-- LANGUAGE plpgsql SECURITY DEFINER AS
-- $$
-- BEGIN
--   UPDATE emails
--   SET 
--     username = COALESCE(update_email.username, emails.username), 
--     domain_name = COALESCE(update_email.domain_name, emails.domain_name), 
--     extension = COALESCE(update_email.extension, emails.extension)
--   WHERE emails.id = update_email.id;
--   RETURN FOUND;
-- END
-- $$;

-- CREATE OR REPLACE FUNCTION delete_email(id INT)
--   RETURNS BOOLEAN
--   LANGUAGE plpgsql SECURITY DEFINER AS
--   $$
--   BEGIN
--     DELETE FROM emails
--     WHERE emails.id = delete_email.id;
--     RETURN FOUND;
--   END
--   $$;