-- CREATE OR REPLACE PROCEDURE AddClothes (
--   c_id INOUT INT,
--   c_name VARCHAR(100),
--   c_city VARCHAR(100),
--   c_color VARCHAR(100),
--   c_price INT,
--   c_phone VARCHAR(10)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- DECLARE
--   phone_id INT;
-- BEGIN
--   phone_id := addPhones(null, c_phone);
--   INSERT INTO clothes (name, city, color, price, phone) 
--   VALUES (c_name, c_city, c_color, c_price, phone_id)
--   RETURNING id INTO c_id;
-- END
-- $$;



-- CREATE OR REPLACE FUNCTION addPhones(
--   c_id INOUT INT,
--   c_phone VARCHAR(10)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- BEGIN
--   IF NOT EXISTS (SELECT c_phone FROM phones WHERE c_phone = phone) THEN
--     WITH input_rows(phone) AS (
--       VALUES (c_phone)
--     ),
--     ins AS (
--       INSERT INTO phones (phone)
--       SELECT * FROM input_rows
--       ON CONFLICT (phone) DO NOTHING
--       RETURNING id into c_id
--     )
--     SELECT id   
--     FROM ins
--     UNION ALL
--     SELECT p.id
--     FROM input_rows
--     JOIN phones p USING (phone);
--   else
--     SELECT INTO c_id id FROM phones WHERE c_phone = phone;
-- end if;
-- END
-- $$;

-- CREATE OR REPLACE FUNCTION addPhones(
--   c_id INOUT INT,
--   c_phone VARCHAR(10)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- BEGIN
--   INSERT INTO phones (phone)
--   VALUES (c_phone)
--   ON CONFLICT (phone) DO NOTHING
--   RETURNING id INTO c_id;
-- END
-- $$;

-- DROP PROCEDURE AddClothes (
--   c_id INOUT INT,
--   c_name VARCHAR(100),
--   c_city VARCHAR(100),
--   c_color VARCHAR(100),
--   c_price INT
-- )




-- DROP PROCEDURE AddClothes (
--   c_id INOUT INT,
--   c_name VARCHAR(100),
--   c_city VARCHAR(100),
--   c_color VARCHAR(100),
--   c_price INT,
--   c_phone VARCHAR(10)
-- );

-- DROP FUNCTION addPhones(
--   c_id INOUT INT,
--   c_phone VARCHAR(10)
-- );