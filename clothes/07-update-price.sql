CREATE OR REPLACE PROCEDURE updatePrice (
  u_id INT,  
  u_price INT
)
LANGUAGE plpgsql AS
$$
BEGIN
  UPDATE clothes SET 
  price = u_price
  WHERE id = u_id;
END
$$;