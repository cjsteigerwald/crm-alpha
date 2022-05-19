-- CREATE OR REPLACE PROCEDURE AddClothes (
--   c_id INOUT INT,
--   c_name VARCHAR(100),
--   c_city VARCHAR(100),
--   c_color VARCHAR(100),
--   c_price INT
-- )
-- LANGUAGE plpgsql AS
-- $$
-- BEGIN
--   INSERT INTO clothes (name, city, color, price) 
--   VALUES (c_name, c_city, c_color, c_price)
--   RETURNING id INTO c_id;
-- END
-- $$;

CREATE OR REPLACE PROCEDURE addPhone(
  c_id INOUT INT,
  c_phone VARCHAR(10)
)
LANGUAGE plpgsql AS
$$
BEGIN
  INSERT INTO phones (phone)
  VALUES (c_phone)
  RETURNING id INTO c_id;
END
$$;