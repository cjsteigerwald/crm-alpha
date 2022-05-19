CREATE OR REPLACE PROCEDURE UpdateClothes (
  u_id INT,
  u_name VARCHAR(100),
  u_city VARCHAR(100),
  u_color VARCHAR(100),
  u_price INT
)
LANGUAGE plpgsql AS
$$
BEGIN
  UPDATE clothes SET
  name = u_name,
  city = u_city,
  color = u_color,
  price = u_price
  WHERE id = u_id;
END
$$;