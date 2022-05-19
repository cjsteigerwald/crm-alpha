CREATE OR REPLACE FUNCTION getAllClothes() 
RETURNS TABLE (
  id INT,
  name VARCHAR,
  city VARCHAR,
  color VARCHAR,
  price INT

)
LANGUAGE SQL
AS $$
SELECT * FROM clothes;
$$;