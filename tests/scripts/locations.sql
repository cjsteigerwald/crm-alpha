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

SELECT plan(22);
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

-- insert_location
SELECT has_function('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'insert_location exists');

SELECT function_returns('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'integer', 'insert_location returns integer');

SELECT function_lang_is('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'plpgsql', 'insert_location is plpgsql');

SELECT has_function('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'insert_location exists');

SELECT function_returns('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'integer', 'insert_location returns integer');

SELECT function_lang_is('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'plpgsql', 'insert_location is plpgsql');

-- get_location_id
SELECT has_function('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'get_location_id exists');

SELECT has_function('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'update_location exists');

SELECT has_function('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'update_location exists');

SELECT has_function('delete_location', ARRAY [
  'integer'
], 'delete_location exists');

SELECT * FROM finish();
ROLLBACK

