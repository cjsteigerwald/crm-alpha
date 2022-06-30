-- #####################################
-- PHONES
-- #####################################

-- Documentation for PGTap can be found:
-- https://pgtap.org/documentation.html
-- CREATE EXTENSION IF NOT EXISTS pgtap;

-- Turn off echo and keep things quiet.
\unset ECHO
\set QUIET 1


-- Format the output for nice TAP.
\pset format unaligned
\pset tuples_only true
\pset pager off

-- Revert all changes on failure.
\set ON_ERROR_ROLLBACK 1
\set ON_ERROR_STOP true

-- #####################################
-- 1. TABLE TEST
-- #####################################
BEGIN;

SELECT plan(8);
SELECT has_table('phones');
SELECT col_not_null('phones', 'id');
SELECT col_not_null('phones', 'country_code');
SELECT col_not_null('phones', 'area_code');
SELECT col_not_null('phones', 'phone_number');
-- Keys
SELECT col_is_pk('phones', 'id');
-- Constraints
SELECT col_has_default('phones', 'country_code', 'phones:country_code has default value');
SELECT col_is_unique('phones', ARRAY['country_code', 'area_code', 'phone_number']);

-- #####################################
-- 2. FUNCTION TEST
-- #####################################
Seed data for function tests
\set country_code 1
\set area_code 9
\set phone_number 9999999

-- -- Test 5. function exists
-- SELECT has_function('insert_city', ARRAY [
--   'character varying'
-- ], 'insert_city exists');

-- -- Test 6. verify function returns integer
-- SELECT function_returns('insert_city', ARRAY [
--   'character varying'
-- ], 'integer', 'insert_city returns integer');

-- -- Test 7. verify function language
-- SELECT function_lang_is('insert_city', ARRAY [
--   'character varying'
-- ], 'plpgsql', 'insert_city is plpgsql');

-- -- Test 8. insert returns integer on success
-- SELECT matches (
--   insert_city(
--     :city_name
--   )::TEXT, '^0*[0-9]\d*$',
--   'insert_city eturn integer greter then 0');

-- -- Test 9. verify data in phones table is inserted
-- SELECT is(
--   name,
--   :city_name,
--   'insert_phones verify insert'
-- ) FROM phones
-- WHERE
--   name = :city_name;

SELECT * FROM finish();
ROLLBACK
