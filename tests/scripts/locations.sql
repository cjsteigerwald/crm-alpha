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

SELECT plan(18);
SELECT has_table('locations');
SELECT col_not_null('locations', 'id');
SELECT col_not_null('locations', 'country_id');
SELECT col_not_null('locations', 'state_id');
SELECT has_column('locations', 'county_name');
SELECT col_not_null('locations', 'city_id');
SELECT col_not_null('locations', 'postal_code');
SELECT col_not_null('locations', 'street_address');
SELECT col_has_default('locations', 'address_line_2');
SELECT has_column('locations', 'address_line_3');
-- Keys
SELECT col_is_pk('locations', 'id');
-- Constrains
SELECT col_is_unique('locations', ARRAY['country_id', 'state_id', 'city_id', 'postal_code', 'street_address',  'address_line_2']);

-- SELECT * FROM finish();
-- ROLLBACK;

-- #####################################
-- 2. FUNCTION TEST
-- #####################################
SELECT has_function('insert_location', ARRAY [
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'VARCHAR'
], 'insert_location exists');

SELECT has_function('insert_location', ARRAY [
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'CHAR',
  'VARCHAR'
], 'insert_location exists');

SELECT has_function('get_location_id', ARRAY [
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'VARCHAR'
], 'get_location_id exists');

SELECT has_function('update_location', ARRAY [
  'INT',
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'VARCHAR'
], 'update_location exists');

SELECT has_function('update_location', ARRAY [
  'INT',
  'VARCHAR',
  'CHAR',
  'VARCHAR',
  'CHAR',
  'VARCHAR'
], 'update_location exists');

SELECT has_function('delete_location', ARRAY [
  'INT'
], 'delete_location exists');

SELECT * FROM finish();
ROLLBACK

