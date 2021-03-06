-- Trigger BEFORE INSERT to normalize data --

-- CREATE OR REPLACE FUNCTION process_department_insert()
--   RETURNS TRIGGER AS $process_department$
--   BEGIN
--     IF (TG_OP = 'INSERT') THEN
--       NEW.name := initcap(NEW.name);
--       RETURN NEW;
--     ELSEIF (TG_OP = 'UPDATE') THEN
--       NEW.name := initcap(NEW.name);
--       RETURN NEW;
--     END IF;
--   end;
--   $process_department$ LANGUAGE plpgsql;

--   CREATE OR REPLACE TRIGGER process_department
--   BEFORE INSERT OR UPDATE OR DELETE ON departments
--     FOR EACH ROW EXECUTE FUNCTION process_department_insert();


-- CREATE OR REPLACE FUNCTION insert_department(
--   OUT return_id INT,
--   i_department_name VARCHAR (300)
-- )
-- LANGUAGE plpgsql AS
-- $$
-- DECLARE
--   n_department_name VARCHAR(300);
-- BEGIN
-- n_department_name := initcap(i_department_name);
--   IF NOT EXISTS (SELECT n_department_name  
--     FROM departments 
--     WHERE 
--       n_department_name = name
--     ) THEN
--       WITH input_rows(name) AS (
--         VALUES (i_department_name)
--       ),
--       ins AS (
--         INSERT INTO departments (name)
--         SELECT * FROM input_rows
--         ON CONFLICT (name) DO NOTHING
--         RETURNING id into return_id      
--       )
--       SELECT id   
--       FROM ins
--       UNION ALL
--       SELECT d.id
--       FROM input_rows
--       JOIN departments d USING (name);
--   else
--     SELECT INTO return_id id FROM departments WHERE 
--       n_department_name = name;
-- end if;
-- END
-- $$;

