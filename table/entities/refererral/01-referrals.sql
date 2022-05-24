DROP TABLE IF EXISTS referrals;

CREATE TABLE IF NOT EXISTS referrals (
  id SERIAL PRIMARY KEY,
  client_id INT REFERENCES clients (id) NOT NULL,
  medical_professional_id INT  REFERENCES medical_professionals (id) NOT NULL,
  UNIQUE (client_id, medical_professional_id)
);