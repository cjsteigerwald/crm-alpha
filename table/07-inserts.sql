BEGIN TRANSACTION;
DECLARE _email_id INT;
DECLARE _phone_id INT;

INSERT INTO emails (user_name, domain_name, extension)
VALUES ('test', 'testing', 'com');

SET _email_id = SCOPE_IDENTITY();

INSERT INTO phones (country_code, area_code, phone_number, phone_type)
VALUES ('1', '123', '456', '7890', 'home');

SET _phone_id = SCOPE_IDENTITY();

INSERT INTO persons (first_name, last_name, location, phone_home, email_personal)
VALUES (
  'chris',
  'steigerwald',
  1,
  @phone_id,
  @email_id
)
COMMIT TRANSACTION;

WITH new_person A(
  user_name, domain_name, extension,
  country_code, area_code, phone_number, phone_type
);